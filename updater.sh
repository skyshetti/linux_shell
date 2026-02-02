#!/bin/bash

release_file=/etc/os-release
logfile=/var/log/updater.log
errorlog=/var/log/updater_error.log

check_exit_status(){
	if [ $? -ne 0 ]
	then 
		echo "An error occured, Please check $errorlog file"
	fi
}

if grep -q "Arch" $release_file
then
	#the host is based on arch, run the pacman to update command
	sudo pacman -Syu 1>>$logfile 2>>$errorlog
	check_exit_status
fi

if grep -q "Pop" $release_file || grep -q "Ubuntu" $release_file
then
	# the host is based on  ubuntu or  pop, run the apt version of command
	sudo apt update 1>>$logfile 2>>$errorlog
	check_exit_status

	sudo apt dist-upgrade -y 1>>$logfile 2>>$errorlog
	check_exit_status
fi


