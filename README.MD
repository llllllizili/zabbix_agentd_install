#### FTP方式

```
在ZBX server 上搭建FTP服务器.(yum -y install vsftpd)默认文件路径在/var/ftp/
将FTP内容的脚本,以及rpm包(编译后的包)上传到相关目录,注意修改脚本中下载文件路径.
将jk.sh 方式agent主机执行即可
```

#### 其他方式

`rmp一键安装`中提供了相关的包构建参考文件,可自行构建不同版本安装包.

`编译后的包`中提供参考的rpm包
