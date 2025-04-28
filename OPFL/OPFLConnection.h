#pragma once
#include "ConnectionPool.h"
#include "DBLibrary.h"
#include <string>
#include <memory>

namespace active911 {


	class OPFLConnection : public Connection {

	public:


		~OPFLConnection() {

			if (this->opflcon) {

				//_DEBUG("MYSQL Destruct");

				DBLibrary::Functions::Close(this->opflcon);
				DBLibrary::Functions::DeleteConnection(this->opflcon);

			}

		};

		OPFLConnection(const char * server, const char * username, const char * password)
		{
			this->opflcon = DBLibrary::Functions::Connect(server, username, password, DATABASE, false);
		}

		void ThreadInit()
		{
			DBLibrary::Functions::ThreadInit(this->opflcon);
		}

		void ThreadEnd()
		{
			DBLibrary::Functions::ThreadEnd(this->opflcon);
		}

		bool CommitData()
		{
			return DBLibrary::Functions::CommitData(this->opflcon);
		}

		// Returns true/false if exist
		bool Exists(const char * UIDName)
		{
			return DBLibrary::Functions::Exists(this->opflcon, UIDName);
		}

		//returns opfl dataset as struct
		bool GetAccount(const char * UIDName, OPFL_Account & act)
		{
			return DBLibrary::Functions::GetAccount(this->opflcon, UIDName, act);
		}
		bool GetBanData(const char * UIDName, OPFL_Account & act)
		{
			return DBLibrary::Functions::GetBanData(this->opflcon, UIDName, act);
		}

		//create opfl database rows and ignore if already exist
		bool CreateAccount(const char * UIDName)
		{
			return DBLibrary::Functions::CreateAccount(this->opflcon,  UIDName);
		}
		bool CreateBanData(const char * UIDName)
		{
			return DBLibrary::Functions::CreateBanData(this->opflcon, UIDName);
		}

		// write data to opfl database
		bool WriteKills(const char * UIDName, long long int kills)
		{
			return DBLibrary::Functions::WriteKills(this->opflcon, UIDName, kills);
		}
		bool WriteChickens(const char * UIDName, long long int chickens)
		{
			return DBLibrary::Functions::WriteChickens(this->opflcon, UIDName, chickens);
		}
		bool WriteAccount(const OPFL_Account * account)
		{
			return DBLibrary::Functions::WriteAccount(this->opflcon, account);
		}
		bool WriteBanData(const OPFL_Account * account)
		{
			return DBLibrary::Functions::WriteBanData(this->opflcon, account);
		}

	private:
		OPFL_CON opflcon;
	};


	class OPFLConnectionFactory : public ConnectionFactory {

	public:
		OPFLConnectionFactory(std::string server, std::string username, std::string password) {

			this->server = server;
			this->username = username;
			this->password = password;

		};

		// Any exceptions thrown here should be caught elsewhere
		std::shared_ptr<Connection> create() {

			// Create the connection
			std::shared_ptr<OPFLConnection> conn(new OPFLConnection(this->server.c_str(), this->username.c_str(), this->password.c_str()));

			return std::static_pointer_cast<Connection>(conn);
		};

	private:
		std::string server;
		std::string username;
		std::string password;
	};


	static std::shared_ptr<active911::OPFLConnectionFactory> mysql_connection_factory(new active911::OPFLConnectionFactory(DBHOST, USER, PASSWORD));
	static std::shared_ptr<active911::ConnectionPool<active911::OPFLConnection> > mysql_pool;


}