#!/bin/bash
#Define default values and initialization
file=0
username=${USER}
password=0
port=22
timeout=2
#Get parameters
while getopts ':f:u:p:o:t:' OPT; do
    case $OPT in
        f) file="$OPTARG";;
	u) username="$OPTARG";;
        p) password="$OPTARG";;
        o) port="$OPTARG";;
	t) timeout="$OPTARG";;
        ?) echo "batch: Please use the -f parameter to specify the file, or use -h query help.";;
    esac
done
#main program
if [ $file !=  0 ];then
#Determine whether the file is specified
	lsfile=$(ls |grep $file)
	if [ "$lsfile"x = "$file"x ];then
	#Determine whether the file exists
		if [ $password !=  0 ];then
		#Determine whether to specify a password
			for i in `cat $file` 
			#Read the file to determine whether the host is in stock
			do
			{
				ping -c1 -W1 $i &>/dev/null
				if [ $? -eq 0 ]; then
					(
					timeout $timeout /usr/bin/expect <<-EOF
					spawn ssh-copy-id $username@$i
					expect {
						"yes/no"   {send "yes\r";exp_continue}
						"password" {send "$password\r"} 	
					}
					expect of
					EOF
					)&>/dev/null
					#In case of survival, it shall be implemented in batch
					timeout $timeout ssh $i echo "$i success"
					if [ $? -ne 0 ];then
					#Determine whether the execution is successful
						echo "batch-ssh: Please check whether the host $i password is correct or port $o is not open"
					fi
				else
					echo "batch-ssh: Please check whether the host $i exists"
				fi
			} done
		else
			echo "batch-ssh: Please use the -p parameter to specify the password or -h to query help."
		fi
	else
		echo "batch-ssh:This file was not found $file"
	fi
else
	echo "batch-ssh: Please use the -f parameter to specify the file, or use -h query help."
fi
