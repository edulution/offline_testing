#!/bin/bash
# Copy file from remote server to local machine
echo Retreiving list of Literacy users from remote server....
sshpass -p $SSHPASS scp edulution@130.211.93.74:~/ixl/ixl_users.csv ~/.baseline_testing/

if [ "$?" = "0" ]; then
	echo List of Literacy users fetched sucessfully!
else
	echo Failed to retrieve list of Literacy Users. Please check your internet connection and try again 1>&2
	exit 1
fi