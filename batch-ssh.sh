#!/bin/bash
#初始化值
file=0
username=${USER}
password="0"
port=22
timeout=2
#检查expect
front=$(rpm -qa expect |wc -l)
#判断传参
CheckValue(){
    #文件，用户名，密码，端口，超时时间
    #$1,$2,$3,$4,$5
    echo "batch-ssh: Link port: $port"
    echo "batch-ssh: Link timeout: $timeout s"
    cat $1 &> /dev/null
    if [ $? -ne 0 ];then
        echo "batch-ssh: Undefined file"
        exit 1
    fi
    if [ $3 = "0" ];then
        echo "batch-ssh: Undefined password"
        exit 1
    fi
}
#
Handle(){
    #$1=file,$2=username,$3=password,$4=timeout，$5=port
    for i in `cat $1` 
			#读文件
			do
			{
                #测试主机连通性
				ping -c1 -W1 $i &>/dev/null
				if [ $? -eq 0 ]; then
					(
					timeout $4 /usr/bin/expect <<-EOF
					spawn ssh-copy-id $2@$i -p $5
					expect {
						"yes/no"   {send "yes\r";exp_continue}
						"password" {send "$3\r"} 	
					}
					expect of
					EOF
					)&>/dev/null
					#测试连通性
					timeout $timeout ssh $i echo "$i success"
					if [ $? -ne 0 ];then
					#确定执行是否成功
						echo "batch-ssh: Please check whether the password of host $I is correct or whether port $o is not open"
					fi
				else
					echo "batch-ssh: Please check if the host $I exists"
				fi
			} done
}
#erro函数
err(){
    echo "batch-ssh: help"
}
#命令传参
if [[ "$#" > 0 && "$front" > 0  ]]; then
    while [[ $# > 0 ]]
    do
        k="$1"
        shift
        case $k in
            -f|--file)
                file=$1
                shift
            ;;
            -u|--username)
                username=$1
                shift
            ;;
            -p|--password)
                password=$1
                shift
            ;;
            -o|--port)
                port=$1
                shift
            ;;
            -t|--timeout)
                timeout=$1
                shift
            ;;
            *)
                echo "batch-ssh: There is no $k running parameter. You can use -h or --help to view the help"
                exit 1
            ;;
        esac
    done
    CheckValue $file $username $password $port $timeout
    #$1=file,$2=username,$3=password,$4=timeout，$5=port
    Handle $file $username $password $timeout $port
elif [[ $front = 0 ]];then
    echo "batch-ssh: If expect is not installed, you can execute "yum install expect""
else
    err
fi

