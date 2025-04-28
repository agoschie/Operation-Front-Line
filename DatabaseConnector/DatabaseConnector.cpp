// DatabaseConnector.cpp : Defines the exported functions for the DLL application.
//

#include "stdafx.h"
#include "DBLibrary.h"

#include <driver.h>
#include <connection.h>
#include <statement.h>
#include <prepared_statement.h>
#include <resultset.h>
//#include <metadata.h>
//#include <resultset_metadata.h>
#include <exception.h>
#include <warning.h>
#include <cstring>
#include <sstream>
#include <iomanip>

namespace DBLibrary
{
	struct OPFL_Connection
	{
		sql::Connection * con;
		sql::Driver * driver;
		sql::PreparedStatement * prep_createAccount;
		sql::PreparedStatement * prep_createBanData;
		sql::PreparedStatement * prep_writeAccount;
		sql::PreparedStatement * prep_writeBanData;
		sql::PreparedStatement * prep_writeKills;
		sql::PreparedStatement * prep_writeChickens;
		sql::PreparedStatement * prep_getAccount;
		sql::PreparedStatement * prep_getBanData;
		sql::PreparedStatement * prep_exists;
	};

	// returns void * to mysql connection, necessary due to different compilers, does not exist referencing application
	OPFL_CON Functions::Connect(const char * addr, const char * user, const char * pass, const char * schema, bool autoCommit)
	{
		static sql::Driver *driver = get_driver_instance();
		sql::Connection *con;
		OPFL_Connection * opflCon = new OPFL_Connection();

		OPFL_CON ret;

		//driver = get_driver_instance();
		con = driver->connect(addr, user, pass);
		con->setTransactionIsolation(sql::TRANSACTION_READ_COMMITTED);
		con->setSchema(schema);
		con->setAutoCommit(autoCommit);

		opflCon->con = con;
		opflCon->driver = driver;
		opflCon->prep_createAccount = con->prepareStatement("INSERT IGNORE INTO useraccounts (UIDName, Rank, Level, Matches, Wins, Losses, Kills, Chickens) VALUES (?, 1, 0, 0, 0, 0, 0, 0)");
		opflCon->prep_createBanData = con->prepareStatement("INSERT IGNORE INTO administration (UIDName, Ditch, Banned) VALUES (?, 0, NOW())");
		opflCon->prep_writeAccount = con->prepareStatement("UPDATE useraccounts SET Rank = ? , Level = ? , Matches = ? , Wins = ? , Losses = ? , Kills = ? , Chickens = ? WHERE UIDName = ?");
		opflCon->prep_writeBanData = con->prepareStatement("UPDATE administration SET Ditch = ? , Banned = ? WHERE UIDName = ?");
		opflCon->prep_writeKills = con->prepareStatement("UPDATE useraccounts SET Kills = Kills + ? WHERE UIDName = ?");
		opflCon->prep_writeChickens = con->prepareStatement("UPDATE useraccounts SET Chickens = Chickens + ? WHERE UIDName = ?");
		opflCon->prep_getAccount = con->prepareStatement("SELECT * FROM useraccounts WHERE UIDName = ? FOR UPDATE");
		opflCon->prep_getBanData = con->prepareStatement("SELECT * FROM administration WHERE UIDName = ? FOR UPDATE");
		opflCon->prep_exists = con->prepareStatement("SELECT EXISTS (SELECT * FROM useraccounts WHERE UIDName = ?)");

		ret = (OPFL_CON)opflCon;
		return ret;
	}
	
	bool Functions::CommitData(OPFL_CON con)
	{
		try
		{
			OPFL_Connection * opflCon;
			opflCon = (OPFL_Connection *)con;
			opflCon->con->commit();
			return true;
		}
		catch (const sql::SQLException & e)
		{
			return false;
		}
	}

	//returns true/false on close
	bool Functions::Close(OPFL_CON con)
	{

		OPFL_Connection * opflCon;
		try
		{
			opflCon = (OPFL_Connection *)con;
			opflCon->con->close();
			return true;
		}
		catch (const sql::SQLException & e)
		{
			return false;
		}
	}

	//these two functions handle thread resources
	void Functions::ThreadInit(OPFL_CON con)
	{
		OPFL_Connection * opflCon;
		opflCon = (OPFL_Connection *)con;
		opflCon->driver->threadInit();
	}

	void Functions::ThreadEnd(OPFL_CON con)
	{
		OPFL_Connection * opflCon;
		opflCon = (OPFL_Connection *)con;
		opflCon->driver->threadEnd();
	}

	// Returns true/false if exist
	bool Functions::Exists(OPFL_CON con, const char * UIDName)
	{
		sql::ResultSet * res;
		OPFL_Connection * opflCon = (OPFL_Connection *)con;
		bool ret;

		opflCon->prep_exists->setString(1, UIDName);
		res = opflCon->prep_exists->executeQuery();
		res->next();
		ret = res->getBoolean(1);
		delete res;
		return ret;
	}

	//returns opfl dataset as struct
	bool Functions::GetAccount(OPFL_CON con, const char * UIDName, OPFL_Account & act)
	{
		OPFL_Connection * opflCon = (OPFL_Connection *)con;
		sql::ResultSet * res;

		try
		{
			opflCon->prep_getAccount->setString(1, UIDName);
			res = opflCon->prep_getAccount->executeQuery();
			res->next();

			act.UIDName = new char[strlen(UIDName) + 1];
			strncpy_s(act.UIDName, strlen(UIDName) + 1, UIDName, strlen(UIDName) + 1);
			act.rank = res->getInt("Rank");
			act.level = res->getInt("Level");
			act.matches = res->getInt64("Matches");
			act.wins = res->getInt64("Wins");
			act.losses = res->getInt64("Losses");
			act.kills = res->getInt64("Kills");
			act.chickens = res->getInt64("Chickens");

			delete res;
			return true;
		}
		catch (const sql::SQLException & e)
		{
			return false;
		}
	}

	//returns opfl dataset as struct
	bool Functions::GetBanData(OPFL_CON con, const char * UIDName, OPFL_Account & act)
	{
		OPFL_Connection * opflCon = (OPFL_Connection *)con;
		sql::ResultSet * res;

		try
		{
			opflCon->prep_getBanData->setString(1, UIDName);
			res = opflCon->prep_getBanData->executeQuery();
			res->next();

			act.left = res->getInt64("Ditch");
			act.year = std::stoll(res->getString("Banned").substr(0, 4));
			act.month = std::stoll(res->getString("Banned").substr(5, 2));
			act.day = std::stoll(res->getString("Banned").substr(8, 2));
			act.hour = std::stoll(res->getString("Banned").substr(11, 2));
			act.minute = std::stoll(res->getString("Banned").substr(14, 2));
			act.second = std::stoll(res->getString("Banned").substr(17, 2));

			delete res;
			return true;
		}
		catch (const sql::SQLException & e)
		{
			return false;
		}
	}

	bool Functions::CreateAccount(OPFL_CON con, const char * UIDName)
	{
		OPFL_Connection * opflCon = (OPFL_Connection *)con;
		try
		{
			opflCon->prep_createAccount->setString(1, UIDName);
			opflCon->prep_createAccount->executeUpdate();

			return true;
		}
		catch (const sql::SQLException & e)
		{
			return false;
		}
	}

	bool Functions::CreateBanData(OPFL_CON con, const char * UIDName)
	{
		OPFL_Connection * opflCon = (OPFL_Connection *)con;
		try
		{
			opflCon->prep_createBanData->setString(1, UIDName);
			opflCon->prep_createBanData->executeUpdate();

			return true;
		}
		catch (const sql::SQLException & e)
		{
			return false;
		}
	}

	// write data to opfl database
	bool Functions::WriteKills(OPFL_CON con, const char * UIDName, long long int kills)
	{
		OPFL_Connection * opflCon = (OPFL_Connection *)con;
		try
		{
			opflCon->prep_writeKills->setInt64(1, kills);
			opflCon->prep_writeKills->setString(2, UIDName);
			opflCon->prep_writeKills->executeUpdate();

			return true;
		}
		catch (const sql::SQLException & e)
		{
			return false;
		}
	}
	bool Functions::WriteChickens(OPFL_CON con, const char * UIDName, long long int chickens)
	{
		OPFL_Connection * opflCon = (OPFL_Connection *)con;
		try
		{
			opflCon->prep_writeChickens->setInt64(1, chickens);
			opflCon->prep_writeChickens->setString(2, UIDName);
			opflCon->prep_writeChickens->executeUpdate();

			return true;
		}
		catch (const sql::SQLException & e)
		{
			return false;
		}
	}
	bool Functions::WriteAccount(OPFL_CON con, const OPFL_Account * account)
	{
		OPFL_Connection * opflCon = (OPFL_Connection *)con;
		/**
		std::stringstream out;
		out << std::setw(4) << std::setfill('0') 
			<< account->year
			<< "-"
			<< std::setw(2) << std::setfill('0')
			<< account->month 
			<< "-"
			<< std::setw(2) << std::setfill('0')
			<< account->day 
			<< " "
			<< std::setw(2) << std::setfill('0')
			<< account->hour 
			<< ":"
			<< std::setw(2) << std::setfill('0')
			<< account->minute 
			<< ":"
			<< std::setw(2) << std::setfill('0')
			<< account->second;
		*/
		try
		{
			opflCon->prep_writeAccount->setInt(1, account->rank);
			opflCon->prep_writeAccount->setInt(2, account->level);
			opflCon->prep_writeAccount->setInt64(3, account->matches);
			opflCon->prep_writeAccount->setInt64(4, account->wins);
			opflCon->prep_writeAccount->setInt64(5, account->losses);
			opflCon->prep_writeAccount->setInt64(6, account->kills);
			opflCon->prep_writeAccount->setInt64(7, account->chickens);
			opflCon->prep_writeAccount->setString(8, account->UIDName);
			
			opflCon->prep_writeAccount->executeUpdate();

			return true;
		}
		catch (const sql::SQLException & e)
		{
			return false;
		}
	}

	bool Functions::WriteBanData(OPFL_CON con, const OPFL_Account * account)
	{
		OPFL_Connection * opflCon = (OPFL_Connection *)con;
		std::stringstream out;
		out << std::setw(4) << std::setfill('0')
			<< account->year
			<< "-"
			<< std::setw(2) << std::setfill('0')
			<< account->month
			<< "-"
			<< std::setw(2) << std::setfill('0')
			<< account->day
			<< " "
			<< std::setw(2) << std::setfill('0')
			<< account->hour
			<< ":"
			<< std::setw(2) << std::setfill('0')
			<< account->minute
			<< ":"
			<< std::setw(2) << std::setfill('0')
			<< account->second;
		try
		{
			opflCon->prep_writeBanData->setInt64(1, account->left);
			opflCon->prep_writeBanData->setString(2, out.str());
			opflCon->prep_writeBanData->setString(3, account->UIDName);

			opflCon->prep_writeBanData->executeUpdate();

			return true;
		}
		catch (const sql::SQLException & e)
		{
			return false;
		}
	}

	bool Functions::DeleteData(OPFL_Account * ptr)
	{
		if (ptr->UIDName)
		{
			Functions::DeleteCSTRING(ptr->UIDName);
		}
		delete ptr;
		return true;
	}

	bool Functions::DeleteCSTRING(char * ptr)
	{
		delete[] ptr;
		return true;
	}

	bool Functions::DeleteConnection(OPFL_CON conn)
	{
		OPFL_Connection * con = (OPFL_Connection *)conn;
		delete con->prep_createAccount;
		delete con->prep_createBanData;
		delete con->prep_writeAccount;
		delete con->prep_writeBanData;
		delete con->prep_writeKills;
		delete con->prep_writeChickens;
		delete con->prep_getAccount;
		delete con->prep_getBanData;
		delete con->prep_exists;
		if (con->con)
		{
			delete con->con;
			delete con;
			return true;
		}
		else
		{
			delete con;
			return false;
		}
	}

	unsigned long long int Functions::DriverAddress(OPFL_CON con)
	{
		OPFL_Connection * opflcon = (OPFL_Connection *)con;
		return ((unsigned long long int) opflcon->driver);
	}
}

