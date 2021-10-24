# Batch-SSH
批量实现多台服务器之间ssh免密登录 
# 安装 # 
脚本依赖于expect需要先安装expect
yum -t install expect
下载好Batch-SSH之后放到/bin/目录下并且给一个可执行权限
cp batch-ssh /bin/
chmod u+x /bin/batch-ssh
# 使用 #
batch-ssh -f {文件} -p {密码} -u {用户} -o {端口}

-f  指定主机文件 文件格式为一行一个ip的形式                     必须指定
-p  指定密码 输入主机的密码                                    必须指定 
-u  指定用户 输入指定用户来进行ssh免密,默认为当前所登录的用户   可选
-o  指定端口 指定ssh端口默认为22                               可选

