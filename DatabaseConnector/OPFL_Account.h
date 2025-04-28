#pragma once
#define DBHOST "tcp://127.0.0.1:3306"
#define USER "root"
#define PASSWORD "password"
#define DATABASE "OPFL"

#define NUMOFFSET 100
#define COLNAME 200
//low level opfl account struct, make sure UIDName id deleted in the dll/allocation space it originated from
struct OPFL_Account
{
	long long int second;
	long long int minute;
	long long int hour;
	long long int day;
	long long int month;
	long long int year;

	long long int left;
	long long int chickens;
	long long int kills;
	long long int matches;
	long long int wins;
	long long int losses;

	int rank;
	int level;

	char * UIDName;
};