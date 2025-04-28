// OPFL.cpp : Defines the exported functions for the DLL application.
//
#include "stdafx.h"
#include <cstring>
#include "ThreadHive.h"
#include "ConnectionPool.h"
#include "OPFLConnection.h"

#include "DBLibrary.h"


using namespace thive;
using namespace std::chrono_literals;

bool IsBanned(long long int year, long long int mon, long long int day, long long int hour, long long int min, long long int sec, long long int banHours);


bool TestDB()
{
	OPFL_CON opflCon;

	opflCon = DBLibrary::Functions::Connect(DBHOST, USER, PASSWORD, DATABASE, false);
	DBLibrary::Functions::CreateAccount(opflCon, "Thisisatest");
	DBLibrary::Functions::Close(opflCon);
	DBLibrary::Functions::DeleteConnection(opflCon);
	opflCon = nullptr;

	return true;
}


bool mycallback(ThreadHive<ArmaElement *> * myHive, std::string * parameters)
{
	std::stringstream out;
	std::string actName;
	std::string outputName;
	std::string inputName;
	std::shared_ptr<active911::OPFLConnection> opflcon;
	std::shared_ptr<active911::OPFLConnection> opflcon2;

	ArmaElement * msg;
	ARMA_ARRAY actArray;
	OPFL_Account act;
	ThreadHive<std::string> com;

	bool retry = true;
	bool stable = true;
	bool success = true;
	bool rejoin = false;
	bool isBanned = false;

	struct tm aTime = { 0 };
	time_t rawTime;

	myHive->receiveMsg(msg, false);
	inputName = msg->AsArmaMsg()->AsType<ARMA_ARRAY>()->at(0)->AsArmaData()->AsType<std::string>();
	outputName = msg->AsArmaMsg()->AsType<ARMA_ARRAY>()->at(1)->AsArmaData()->AsType<std::string>();
	actName = msg->AsArmaMsg()->AsType<ARMA_ARRAY>()->at(2)->AsArmaData()->AsType<std::string>();
	rejoin = (bool) msg->AsArmaMsg()->AsType<ARMA_ARRAY>()->at(3)->AsArmaData()->AsType<unsigned long long int>();
	delete msg;
	msg = nullptr;

	//this loops attempts to borrow a connection, and will stop retrying/terminate thread if it gets a commit msg
	while (retry && stable)
	{
		try
		{
			opflcon = active911::mysql_pool->borrow();
			opflcon2 = active911::mysql_pool->borrow();
			opflcon->ThreadInit();
			retry = false;
		}
		catch (const std::exception& e)
		{
			stable = (0 != std::strcmp(e.what(), active911::ConnectionImpossible::ConnectionImpossible().what()));
		}

		myHive->receiveMsg(msg, false);
		if (msg)
		{
			//terminate thread
			if (msg->AsArmaMsg()->name.compare("Commit") == 0)
			{
				if (!retry)
				{
					opflcon->ThreadEnd();
					active911::mysql_pool->unborrow(opflcon2);
					active911::mysql_pool->unborrow(opflcon);
				}

				delete msg;
				msg = nullptr;
				myHive = nullptr;
				parameters = nullptr;
				return true;
			}
			delete msg;
			msg = nullptr;
		}

		if (retry && stable)
		{
			std::this_thread::sleep_for(1s);
		}
	}

	retry = true;

	if (!(stable && opflcon->CreateAccount(actName.c_str())))
	{
		stable = false;
	}

	/**
	while (retry && stable)
	{
		retry = !opflcon->CreateAccount(actName.c_str());
		myHive->receiveMsg(msg, false);
		if (msg)
		{
			//terminate thread
			if (msg->AsArmaMsg()->name.compare("Commit") == 0)
			{
				if (!retry)
				{
					opflcon->ThreadEnd();
					active911::mysql_pool->unborrow(opflcon);
				}

				delete msg;
				msg = nullptr;
				myHive = nullptr;
				parameters = nullptr;
				return true;
			}
			delete msg;
			msg = nullptr;
		}
	}
	*/

	//grab the useraccount information
	if (!(stable && opflcon->GetAccount(actName.c_str(), act)))
	{
		stable = false;
	}

	if (!(stable && opflcon2->CreateBanData(actName.c_str())))
	{
		stable = false;
	}

	if (!(stable && opflcon2->GetBanData(actName.c_str(), act)))
	{
		stable = false;
	}

	isBanned = IsBanned(act.year, act.month, act.day, act.hour, act.minute, act.second, 1);

	if (stable && rejoin)
	{
		if (act.left > 0)
		{
			if ((act.left > 4) && !isBanned)
			{
				act.left = 0;
			}
			else
			{
				act.left = act.left - 1;
			}
		}
		else
		{
			act.left = 0;
		}
		if (!(stable && opflcon2->WriteBanData(&act)))
		{
			stable = false;
		}
	}

	if (!(stable && opflcon2->CommitData()))
	{
		stable = false;
	}

	/**
	//send out the account information to both signify connection success and give data
	if (retry = opflcon->GetAccount(actName.c_str(), act))
	{
		out << "@[$" << AD_UNIT << actName.c_str() << AD_UNIT << ",-" << act.rank << ",-" << act.level << ",-" << act.matches << ",-" << act.wins << ",-" << act.losses << ",-" << act.kills << ",-" << act.chickens << ",-" << act.left << ",-" << act.year << ",-" << act.month << ",-" << act.day << ",-" << act.hour << ",-" << act.minute << ",-" << act.second << "]";
		com.sendMsg(com.getThreadHandle(outputName), out.str());
	}
	*/

	if (stable)
	{
		out << "@[$" << AD_UNIT << actName.c_str() << AD_UNIT << ",-" << act.rank << ",-" << act.level << ",-" << act.matches << ",-" << act.wins << ",-" << act.losses << ",-" << act.kills << ",-" << act.chickens << ",-" << act.left << ",-" << act.year << ",-" << act.month << ",-" << act.day << ",-" << act.hour << ",-" << act.minute << ",-" << act.second << ",+" << (unsigned long long int) (isBanned && (act.left > 4))<< "]";
		com.sendMsg(com.getThreadHandle(outputName), out.str());

		while (retry)
		{
			myHive->receiveMsg(msg, true);
			if (msg->AsArmaMsg()->name.compare("PublishKills") == 0)
			{
				retry = opflcon->WriteKills(actName.c_str(), msg->AsArmaMsg()->AsType<ARMA_ARRAY>()->at(1)->AsArmaData()->AsType<long long int>());
			}
			else if (msg->AsArmaMsg()->name.compare("PublishChickens") == 0)
			{
				retry = opflcon->WriteChickens(actName.c_str(), msg->AsArmaMsg()->AsType<ARMA_ARRAY>()->at(1)->AsArmaData()->AsType<long long int>()); //same reference as kills but different function
			}
			else if (msg->AsArmaMsg()->name.compare("PublishAccount") == 0)
			{
				actArray = msg->AsArmaMsg()->AsType<ARMA_ARRAY>()->at(1)->AsArmaData()->AsType<ARMA_ARRAY>();
				act.rank = actArray->at(1)->AsArmaData()->AsType<long long int>();
				act.level = actArray->at(2)->AsArmaData()->AsType<long long int>();
				act.matches = actArray->at(3)->AsArmaData()->AsType<long long int>();
				act.wins = actArray->at(4)->AsArmaData()->AsType<long long int>();
				act.losses = actArray->at(5)->AsArmaData()->AsType<long long int>();
				act.kills = actArray->at(6)->AsArmaData()->AsType<long long int>();
				act.chickens = actArray->at(7)->AsArmaData()->AsType<long long int>();
				//act.left = actArray->at(8)->AsArmaData()->AsType<long long int>();
				//act.year = actArray->at(9)->AsArmaData()->AsType<long long int>();
				//act.month = actArray->at(10)->AsArmaData()->AsType<long long int>();
				//act.day = actArray->at(11)->AsArmaData()->AsType<long long int>();
				//act.hour = actArray->at(12)->AsArmaData()->AsType<long long int>();
				//act.minute = actArray->at(13)->AsArmaData()->AsType<long long int>();
				//act.second = actArray->at(14)->AsArmaData()->AsType<long long int>();
				retry = opflcon->WriteAccount(&act);
			}
			else
			{
				//update left counter and ban date if punishment variable is true
				if ((bool)msg->AsArmaData()->AsType<ARMA_ARRAY>()->at(2)->AsArmaData()->AsType<unsigned long long int>())
				{
					if (opflcon2->GetBanData(actName.c_str(), act))
					{
						if (act.left > 4)
						{
							act.left = 1;
						}
						else
						{
							if (act.left > 3)
							{
								act.left = 5;
								rawTime = time(NULL);
								gmtime_s(&aTime, &rawTime);

								act.year = aTime.tm_year + 1900;
								act.month = aTime.tm_mon + 1;
								act.day = aTime.tm_mday;
								act.hour = aTime.tm_hour;
								act.minute = aTime.tm_min;
								act.second = aTime.tm_sec;
							}
							else
							{
								act.left = act.left + 1;
							}
						}
						if (opflcon2->WriteBanData(&act) && opflcon2->CommitData())
						{
							active911::mysql_pool->unborrow(opflcon2);
						}
					}
				}
				else
				{
					active911::mysql_pool->unborrow(opflcon2);
				}

				//commit and close thread
				opflcon->ThreadEnd();
				if (opflcon->CommitData())
				{
					active911::mysql_pool->unborrow(opflcon);
				}
				delete msg;
				myHive = nullptr;
				parameters = nullptr;
				return true;
			}
			delete msg;
		}
	}
	//it returns at this point if there was a connection crash without commit, so we need to signal that the thread crashed for cleanup and client reconnection
	out << "@[$" << AD_UNIT << inputName << AD_UNIT << ",$" << AD_UNIT << outputName << AD_UNIT << ",$" << AD_UNIT << actName << AD_UNIT << "]";
	com.sendMsg(com.getThreadHandle(std::string("CLEANUP_O")), out.str());
	myHive = nullptr;
	parameters = nullptr;
	opflcon->ThreadEnd();
	return true;
}

bool CleanupThreads(ThreadHive<ArmaElement *> * myHive, std::string * parameters)
{
	ArmaElement ** input = nullptr;
	unsigned int size;
	ThreadHive<ArmaElement* > * inputThread;
	ThreadHive<std::string> com;
	std::shared_ptr<active911::ConnectionPool<active911::OPFLConnection> > mysql_pool(new active911::ConnectionPool<active911::OPFLConnection>(50, active911::mysql_connection_factory));

	active911::mysql_pool = mysql_pool;
	tHiveError.ThrowError("POOL READY!", false);
	com.sendMsg(com.getThreadHandle(std::string("DLL_O")), std::string("+1"));

	while (true)
	{
		myHive->receiveAll(input, size, true);
		tHiveError.ThrowError("Processing\n", false);
		for (unsigned int i = 0; i < size; ++i)
		{
			for (std::vector<ArmaElement *>::iterator j = input[i]->AsArmaData()->AsType<ARMA_ARRAY>()->begin(); j != input[i]->AsArmaData()->AsType<ARMA_ARRAY>()->end(); ++j)
			{
				tHiveError.ThrowError("Grabbing handle\n", false);
				inputThread = static_cast<ThreadHive<ArmaElement *> *>((*j)->AsArmaData()->AsType<ARMA_ARRAY>()->at(0)->AsArmaData()->AsType<void *>());
				tHiveError.ThrowError("Waiting\n", false);
				while (inputThread->isRunning(inputThread->getMyThreadHandle())) {
					std::this_thread::sleep_for(1ms);
					tHiveError.ThrowError("Waiting\n", false);
				}
				tHiveError.ThrowError("Not Waiting\n", false);
				//delete output thread and input thread after their instance has "ended"
				delete inputThread;
				tHiveError.ThrowError("Deleted input thread\n", false);
				delete static_cast<ThreadHive<std::string> *>((*j)->AsArmaData()->AsType<ARMA_ARRAY>()->at(1)->AsArmaData()->AsType<void *>());
				tHiveError.ThrowError("Cleaned\n", false);
			}
			delete input[i];
		}
		delete[] input;
		input = nullptr;
	}
	return true;
}


bool PublishData(ArmaElement * & msg)
{
	ThreadHive<ArmaElement *> * inputThread = static_cast<ThreadHive<ArmaElement *> *>(msg->AsArmaData()->AsType<ARMA_ARRAY>()->at(0)->AsArmaData()->AsType<void *>()); //grab hive object
	inputThread->sendMsg(inputThread->getMyThreadHandle(), msg);
	return true;

}

bool IsBanned(long long int year, long long int mon, long long int day, long long int hour, long long int min, long long int sec, long long int banHours)
{
	time_t begin;
	time_t end;
	struct tm aTime = { 0 };
	std::stringstream out;

	end = time(NULL);
	gmtime_s(&aTime, &end);
	end = mktime(&aTime);

	aTime = { 0 };
	aTime.tm_year = year - 1900;
	aTime.tm_mon = mon - 1;
	aTime.tm_mday = day;

	aTime.tm_hour = hour;
	aTime.tm_min = min;
	aTime.tm_sec = sec;
	begin = mktime(&aTime);
	return (difftime(end, begin) < static_cast<double>(3600 * banHours));
}

BOOL APIENTRY DllMain(HMODULE hModule,
	DWORD  ul_reason_for_call,
	LPVOID lpReserved
	)
{
	switch (ul_reason_for_call)
	{
	case DLL_PROCESS_ATTACH:
	case DLL_THREAD_ATTACH:
	case DLL_THREAD_DETACH:
	case DLL_PROCESS_DETACH:
		break;
	}
	return TRUE;
}

extern "C"
{
	__declspec(dllexport) void __stdcall RVExtension(char *output, int outputSize, const char *function);
};

void __stdcall RVExtension(char *output, int outputSize, const char *function)
{
	static std::string thrdname = "CLEANUP_T";
	static ThreadHive<ArmaElement *> * cleanupThread = new ThreadHive<ArmaElement *>();
	static ThreadHive<std::string> * threadState = new ThreadHive<std::string>();
	static ThreadHive<std::string> * dllState = new ThreadHive<std::string>();
	ArmaElement * msg = new ArmaMessage(function);

	if (!cleanupThread->getMyThreadHandle())
	{
		tHiveError.ThrowError("STARTING CLEANUP THREAD!", false);
		cleanupThread->addThread(thrdname, CleanupThreads, nullptr);
		thrdname = "CLEANUP_O";
		threadState->addThread(thrdname, nullptr, nullptr);
		dllState->addThread(std::string("DLL_O"), nullptr, nullptr);
		cleanupThread->spawnThread();
	}

	if (msg->AsArmaMsg()->name.compare("GetState") == 0)
	{
		std::string out = "@[";
		std::string * allOut = nullptr;
		unsigned int size;
		if (threadState->receiveAll(allOut, size, false))
		{
			out.append(allOut[0]);
			for (int i = 1; i < size; i++)
			{
				out.push_back(',');
				out.append(allOut[i]);
			}
		}
		out.push_back(']');
		//threadState->receiveMsg(out, false); //grab last output
		delete msg;
		delete[] allOut;
		allOut = nullptr;

		//output = new char[strlen(out.c_str()) + 1];
		tHiveError.ThrowError(out.c_str(), false);
		strncpy_s(output, outputSize, out.c_str(), strlen(out.c_str()) + 1);
	}
	else if (msg->AsArmaMsg()->name.compare("GetDllState") == 0)
	{
		std::string out = "+0";
		dllState->receiveMsg(out, false); //grab last output
		delete msg;

		//output = new char[strlen(out.c_str()) + 1];
		tHiveError.ThrowError(out.c_str(), false);
		strncpy_s(output, outputSize, out.c_str(), strlen(out.c_str()) + 1);
	}
	else if (msg->AsArmaMsg()->name.compare("Connect") == 0)
	{
		std::stringstream out;
		ThreadHive<std::string> * outputThread = new ThreadHive<std::string>();
		ThreadHive<ArmaElement *> * inputThread = new ThreadHive<ArmaElement *>();
		//ArmaElement * test = new ArmaData();
		//this is the thread of the actual connection and will be spawned
		inputThread->addThread(
								msg->AsArmaMsg()->AsType<ARMA_ARRAY>()->at(0)->AsArmaData()->AsType<std::string>(), 
								mycallback, 
								nullptr
			);
		//this is the output "thread", which is just a reference to the main thread but with a unique output queue to grab information
		outputThread->addThread(
								msg->AsArmaMsg()->AsType<ARMA_ARRAY>()->at(1)->AsArmaData()->AsType<std::string>(), 
								nullptr, 
								nullptr
			);

		//this sends the connection message to the input thread and attempts to spawn the connection. If successful, the correct output will be given to the output thread 
		inputThread->sendMsg(inputThread->getMyThreadHandle(), msg);
		inputThread->spawnThread();

		//out << "@[*" << inputThread << ",*" << outputThread << "]";
		//test->ParseArmaData(out.str());
		//out << test->AsArmaData()->AsType<ARMA_ARRAY>()->at(0)->AsArmaData()->AsType<void*>() << test->AsArmaData()->AsType<ARMA_ARRAY>()->at(1)->AsArmaData()->AsType<void*>();
		//output = new char[strlen(out.str().c_str()) + 1];
		//delete test;
		out << "@[*" << inputThread << ",*" << outputThread << "]";
		tHiveError.ThrowError(out.str().c_str(), false);
		strncpy_s(output, outputSize, out.str().c_str(), strlen(out.str().c_str()) + 1);
	}
	else if (msg->AsArmaMsg()->name.compare("GetOutput") == 0)
	{
		std::string out = "";
		
		ThreadHive<std::string> * outputThread = static_cast<ThreadHive<std::string> *>(msg->AsArmaMsg()->AsType<ARMA_ARRAY>()->at(0)->AsArmaData()->AsType<void *>()); //grab hive handle
		outputThread->receiveMsg(out, false); //grab last output
		delete msg;

		//output = new char[strlen(out.c_str()) + 1];
		strncpy_s(output, outputSize, out.c_str(), strlen(out.c_str()) + 1);
	}
	else if ((msg->AsArmaMsg()->name.compare("PublishKills") == 0) || (msg->AsArmaMsg()->name.compare("PublishChickens") == 0) || (msg->AsArmaMsg()->name.compare("PublishAccount") == 0))
	{
		PublishData(msg);
		//output = new char[1];
		output[0] = '\0';
	}
	else if (msg->AsArmaMsg()->name.compare("Commit") == 0)
	{ 
		ARMA_ARRAY data = nullptr;
		ArmaElement * cmMsg;

		for (std::vector<ArmaElement *>::iterator it = msg->AsArmaMsg()->AsType<ARMA_ARRAY>()->begin(); it != msg->AsArmaMsg()->AsType<ARMA_ARRAY>()->end(); ++it)
		{
			data = (*it)->AsArmaData()->AsType<ARMA_ARRAY>();
			cmMsg = new ArmaMessage();
			cmMsg->AsArmaMsg()->SetData(data);
			cmMsg->AsArmaMsg()->name = "Commit";
			cmMsg->AsArmaMsg()->SetDataProtection(true); //this has to stay protected as msg has its contents and gets used by the cleanup thread (msg gets deleted later in cleanup thread)
			//to do: cmMsg->SetName(name); needs hasFnc to be set
			PublishData(cmMsg);
		}
		cleanupThread->sendMsg(cleanupThread->getMyThreadHandle(), msg);
		output[0] = '\0';
	}
	/**
	else if (msg->AsArmaMsg()->name.compare("IsBanned") == 0)
	{
		ARMA_ARRAY timeArg = msg->AsArmaMsg()->AsType<ARMA_ARRAY>();
		time_t begin;
		time_t end;
		struct tm aTime = { 0 };
		std::stringstream out;

		end = time(NULL);
		gmtime_s(&aTime, &end);
		end = mktime(&aTime);

		aTime = { 0 };
		aTime.tm_year = timeArg->at(0)->AsArmaData()->AsType<long long int>() - 1900;
		aTime.tm_mon = timeArg->at(1)->AsArmaData()->AsType<long long int>() - 1;
		aTime.tm_mday = timeArg->at(2)->AsArmaData()->AsType<long long int>();

		aTime.tm_hour = timeArg->at(3)->AsArmaData()->AsType<long long int>();
		aTime.tm_min = timeArg->at(4)->AsArmaData()->AsType<long long int>();
		aTime.tm_sec = timeArg->at(5)->AsArmaData()->AsType<long long int>();
		begin = mktime(&aTime);

		out << "-" << (difftime(end, begin) < static_cast<double>(3600 * timeArg->at(6)->AsArmaData()->AsType<long long int>()));
		strncpy_s(output, outputSize, out.str().c_str(), strlen(out.str().c_str()) + 1);
	}
	*/
	else if (msg->AsArmaMsg()->name.compare("IsBanned") == 0)
	{
		ARMA_ARRAY timeArg = msg->AsArmaMsg()->AsType<ARMA_ARRAY>();
		std::stringstream out;

		out << "-" << 
					IsBanned(timeArg->at(0)->AsArmaData()->AsType<long long int>(), 
					timeArg->at(1)->AsArmaData()->AsType<long long int>(), 
					timeArg->at(2)->AsArmaData()->AsType<long long int>(),
					timeArg->at(3)->AsArmaData()->AsType<long long int>(),
					timeArg->at(4)->AsArmaData()->AsType<long long int>(),
					timeArg->at(5)->AsArmaData()->AsType<long long int>(),
					timeArg->at(6)->AsArmaData()->AsType<long long int>());
		delete msg;
		strncpy_s(output, outputSize, out.str().c_str(), strlen(out.str().c_str()) + 1);
	}
	else if (msg->AsArmaMsg()->name.compare("GMTime") == 0)
	{
		struct tm aTime = { 0 };
		time_t rawTime;
		std::stringstream out;

		rawTime = time(NULL);
		gmtime_s(&aTime, &rawTime);

		out << "@[-" << aTime.tm_year + 1900 << ",-" << aTime.tm_mon + 1 << ",-" << aTime.tm_mday << ",-" << aTime.tm_hour << ",-" << aTime.tm_min << ",-" << aTime.tm_sec << "]";
		delete msg;
		strncpy_s(output, outputSize, out.str().c_str(), strlen(out.str().c_str()) + 1);
	}
	else
	{
		delete msg;
		strncpy_s(output, outputSize, function, strlen(function) + 1);
	}
}

