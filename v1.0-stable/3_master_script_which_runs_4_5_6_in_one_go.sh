#!/bin/bash
#
# This script aims to run in one go scripts 4, 5 and 6
#
#
# polytan02@mcgva.org
# 03/02/2015
#

# Setup of colours for error codes
set -e
txtgrn=$(tput setaf 2)    # Green
txtred=$(tput setaf 1)    # Red
txtcyn=$(tput setaf 6)    # Cyan
txtrst=$(tput sgr0)       # Text reset
failed=[${txtred}FAILED${txtrst}]
ok=[${txtgrn}OK${txtrst}]
info=[${txtcyn}INFO${txtrst}]

# Make sure only root can run our script
if [[ $EUID -ne 0 ]];
        then   echo -e "\n$failed This script must be run as root\n";
        read -e -p "Hit ENTER to end this script...  "
        exit;
fi

# We check that all necessary files are present
for i in 4_install_certssl.sh 5_opendkim.sh 6_apticron_jail2ban_email_reports.sh
do
        if ! [ -a "$i" ]
	then echo -e "\n$failed $i not found in folder $files ";
        echo -e "\nAborting before doing anything\n";
	read -e -p "Hit ENTER to end this script...  "
	exit;
	else chmod +x $i;
        fi
done

# We run script 4_install_certssl.sh
echo -e "\n$info CONFIGURATION OF SSL\n"
read -e -p "Do you want to pursue with this part of the script ? (yn) : " -i "y" s4
if [ $s4 == 'y' ]
	then ./4_install_certssl.sh;
	else echo -e "\nSkipping SSL configuration\n";
	read -e -p "Hit ENTER to end this script...  "
fi;

# We run script 5_opendkim.sh
echo -e "\n$info CONFIGURATION OF OpenDKIM\n"
read -e -p "Do you want to pursue with this part of the script ? (yn) : " -i "y" s5
if [ $s5 == 'y' ]
	then ./5_opendkim.sh;
	else echo -e "\nSkipping OpendDKIM configuration\n";
	read -e -p "Hit ENTER to end this script...  "
fi;

# We run script 6_apticron_jail2ban_email_reports.sh
echo -e "\n$info CONFIGURATION OF APTICRON and FAIL2BAN\n"
read -e -p "Do you want to pursue with this part of the script ? (yn) : " -i "y" s6
if [ $s6 == 'y' ]
	then ./6_apticron_jail2ban_email_reports.sh
	else echo -e "\nSkipping Apticron and Jail2ban configuration\n";
	read -e -p "Hit ENTER to end this script...  "
fi;


