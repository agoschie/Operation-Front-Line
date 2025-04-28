// DBLibrary.h - Contains declaration of Function class
#pragma once
#include <string>
#include "OPFL_Account.h"

#ifdef DBLIBRARY_EXPORTS
#define DBLIBRARY_API __declspec(dllexport) 
#else
#define DBLIBRARY_API __declspec(dllimport) 
#endif

typedef void * OPFL_CON;

namespace DBLibrary
{
	// This class is exported from the DatabaseConnector.dll

	class Functions
	{
	public:
		// returns void * to mysql connection, necessary due to different compilers, does not exist referencing application
		static DBLIBRARY_API OPFL_CON Connect(const char * addr, const char * user, const char * pass, const char * schema, bool autoCommit);
		static DBLIBRARY_API bool CommitData(OPFL_CON con);
		static DBLIBRARY_API bool Close(OPFL_CON con);

		//thread resources
		static DBLIBRARY_API void ThreadInit(OPFL_CON con);
		static DBLIBRARY_API void ThreadEnd(OPFL_CON con);

		// Returns true if exists
		static DBLIBRARY_API bool Exists(OPFL_CON con, const char * UIDName);

		//returns opfl dataset as struct
		static DBLIBRARY_API bool GetAccount(OPFL_CON con, const char * UIDName, OPFL_Account & act);
		static DBLIBRARY_API bool GetBanData(OPFL_CON con, const char * UIDName, OPFL_Account & act);

		// write data to opfl database
		static DBLIBRARY_API bool CreateAccount(OPFL_CON con, const char * UIDName);
		static DBLIBRARY_API bool CreateBanData(OPFL_CON con, const char * UIDName);
		static DBLIBRARY_API bool WriteKills(OPFL_CON con, const char * UIDName, long long int kills);
		static DBLIBRARY_API bool WriteChickens(OPFL_CON con, const char * UIDName, long long int chickens);
		static DBLIBRARY_API bool WriteAccount(OPFL_CON con, const OPFL_Account * account);
		static DBLIBRARY_API bool WriteBanData(OPFL_CON con, const OPFL_Account * account);

		//delete passed data
		static DBLIBRARY_API bool DeleteData(OPFL_Account * ptr);
		static DBLIBRARY_API bool DeleteCSTRING(char * ptr);
		static DBLIBRARY_API bool DeleteConnection(OPFL_CON conn);

		//other utilities
		static DBLIBRARY_API unsigned long long int DriverAddress(OPFL_CON con);

		
	};
}