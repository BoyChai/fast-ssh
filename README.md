# fast-ssh

批量实现多台服务器之间ssh免密登录

# 安装

脚本依赖于expect需要先安装expect  
yum -y install expect  
git clone https://github.com/boychai/fast-ssh.git  
cd ./fast-ssh
cp fast-ssh.sh /bin/fast-ssh  
chmod u+x /bin/fast-ssh

# 使用

fast-ssh -f {文件} -p {密码} -u {用户} -o {端口}  

-f  指定主机文件 文件格式为一行一个ip的形式                         必须指定  
-p  指定密码     输入主机的密码                                    必须指定  
-u  指定用户     输入指定用户来进行ssh免密,默认为当前所登录的用户    可选  
-o  指定端口     指定ssh端口默认为22                               可选  
-t  指定超时时间 设置链接的超时时间，默认为2秒                      可选  
