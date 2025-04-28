/*
 * ThreadHive.h
 *
 *  Created on: Mar 4, 2016
 *      Author: Aaron
 */

#ifndef THREADHIVE_H_
#define THREADHIVE_H_
#include <mutex>
#include <thread>
#include <string>
#include <iterator>
#include <vector>
#include <iostream>
#include <fstream>
#include <sstream>
#include <iomanip>
namespace thive
{

	template <class S>
	class PredicateFunctor;
	template <class T>
	class ThreadHive;
	template <class T>
	class ThreadHandle;
	template <class T>
	class HiveQueue;
	template <class T>
	class HiveQueueC;
	class ArmaElement;
	class ArmaData;
	class ArmaMessage;
	class ArmaArray;
	class ErrorFile;

	typedef std::vector<ArmaElement *> * ARMA_ARRAY;

	class ErrorFile
	{
	private:
		const char * fileName;
		const char * errorMark;
		bool isCerr;
		bool isOpen;
		std::ofstream outFile;
	public:
		ErrorFile()
		{
			this->isCerr = true;
			this->isOpen = true;
			this->fileName = "";
			this->errorMark = "";
		}
		ErrorFile(const char * fileName, const bool stayOpen)
		{
			this->isCerr = false;
			this->isOpen = stayOpen;
			this->fileName = fileName;
			this->errorMark = "";
			outFile.open(fileName, std::ofstream::out | std::ofstream::trunc);
			outFile.close();
			outFile.open(fileName, std::ofstream::out | std::ofstream::app);
			if (!stayOpen)
			{
				outFile.close();
			}
		}
		ErrorFile(const char * fileName, const char * errorMark, const bool stayOpen) : ErrorFile(fileName, stayOpen)
		{
			//ErrorFile(fileName, stayOpen);
			this->SetErrorMark(errorMark);
		}
		~ErrorFile()
		{
			if (this->isOpen && !this->isCerr)
			{
				outFile.close();
			}
		}

		bool IsOpen()
		{
			return this->isOpen;
		}

		bool ClearFile()
		{
			if (this->isCerr)
			{
				return false;
			}

			if (this->isOpen)
			{
				outFile.close();
			}
			outFile.open(this->fileName, std::ofstream::out | std::ofstream::trunc);
			outFile.close();
			if (this->isOpen)
			{
				outFile.open(this->fileName, std::ofstream::out | std::ofstream::app);
			}
		}

		bool OpenFile()
		{
			if (this->isCerr)
			{
				return false;
			}

			if (this->isOpen)
			{
				outFile.close();
			}
			outFile.open(this->fileName, std::ofstream::out | std::ofstream::app);
			return true;
		}

		bool CloseFile()
		{
			if (this->isCerr)
			{
				return false;
			}
			if (this->isOpen)
			{
				outFile.close();
				return true;
			}
			return false;
		}

		void SetErrorMark(const char * errorMark)
		{
			this->errorMark = errorMark;
		}

		const char * GetErrorMark()
		{
			return this->errorMark;
		}

		void WriteError(const char * errorMsg)
		{
			if (this->isCerr)
			{
				std::cerr << this->errorMark << errorMsg << "\n";
			}
			else if (this->isOpen)
			{
				this->outFile << this->errorMark << errorMsg << "\n";
			}
			else
			{
				outFile.open(this->fileName, std::ofstream::out | std::ofstream::app);
				this->outFile << this->errorMark << errorMsg << "\n";
				outFile.close();
			}
		}

		void ThrowError(const char * errorMsg, const bool closePrg)
		{
			try
			{
				throw std::runtime_error(errorMsg);
			}
			catch (std::runtime_error & err)
			{
				this->WriteError(err.what());
				if (closePrg)
				{
					std::terminate();
				}
			}
		}
	};

	static thive::ErrorFile tHiveError("T_HIVE_ERROR.txt", "T_HIVE_ERROR: ", false);
	const char * parseErrorType = "ParseArmaData, could not parse data type";
	const char * parseErrorExpected = "ParseArmaData, more data expected";
	const char * parseErrorEnd = "ParseArmaData, end of array expected";


	template <class S>
	class PredicateFunctor
	{
	private:
		S * myTarget = nullptr;
		bool (S::*pt2Member)(void) = nullptr;
	public:
		PredicateFunctor() {}
		PredicateFunctor(S * target, bool (S::*pt2Member)(void))
		{
			this->myTarget = target;
			this->pt2Member = pt2Member;
		}
		~PredicateFunctor() {}

		bool operator() (void)
		{
			return  (this->myTarget->*pt2Member)();
		}
	};

	template <class T>
	class ThreadHandle
	{
		template <class T> friend class ThreadHive;
	private:
		unsigned int shares;
		HiveQueueC<T> * msgQueue;
		bool(*callBack)(ThreadHive<T> *, std::string *);
		std::thread * hiveThread;
		std::string * parameters;
		std::string threadName;
		std::mutex threadMutex;
		//std::mutex delMutex;
		std::condition_variable blocker;

		bool finished;
		bool success;
		bool running;

		ThreadHandle * next;
	public:
		ThreadHandle();
		explicit ThreadHandle(std::string & threadName);

		~ThreadHandle();
	};

	template <class T>
	class ThreadHive
	{
	private:
		static int i;
		static int threadCount;
		static ThreadHandle<T> * head;
		static ThreadHandle<T> * tail;
		static std::mutex hiveAccess;

		ThreadHandle<T> * myThreadHandle;
		T currentMsg;
		bool isMain;

		ThreadHandle<T> * push(std::string & threadName);
		bool loadMsg();
	public:
		ThreadHive();
		ThreadHive(int a);
		~ThreadHive();

		void operator()(void)
		{
			bool result;

			this->isMain = false;

			result = this->myThreadHandle->callBack(this, this->myThreadHandle->parameters);

			this->myThreadHandle->threadMutex.lock();
			this->myThreadHandle->finished = true;
			this->myThreadHandle->success = result;
			this->myThreadHandle->running = false;
			this->myThreadHandle->hiveThread->detach();
			delete (this->myThreadHandle->hiveThread);
			this->myThreadHandle->hiveThread = nullptr;
			this->myThreadHandle->threadMutex.unlock();

		}

		bool addThread(std::string & threadName, bool(*callBack)(ThreadHive *, std::string *), std::string * parameters);
		bool spawnThread();
		bool sendMsg(ThreadHandle<T> * th, T & msg);
		bool sendAll(ThreadHandle<T> * th, T * messages, unsigned int & size);
		bool receiveMsg(T & msg, bool blocking);
		bool receiveAll(T * & messages, unsigned int & size, bool blocking);
		bool isFinished(ThreadHandle<T> * th);
		bool isSuccess(ThreadHandle<T> * th);
		bool hasThread();
		bool isRunning(ThreadHandle<T> * th);
		ThreadHandle<T> * getThreadHandle(std::string & threadName);
		ThreadHandle<T> * getMyThreadHandle();
		void jdThread(ThreadHandle<T> * th);



		int increment();
		void displayI();

	};

	template <class T>
	class HiveQueue
	{
	private:
		struct Node
		{
			T msg;
			Node * next;
		};
		unsigned int count;
		Node * head;
		Node * tail;
	public:
		HiveQueue();
		~HiveQueue();

		bool push(T & msg);
		bool remove();
		bool peek(T & msg);
		bool pop(T & msg);
		unsigned int size();

	};

#define HQ_INIT_SIZE 50

	template <class T>
	class HiveQueueC
	{
	private:
		unsigned int count;
		unsigned int aSize;
		unsigned int tail;
		unsigned int head;
		T * queue;

	public:
		HiveQueueC();
		~HiveQueueC();

		bool push(T & msg);
		bool remove();
		bool peek(T & msg);
		bool pop(T & msg);
		bool grow(unsigned int newSize);
		unsigned int size();

	};

	/**parse arma data/message **/
	/******
	$ = string
	# = float
	+ = unsigned int
	- = signed int
	* = void * address - example is 32bit address - *FFFFFFFF
	@ = array - example is mixed array - @[$some string, #45.5, +100, --100, *FFFFFFFF]

	string format of ArmaData is "$stringdata"
	string format of ArmaMessage is "functionName,$stringdata"
	or for instance an array of floats
	"functionName,@[#34.3,#45.0,#31.2,#80]" ect
	******/

#define AD_STRING '$'
#define AD_FLOAT '#'
#define AD_UNSIGNED '+'
#define AD_SIGNED '-'
#define AD_ADDRESS '*'
#define AD_ARRAY '@'
#define AD_NULL '\0'
#define AD_SEPERATOR ','
#define AD_AS_RIGHT ']'
#define AD_AS_LEFT '['
#define AD_UNIT '\037'

#define AE_DATA 'D'
#define AE_MSG 'M'
#define AE_ELEMENT 'E'

	class ArmaElement
	{
	private:

		char kind;
		char type;

	protected:
		//explicit ArmaElement(char kind);
		void SetType(char type);
		void SetKind(char kind);
	public:
		ArmaElement();
		virtual ~ArmaElement() = 0;


		virtual ArmaData * AsArmaData() = 0;
		virtual ArmaMessage * AsArmaMsg() = 0;


		virtual bool ParseArmaData(std::string armaData) = 0;
		virtual bool DeparseArmaData(std::string & armaData) = 0;
		virtual bool HasData() = 0;

		char GetType();
		char GetKind();
	};

	class ArmaData : public ArmaElement
	{
	private:
		
		bool BuildData(std::string & armaData, std::string::iterator & it, std::string::size_type & pos, char type, void * & output);
		bool dataProtection;

	protected:
		bool hasData;

		bool ParseData(std::string & armaData, std::string::iterator & it, std::string::size_type & pos);
		bool RemoveChar(std::string & str, char ignore);
		void SetType(char type);
		void ClearVector(std::vector<ArmaElement *> * const & vec);
		//*These test to see if the derived template classes have valid types.
		//*If the type is valid, it checks to see if the type is initialized 
		//and has the data of the particular type, other wise returns false.
		bool ValidType(std::string & type) { return (AD_STRING == this->GetType()); }
		bool ValidType(float & type) { return (AD_FLOAT == this->GetType()); }
		bool ValidType(unsigned long long int & type) { return (AD_UNSIGNED == this->GetType()); }
		bool ValidType(long long int & type) { return (AD_SIGNED == this->GetType()); }
		bool ValidType(void * & type) { return (AD_ADDRESS == this->GetType()); }
		bool ValidType(ARMA_ARRAY & type) { return (AD_ARRAY == this->GetType()); }

		void* data;
		unsigned short precision;

		explicit ArmaData(char kind);
	public:
		ArmaData();
		explicit ArmaData(std::string armaData);
		~ArmaData();

		bool ClearData();
		bool ParseArmaData(std::string armaData) override;
		bool DeparseArmaData(std::string & armaData) override;
		bool HasData() override;
		ArmaData * AsArmaData() override;
		ArmaMessage * AsArmaMsg() override;

		template <typename Type>
		Type AsType();

		bool SetData(std::string & type);
		bool SetData(float & type);
		bool SetData(unsigned long long int & type);
		bool SetData(long long int & type);
		bool SetData(void * & type);
		bool SetData(ARMA_ARRAY & type);

		bool SetPrecision(unsigned short precision);
		unsigned short GetPrecision();

		void SetDataProtection(bool on);
		bool GetDataProtection();
	};

	class ArmaMessage : public ArmaData
	{
	private:
		bool hasFunc;
	public:
		ArmaMessage();
		explicit ArmaMessage(std::string armaData);
		~ArmaMessage();

		std::string name;

		bool ParseArmaData(std::string armaData) override;
		bool DeparseArmaData(std::string & armaData) override;
		bool HasFunc();
		ArmaMessage * AsArmaMsg() override;
	};

	
	union BiPtr
	{
		std::uint32_t ptr32[2];
		std::uint64_t ptr64;
	};
	

	unsigned int DecimalPlaces(std::string & floatStr)
	{
		unsigned int j = floatStr.size() - 1;
		for (unsigned int i = 0; i < floatStr.size(); i++)
		{
			if (floatStr[j] == '.')
			{
				return i;
			}
			j--;
		}
		return 0;
	}


	/*
	* ThreadHive.cpp
	*
	*  Created on: Mar 4, 2016
	*      Author: Aaron
	*/


	template <class T>
	int ThreadHive<T>::i = 6;
	template <class T>
	int ThreadHive<T>::threadCount = 0;
	template <class T>
	ThreadHandle<T> * ThreadHive<T>::head = nullptr;
	template <class T>
	ThreadHandle<T> * ThreadHive<T>::tail = nullptr;
	template <class T>
	std::mutex ThreadHive<T>::hiveAccess;

	template <class T>
	ThreadHive<T>::ThreadHive()
	{
		this->myThreadHandle = nullptr;
		this->isMain = true;
	}

	template <class T>
	ThreadHive<T>::ThreadHive(int a)
	{
		this->i = a;
	}

	template <class T>
	ThreadHive<T>::~ThreadHive()
	{
		ThreadHandle<T> * current = 0;
		ThreadHandle<T> * temp = 0;
		this->hiveAccess.lock();
		if (this->myThreadHandle)
		{
			this->myThreadHandle->shares--;
			if (this->myThreadHandle->shares < 1)
			{
				current = this->head;
				if (current == (this->myThreadHandle))
				{
					this->head = this->head->next;
					current->next = nullptr;
				}
				else
				{
					temp = current;
					current = current->next;
					while (this->myThreadHandle)
					{
						if (this->myThreadHandle == current)
						{
							this->myThreadHandle = nullptr;
						}
						else
						{
							current = current->next;
							temp = temp->next;
						}
					}
					if (this->tail == current)
					{
						this->tail = temp;
					}
					temp->next = temp->next->next;
					current->next = nullptr;
					//this->myThreadHandle = nullptr;
				}
				this->threadCount--;
				if (!this->head)
				{
					this->tail = nullptr;
				}
				this->myThreadHandle = nullptr;
				delete current;
				current = nullptr;
				temp = nullptr;
			}
		}
		this->hiveAccess.unlock();
	}

	template <class T>
	ThreadHandle<T> * ThreadHive<T>::push(std::string & threadName)
	{
		ThreadHandle<T> * newTH = new ThreadHandle<T>(threadName);

		if (!this->tail)
		{
			this->tail = newTH;
			this->head = newTH;
		}
		else
		{
			this->tail->next = newTH;
			this->tail = newTH;
		}
		this->threadCount++;
		return newTH;
	}

	template <class T>
	bool ThreadHive<T>::loadMsg()
	{
		if (0 < this->myThreadHandle->msgQueue->size())
		{
			return this->myThreadHandle->msgQueue->pop(this->currentMsg);
		}
		return false;
	}

	template <class T>
	bool ThreadHive<T>::addThread(std::string & threadName, bool(*callBack)(ThreadHive<T> *, std::string *), std::string * parameters)
	{
		bool result;
		ThreadHandle<T> * myTH;

		this->hiveAccess.lock();
		if (!this->myThreadHandle)
		{
			myTH = this->push(threadName);
			myTH->callBack = callBack;
			myTH->parameters = parameters;
			myTH->msgQueue = new HiveQueueC<T>();
			myTH->shares++;
			this->myThreadHandle = myTH;
			result = true;
		}
		else
		{
			result = false;
		}
		this->hiveAccess.unlock();
		return result;
	}

	template <class T>
	bool ThreadHive<T>::spawnThread()
	{
		this->myThreadHandle->threadMutex.lock();
		this->myThreadHandle->shares++;
		this->myThreadHandle->running = true;
		this->myThreadHandle->finished = false;
		this->myThreadHandle->success = false;
		this->myThreadHandle->hiveThread = new std::thread(*this); //functor tricks yo
		this->myThreadHandle->threadMutex.unlock();
		return true;
	}

	template <class T>
	bool ThreadHive<T>::sendMsg(ThreadHandle<T> * th, T & msg)
	{
		bool result = false;

		th->threadMutex.lock();
		result = th->msgQueue->push(msg);
		th->threadMutex.unlock();
		th->blocker.notify_one();
		return result;
	}

	template <class T>
	bool ThreadHive<T>::sendAll(ThreadHandle<T> * th, T * messages, unsigned int & size)
	{
		bool result = false;
		th->threadMutex.lock();
		for (unsigned int i = 0; i < size; i++)
		{
			result = th->msgQueue->push(messages[i]);
		}
		th->threadMutex.unlock();
		th->blocker.notify_one();
		return result;
	}

	template <class T>
	bool ThreadHive<T>::receiveMsg(T & msg, bool blocking)
	{
		bool result = false;
		if (blocking)
		{
			{
				std::unique_lock<std::mutex> lk(this->myThreadHandle->threadMutex);
				PredicateFunctor<ThreadHive<T>> myPred(this, &ThreadHive<T>::loadMsg);
				this->myThreadHandle->blocker.wait(lk, myPred);
				msg = this->currentMsg;
			}
			return true;
		}
		else
		{
			this->myThreadHandle->threadMutex.lock();
			if (result = this->loadMsg())
			{
				msg = this->currentMsg;
			}
			this->myThreadHandle->threadMutex.unlock();
		}
		return result;
	}

	template <class T>
	bool ThreadHive<T>::receiveAll(T * & messages, unsigned int & size, bool blocking)
	{
		messages = nullptr;
		if (blocking)
		{
			{
				std::unique_lock<std::mutex> lk(this->myThreadHandle->threadMutex);
				PredicateFunctor<ThreadHive<T>> myPred(this, &ThreadHive<T>::loadMsg);
				this->myThreadHandle->blocker.wait(lk, myPred);
				size = this->myThreadHandle->msgQueue->size() + 1;
				messages = new T[size];
				messages[0] = this->currentMsg;
				for (int i = 1; this->loadMsg(); i++)
				{
					messages[i] = this->currentMsg;
				}
			}
			return true;
		}
		else
		{
			this->myThreadHandle->threadMutex.lock();
			size = this->myThreadHandle->msgQueue->size();
			messages = new T[size];
			for (int i = 0; this->loadMsg(); i++)
			{
				messages[i] = this->currentMsg;
			}
			this->myThreadHandle->threadMutex.unlock();
		}
		return (size > 0);
	}

	template <class T>
	bool ThreadHive<T>::isFinished(ThreadHandle<T> * th)
	{
		bool result = false;

		th->threadMutex.lock();
		result = th->finished;
		th->threadMutex.unlock();

		return result;
	}

	template <class T>
	bool ThreadHive<T>::isSuccess(ThreadHandle<T> * th)
	{
		bool result = false;

		th->threadMutex.lock();
		result = th->success;
		th->threadMutex.unlock();

		return result;
	}

	template <class T>
	bool ThreadHive<T>::hasThread()
	{
		bool result;
		if (!this->myThreadHandle)
		{
			result = false;
		}
		else
		{
			result = true;
		}
		return result;
	}

	template <class T>
	bool ThreadHive<T>::isRunning(ThreadHandle<T> * th)
	{
		bool result = false;

		th->threadMutex.lock();
		result = th->running;
		th->threadMutex.unlock();

		return result;
	}

	template <class T>
	ThreadHandle<T> * ThreadHive<T>::getThreadHandle(std::string & threadName)
	{
		ThreadHandle<T> * th = 0;
		ThreadHandle<T> * current = 0;
		this->hiveAccess.lock();
		if (this->head)
		{
			current = this->head;
			while (th != current)
			{
				if (threadName == current->threadName)
				{
					th = current;
				}
				else
				{
					current = current->next;
				}
			}
		}
		this->hiveAccess.unlock();
		return th;
	}

	template <class T>
	ThreadHandle<T> * ThreadHive<T>::getMyThreadHandle()
	{
		return this->myThreadHandle;
	}

	template <class T>
	void ThreadHive<T>::jdThread(ThreadHandle<T> * th)
	{
		if (th->hiveThread->joinable())
		{
			th->hiveThread->join();
			delete th->hiveThread;
		}
		th->hiveThread = nullptr;
	}

	template <class T>
	int ThreadHive<T>::increment()
	{
		this->i++;
		return(this->i);
	}

	template <class T>
	void ThreadHive<T>::displayI()
	{
		std::cout << this->i << "\n";
	}

	/******/

	template <class T>
	ThreadHandle<T>::ThreadHandle()
	{
		this->next = nullptr;
		this->hiveThread = nullptr;
		this->msgQueue = nullptr;
		this->callBack = nullptr;
		this->parameters = nullptr;
		this->finished = false;
		this->success = false;
		this->running = false;
	}

	template <class T>
	ThreadHandle<T>::ThreadHandle(std::string & threadName) : ThreadHandle()
	{
		//ThreadHandle();
		this->threadName = threadName;
	}

	template <class T>
	ThreadHandle<T>::~ThreadHandle()
	{
		if (this->hiveThread)
		{
			this->hiveThread = nullptr;
		}
		if (this->msgQueue)
		{
			delete this->msgQueue;
			this->msgQueue = nullptr;
		}
		if (this->callBack)
		{
			this->callBack = nullptr;
		}
		if (this->parameters)
		{
			this->parameters = nullptr;
		}
	}

	/*
	* HiveQueue.cpp
	*
	*  Created on: Mar 5, 2016
	*      Author: Aaron
	*/

	template <class T>
	HiveQueue<T>::HiveQueue()
	{
		this->count = 0;
		this->head = nullptr;
		this->tail = nullptr;
	}

	template <class T>
	HiveQueue<T>::~HiveQueue()
	{
		Node* temp;
		this->tail = nullptr;
		while ((this->head) != nullptr)
		{
			temp = this->head;
			this->head = this->head->next;
			temp->next = nullptr;
			delete temp;
		}
		temp = nullptr;
	}

	template <class T>
	bool HiveQueue<T>::push(T & msg)
	{
		Node * temp = new Node;
		temp->msg = msg;
		temp->next = nullptr;

		if (this->head == nullptr)
		{
			this->head = temp;
			this->tail = temp;
			this->count = 1;
		}
		else
		{
			this->tail->next = temp;
			this->tail = temp;
			this->count++;
		}
		return true;
	}

	template <class T>
	bool HiveQueue<T>::remove()
	{
		Node * temp = nullptr;
		if (this->head == nullptr)
		{
			return false;
		}
		else
		{
			temp = this->head;
			this->head = this->head->next;
			temp->next = nullptr;
			if (this->head == nullptr)
			{
				this->tail = nullptr;
			}
			delete temp;
			this->count--;
			temp = nullptr;
			return true;
		}
	}

	template <class T>
	bool HiveQueue<T>::peek(T & msg)
	{
		if (nullptr == this->head)
		{
			return false;
		}
		else
		{
			msg = this->head->msg;
			return true;
		}
	}

	template <class T>
	bool HiveQueue<T>::pop(T & msg)
	{
		if (this->peek(msg))
		{
			return this->remove();
		}
		else
		{
			return false;
		}
	}
	template <class T>
	unsigned int HiveQueue<T>::size()
	{
		return this->count;
	}

	template <class T>
	HiveQueueC<T>::HiveQueueC()
	{
		this->count = 0;
		this->aSize = HQ_INIT_SIZE;
		this->queue = nullptr;
		this->head = 0;
		this->tail = 0;

		this->queue = new T[HQ_INIT_SIZE];
	}

	template <class T>
	HiveQueueC<T>::~HiveQueueC()
	{
		delete[] this->queue;
		this->queue = nullptr;
		//this->head = nullptr;
		//this->tail = nullptr;
	}

	template <class T>
	bool HiveQueueC<T>::push(T & msg)
	{
		if (this->count < 1)
		{
			this->tail = 1;
			this->count = 1;
			this->head = 0;
			this->queue[0] = msg;

		}
		else if (this->count < this->aSize)
		{
			this->queue[this->tail] = msg;
			this->tail++;
			this->count++;
			if (this->tail >= this->aSize)
			{
				this->tail = 0;
			}
		}
		else
		{
			if (this->grow(this->aSize + HQ_INIT_SIZE))
			{
				//expand
				this->push(msg);
			}
			else
			{
				return false;
			}
		}
		return true;
	}

	template <class T>
	bool HiveQueueC<T>::remove()
	{
		if (this->count > 0)
		{
			if (this->head < (this->aSize - 1))
			{
				this->head++;
			}
			else
			{
				this->head = 0;
			}
			this->count--;
		}
		else
		{
			return false;
		}
		return true;
	}

	template <class T>
	bool HiveQueueC<T>::peek(T & msg)
	{
		if (1 > this->count)
		{
			return false;
		}
		else
		{
			msg = this->queue[this->head];
			return true;
		}
	}

	template <class T>
	bool HiveQueueC<T>::pop(T & msg)
	{
		if (this->peek(msg))
		{
			return this->remove();
		}
		else
		{
			return false;
		}
	}

	template <class T>
	bool HiveQueueC<T>::grow(unsigned int newSize)
	{
		T * temp = new T[newSize];
		unsigned int i = this->head;
		unsigned int j = 0;

		//prevent crashing
		if (newSize <= this->aSize)
		{
			delete[] temp;
			return false;
		}
		//first iteration above head
		while (i < this->aSize)
		{
			temp[j] = this->queue[i];
			i++;
			j++;
		}

		//if need to iterate up to tail below head
		if (this->head >= this->tail)
		{
			i = 0;
			while (i != this->tail)
			{
				temp[j] = this->queue[i];
				i++;
				j++;
			}
		}

		this->tail = j;
		this->head = 0;
		this->aSize = newSize;

		delete[] this->queue;
		this->queue = temp;
		temp = nullptr;

		return true;
	}

	template <class T>
	unsigned int HiveQueueC<T>::size()
	{
		return this->count;
	}

	/*
	* ArmaData.cpp
	*
	*  Created on: Mar 17, 2016
	*      Author: Aaron
	*/
	
	ArmaData::ArmaData(char kind)
	{
		//ArmaElement(kind);
		this->SetKind(kind);
		this->SetType(AD_NULL);
		this->hasData = false;
		this->dataProtection = false;
		this->data = nullptr;
	}

	ArmaData::ArmaData() : ArmaData(AE_DATA)
	{
		//ArmaData(AE_DATA);
	}

	ArmaData::~ArmaData()
	{
		this->ClearData();
	}

	bool ArmaData::ClearData()
	{
		bool result = true;
		switch (this->GetType())
		{
		case AD_STRING:

			delete  static_cast<std::string *> (this->data);
			break;
		case AD_FLOAT:

			delete  static_cast<float *> (this->data);
			break;
		case AD_SIGNED:

			delete  static_cast<long long int *> (this->data);
			break;
		case AD_UNSIGNED:

			delete  static_cast<unsigned long long int *> (this->data);
			break;
		case AD_ADDRESS:

			delete this->data;
			break;
		case AD_ARRAY:
			if (!this->GetDataProtection())
			{
				this->ClearVector(*(static_cast<std::vector<ArmaElement *> **> (this->data)));
				if (*(static_cast<std::vector<ArmaElement *> **> (this->data)))
				{
					delete *(static_cast<std::vector<ArmaElement *> **> (this->data));
					*(static_cast<std::vector<ArmaElement *> **> (this->data)) = nullptr;
				}
			}
			delete this->data;
		default:
			result = false;
			break;
		}
		this->SetType(AD_NULL);
		this->data = nullptr;
		this->hasData = false;
		return result;
	}

	ArmaData::ArmaData(std::string armaData) : ArmaData()
	{
		//ArmaData();
		this->ParseArmaData(armaData);
	}

	bool ArmaData::ParseData(std::string & armaData, std::string::iterator & it, std::string::size_type & pos)
	{
		//bool canBuild = false;
		static const char allTypes[] = { AD_STRING, AD_FLOAT, AD_UNSIGNED, AD_SIGNED, AD_ARRAY, AD_ADDRESS };
		if (armaData == "")
		{
			return false;
		}

		if (this->HasData())
		{
			this->ClearData();
		}
		//it = armaData.begin();
		//++it;
		//pos++;
		//for (int i = 0; i < 6 && (canBuild = (*it != allTypes[i])); i++);
		//if (canBuild)
		//{
			return(this->BuildData(armaData, it, pos, *it, this->data));
		//}
		//else
		//{
			//return false;
		//}


		//std::cout << *it;

	}



	bool ArmaData::RemoveChar(std::string & str, char remove)
	{
		std::string::iterator it;
		it = str.begin();
		while (it != str.end())
		{
			if (*it == remove)
			{
				it = str.erase(it);
			}
			else
			{
				++it;
			}
		}
		return true;
	}

	void ArmaData::SetType(char type)
	{
		ArmaElement::SetType(type);
	}

	bool ArmaData::ParseArmaData(std::string armaData)
	{
		std::string::iterator it;
		std::string::size_type pos = 0;
		//this->RemoveChar(armaData, ' ');
		it = armaData.begin();
		return(this->ParseData(armaData, it, pos));
	}

	bool ArmaData::DeparseArmaData(std::string & armaData)
	{
		if (this->HasData())
		{
			armaData.push_back(this->GetType());
			switch(this->GetType())
			{
			case AD_STRING:
				armaData.push_back(AD_UNIT);
				armaData.append(this->AsType<std::string>());
				armaData.push_back(AD_UNIT);
				break;

			case AD_FLOAT:
				{
					std::stringstream floatStr;
					std::fixed(floatStr);
					floatStr.precision(this->precision);
					floatStr << this->AsType<float>();
					armaData.append(floatStr.str());
				}
				break;
			case AD_SIGNED:
				armaData.append(std::to_string(this->AsType<long long int>()));
				break;
			case AD_UNSIGNED:
				armaData.append(std::to_string(this->AsType<unsigned long long int>()));
				break;
			case AD_ARRAY:
				{
					ARMA_ARRAY current = this->AsType<ARMA_ARRAY>();
					unsigned int size = current->size();
					unsigned int i = 0;
					armaData.push_back(AD_AS_LEFT);

					while (i < size)
					{
						if ((*current)[i]->HasData())
						{
							(*current)[i]->AsArmaData()->DeparseArmaData(armaData);
							armaData.push_back(AD_SEPERATOR);
						}
						i++;
					}

					if (i > 0)
					{
						armaData.pop_back();
					};
					armaData.push_back(AD_AS_RIGHT);
				}
				break;
			case AD_ADDRESS:
				{
					std::stringstream ptrString;
					//BiPtr myPtr;
					if (8 == sizeof(void *))
					{
						//myPtr.ptr64 = reinterpret_cast<uint64_t> (this->AsType<void *>());
						ptrString << std::hex << reinterpret_cast<uint64_t> (this->AsType<void *>());
					}
					else
					{
						//myPtr.ptr32[0] = reinterpret_cast<uint32_t> (this->AsType<void *>());
						ptrString << std::hex << reinterpret_cast<uint32_t> (this->AsType<void *>());
					}
					armaData.append(ptrString.str());
				}
				break;
			default:
					break;
			}
			return true;
		}
		else
		{
			return false;
		}
	}

	void ArmaData::ClearVector(std::vector<ArmaElement *> * const & vec)
	{
		unsigned int end = vec->size();
		for (unsigned int i = 0; i < end; i++)
		{
			if ((*vec)[i])
			{
				delete (*vec)[i];
				(*vec)[i] = nullptr;
			}
		}
	}

	bool ArmaData::BuildData(std::string & armaData, std::string::iterator & it, std::string::size_type & pos, char type, void * &output)
	{
		//unsigned int max;
		output = nullptr;
		if (it == armaData.end())
		{
			this->hasData = false;
			return false;
		}
		if ((it + 1) == armaData.end())
		{
			tHiveError.ThrowError(parseErrorType, true);
		}

		switch (type)
		{
		case AD_STRING:

			output = static_cast<void *> (new std::string(armaData.substr(pos+1)));
			this->SetType(AD_STRING);
			this->hasData = true;
			break;
		case AD_FLOAT:
		{
			std::string subStr = armaData.substr(pos + 1);
			this->precision = DecimalPlaces(subStr);
			output = static_cast<void *> (new float(std::stof(subStr)));
			this->SetType(AD_FLOAT);
			this->hasData = true;
		}
			break;
		case AD_SIGNED:

			output = static_cast<void *> (new long long int(std::stoll(armaData.substr(pos+1))));
			this->SetType(AD_SIGNED);
			this->hasData = true;
			break;
		case AD_UNSIGNED:

			output = static_cast<void *> (new unsigned long long int(std::stoull(armaData.substr(pos+1))));
			this->SetType(AD_UNSIGNED);
			this->hasData = true;
			break;

		case AD_ARRAY:
			++it;
			pos++;
			if (*it == AD_AS_LEFT)
			{
				{
					//char tempChar;
					std::vector<ArmaElement*> * tempArray = new std::vector<ArmaElement *>();
					ArmaElement * tempElement = nullptr;
					bool isArray = false;
					bool ignore = false;
					unsigned int nestCounterL = 0;
					unsigned int nestCounterR = 0;
					std::string temp = "";
					++it;
					pos++;
					while(it != armaData.end())
					{
						temp = "";
						ignore = false;
						if (*it == AD_ARRAY)
						{
							temp.push_back(*it);
							++it;
							pos++;
							if (*it == AD_AS_LEFT && (it + 1) != armaData.end())
							{
								nestCounterL++;
								temp.push_back(*it);
								++it;
								pos++;
							}
							else
							{
								this->ClearVector(tempArray);
								delete tempArray;
								tHiveError.ThrowError(parseErrorExpected, true);
								return false;
							}
							while (nestCounterL > 0)
							{
								if (*it == AD_UNIT)
								{
									ignore = !ignore;
								}
								temp.push_back(*it);
								
								if (!ignore)
								{
									if (*it == AD_AS_LEFT)
									{
										nestCounterL++;
									}
									if (*it == AD_AS_RIGHT)
									{
										nestCounterR++;
									}
									if (nestCounterL == nestCounterR)
									{
										//temp.push_back(AD_NULL);
										tempElement = new ArmaData(temp);
										if (AD_NULL == tempElement->GetType())
										{
											delete tempElement;
											this->ClearVector(tempArray);
											delete tempArray;
											tHiveError.ThrowError(parseErrorType, true);
										}
										tempArray->push_back(tempElement);
										tempElement = nullptr;
										temp = "";
										//++it;
										//pos++;
										if ((it + 1) != armaData.end())
										{
											++it;
											pos++;
											nestCounterL = 0;
											nestCounterR = 0;
											if (*it != AD_AS_RIGHT)
											{
												if ((it + 1) == armaData.end())
												{
													tHiveError.ThrowError(parseErrorExpected, true);
												}
												if (*(it + 1) == AD_AS_RIGHT)
												{
													tHiveError.ThrowError(parseErrorExpected, true);
												}
											}
											else
											{
												if ((it + 1) != armaData.end())
												{
													tHiveError.ThrowError(parseErrorEnd, true);
												}
											}
										}
										else
										{
											tHiveError.ThrowError(parseErrorType, true);
										}
									}
								}
								else
								{
									if (it == armaData.end())
									{
										tHiveError.ThrowError(parseErrorExpected, true);
									}
								}
								++it;
								pos++;
							}
						}
						else
						{
							while (*it != AD_ARRAY)
							{
								if (*it == AD_UNIT)
								{
									ignore = !ignore;
								}
								else
								{
									temp.push_back(*it);
								}
								pos++;
								++it;
								
								if (!ignore)
								{
									if (*it == AD_SEPERATOR || *it == AD_AS_RIGHT)
									{
										//temp.push_back(AD_NULL);
										tempElement = new ArmaData(temp);
										if (AD_NULL == tempElement->GetType())
										{
											delete tempElement;
											this->ClearVector(tempArray);
											delete tempArray;
											tHiveError.ThrowError(parseErrorType, true);
										}
										tempArray->push_back(tempElement);
										tempElement = nullptr;
										temp = "";
										++it;
										pos++;
										if (*(it - 1) == AD_AS_RIGHT)
										{
											if (it == armaData.end())
											{
												output = new void * (static_cast<void *> (tempArray));
												this->SetType(AD_ARRAY);
												this->hasData = true;
												return (output != nullptr);
											}
											else
											{
												tHiveError.ThrowError(parseErrorEnd, true);
											}
										}
										else
										{
											if (it == armaData.end())
											{
												tHiveError.ThrowError(parseErrorExpected, true);
											}
										}
									}
								}
								else
								{
									if (it == armaData.end())
									{
										tHiveError.ThrowError(parseErrorExpected, true);
									}
								}
							}
						}
					}

					output = new void * (static_cast<void *> (tempArray));
					this->SetType(AD_ARRAY);
					this->hasData = true;
				}
			}


		break;
		case AD_ADDRESS:
			{
				//c style code is always better for dealing with addresses directly
				BiPtr ptrVal;
				bool littleEnd;
				std::stringstream ptrString;
				ptrString << std::hex << armaData.substr(pos+1);

				//test for little endian
				ptrVal.ptr64 = UINT32_MAX;
				littleEnd = (ptrVal.ptr32[0] > ptrVal.ptr32[1]);

				ptrVal.ptr64 = 0;
				ptrString >> ptrVal.ptr64;
				if (8 == sizeof(void *))
				{
					output = new void* (reinterpret_cast<void *>(ptrVal.ptr64));
				}
				else
				{
					if (0 < ptrVal.ptr32[littleEnd])
					{
						//supplied address was for 64 bit
						tHiveError.ThrowError(parseErrorType, true);
						return false;
					}
					littleEnd = !littleEnd;
					output = new void* (reinterpret_cast<void *>(ptrVal.ptr32[littleEnd]));
				}
				this->SetType(AD_ADDRESS);
				this->hasData = true;
			}
			break;
		default:
			tHiveError.ThrowError(parseErrorType, true);
			break;
		}
		return (output != nullptr);
	}

	template <typename Type>
	Type ArmaData::AsType()
	{
		Type test;
		if (this->ValidType(test))
		{
			return *(static_cast<Type *>(this->data));
		}
		tHiveError.ThrowError("T_HIVE_ERROR: AsType, can not return data as type.", true);
		return test;
	}

	bool ArmaData::SetData(std::string & type)
	{
		if (this->HasData())
		{
			this->ClearData();
		}
		this->data = static_cast<void *> (new std::string(type));
		this->SetType(AD_STRING);
		this->hasData = true;
		return true;
	}
	bool ArmaData::SetData(float & type)
	{
		if (this->HasData())
		{
			this->ClearData();
		}
		this->data = static_cast<void *> (new float(type));
		this->SetType(AD_FLOAT);
		this->hasData = true;
		return true;
	}
	bool ArmaData::SetData(unsigned long long int & type)
	{
		if (this->HasData())
		{
			this->ClearData();
		}
		this->data = static_cast<void *> (new unsigned long long int(type));
		this->SetType(AD_UNSIGNED);
		this->hasData = true;
		return true;
	}
	bool ArmaData::SetData(long long int & type)
	{
		if (this->HasData())
		{
			this->ClearData();
		}
		this->data = static_cast<void *> (new long long int(type));
		this->SetType(AD_SIGNED);
		this->hasData = true;
		return true;
	}
	bool ArmaData::SetData(void * & type)
	{
		if (this->HasData())
		{
			this->ClearData();
		}
		this->data = new void* (reinterpret_cast<void *>(type));
		this->SetType(AD_ADDRESS);
		this->hasData = true;
		return true;
	}
	bool ArmaData::SetData(ARMA_ARRAY & type)
	{
		if (this->HasData())
		{
			this->ClearData();
		}
		this->data = new void * (static_cast<void *> (type));
		this->SetType(AD_ARRAY);
		this->hasData = true;
		return true;
	}

	bool ArmaData::SetPrecision(unsigned short precision)
	{
		this->precision = precision;
		return true;
	}

	unsigned short ArmaData::GetPrecision()
	{
		return (this->precision);
	}

	void ArmaData::SetDataProtection(bool on)
	{
		this->dataProtection = on;
	}

	bool ArmaData::GetDataProtection()
	{
		return(this->dataProtection);
	}

	bool ArmaData::HasData()
	{
		return this->hasData;
	}

	bool ArmaMessage::HasFunc()
	{
		return this->hasFunc;
	}

	ArmaMessage::ArmaMessage() : ArmaData(AE_MSG)
	{
		this->name = "";
		this->hasFunc = false;
	}

	ArmaMessage::ArmaMessage(std::string armaData) : ArmaMessage()
	{
		//ArmaMessage();
		this->name = "";
		this->ParseArmaData(armaData);
	}

	ArmaMessage::~ArmaMessage()
	{
		ArmaData::~ArmaData();
	}

	bool ArmaMessage::ParseArmaData(std::string armaData)
	{
		bool nullFunc = false;
		std::string::iterator it;
		std::string fncName = "";
		std::string data = "";
		std::string::size_type pos = 0;

		//this->RemoveChar(armaData, ' ');

		if (armaData == "")
		{
			return false;
		}

		it = armaData.begin();

		if (*it == AD_STRING || *it == AD_FLOAT || *it == AD_SIGNED || *it == AD_UNSIGNED || *it == AD_ADDRESS || *it == AD_ARRAY)
		{
			nullFunc = true;
		}


		this->hasFunc = !nullFunc;

		if (this->hasFunc)
		{
			for (; it != armaData.end() && *it != AD_SEPERATOR; ++it)
			{
				fncName.push_back(*it);
				pos++;
			}

			//fncName.push_back(AD_NULL);
			this->name = fncName;

			if (it == armaData.end())
			{
				this->hasData = false;
				return(armaData != "");
			}
			++it;
			pos++;
		}
		return(this->ParseData(armaData, it, pos));
	}

	bool ArmaMessage::DeparseArmaData(std::string & armaData)
	{
		if (this->HasFunc())
		{
			armaData.append(this->name);
			if (this->HasData())
			{
				armaData.push_back(AD_SEPERATOR);
			}
		}
		return (this->ArmaData::DeparseArmaData(armaData));
	}

	ArmaElement::ArmaElement()
	{
		this->kind = AE_ELEMENT;
		this->type = AD_NULL;
	}

	ArmaElement::~ArmaElement()
	{

	}

	void ArmaElement::SetType(char type)
	{
		this->type = type;
	}

	void ArmaElement::SetKind(char kind)
	{
		this->kind = kind;
	}

	char ArmaElement::GetType()
	{
		return this->type;
	}

	char ArmaElement::GetKind()
	{
		return this->kind;
	}

	
	ArmaData * ArmaData::AsArmaData()
	{
		
		if (ArmaData * type = dynamic_cast <ArmaData *> (this))
		{
			return type;
		}
		tHiveError.ThrowError("THiveError: Could not convert ArmaElement to ArmaData", true);
		return nullptr;
	}

	ArmaMessage * ArmaData::AsArmaMsg()
	{
		tHiveError.ThrowError("THiveError: Could not convert ArmaElement to ArmaMessage", true);
		return nullptr;
	}
	
	ArmaMessage * ArmaMessage::AsArmaMsg()
	{
		if (ArmaMessage * type = dynamic_cast <ArmaMessage *> (this))
		{
			return type;
		}
		tHiveError.ThrowError("THiveError: Could not convert ArmaElement to ArmaMessage", true);
		return nullptr;
	}

}

#endif /* THREADHIVE_H_ */
