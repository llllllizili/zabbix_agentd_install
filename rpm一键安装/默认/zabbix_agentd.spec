%define zabbix_user zabbix                  
#自定义宏，名字为zabbix_user值为zabbix,%{zabbix_user}引用

Name:   zabbix                              
#软件包的名字，后面可用%{name}引用

Version:    3.0.14                           
#软件的实际版本号，可使用%{version}引用

Release:    1%{?dist}                       
#发布序列号，标明第几次打包  

Summary:    zabbix_agentd                   
#软件包内容概要

Group:      zabbix                          
#软件包分组

License:    GPL
#授权许可方式

URL:        blog.dl1548.com                   
#软件的主页

Source0:    zabbix-3.0.14.tar.gz             
#源代码包，可以有Source0,Source1等源

BuildRequires:      net-tools
#gcc, gcc-c++            
#制作rpm包时，所依赖的基本库

Requires:   net-tools
#gcc, gcc-c++       
#安装rpm包时，所依赖的软件包

#BuildRoot: %{_tmpdir}/%{name}-%{version}-%{release}
#构建包的临时文件路径.centos5 不写会报错

%description                                
#定义rpm包的描述信息
Zabbix agentd
creata by jingkun-lizili
email: zili.li@foxmail.com

%pre                                        
#rpm包安装前执行的脚本
grep zabbix /etc/passwd > /dev/null
if [ $? != 0 ] 
then useradd zabbix -M -s /sbin/nologin
fi
[ -d /usr/local/zabbix ]||rm -rf /usr/local/zabbix*


%post                                       
#rpm包安装后执行的脚本

sed -i "/BASEDIR=\/usr\/local/c\BASEDIR=\/usr\/local\/%{name}" /etc/init.d/zabbix_agentd

%preun                                      
#rpm卸载前执行的脚本
/etc/init.d/zabbix_agentd stop

%postun                                     
#rpm卸载后执行的脚本
userdel  zabbix
rm -rf /usr/local/zabbix*

%prep

%setup -q                                   

%build                                      
#定义编译软件包时的操作
./configure --prefix=/usr/local/%{name}  --enable-agent
make -j8 %{?_smp_mflags}

%install                                    
#定义安装软件包，使用默认值即可
test -L %{buildroot}/etc/%{name} && rm -f %{buildroot}/etc/%{name}
install -d %{buildroot}/etc/profile.d
install -d %{buildroot}/etc/init.d
make install DESTDIR=%{buildroot}
echo 'export PATH=/etc/zabbix/bin:/etc/zabbix/sbin:$PATH' >> %{buildroot}/etc/profile.d/%{name}.sh
cp %{_builddir}/%{name}-%{version}/misc/init.d/fedora/core/zabbix_agentd       %{buildroot}/etc/init.d/zabbix_agentd

%files                                      
#定义rpm包安装时创建的相关目录及文件。在该选项中%defattr (-,root,root)一定要注意。它是指定安装文件的属性，分别是(mode,owner,group)，-表示默认值，对文本文件是0644，可执行文件是0755。
/usr/local/%{name}/*
/etc/init.d/zabbix_agentd
/etc/profile.d/%{name}.sh

%changelog                                  
#主要用于软件的变更日志。该选项可有可无

%clean 
rm -rf %{buildroot}                         
#清理临时文件


