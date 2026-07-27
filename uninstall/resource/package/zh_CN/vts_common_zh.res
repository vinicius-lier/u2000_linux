#Display string for package name

VTS=通用服务工具套件

VTS_COMMON=VTS公共组件 
VTS_COMMON.InstallInfo = 公共组件主要包括服务工具使用到的基础组件。
VTS_COMMON.UninstallInfo = 公共组件主要包括服务工具使用到的基础组件。

VTS_VTSCOMMON=VTS公共组件
VTS_COMMON_CLIENT=VTS公共组件客户端
VTS_COMMON_DS=VTS公共组件桌面服务

VTS_VTSCOMMON_DIST=VTS公共组件
VTS_COMMON_CLIENT=VTS公共组件客户端
VTS_COMMON_DS=VTS公共组件桌面服务

VTS_BASE_DS=VTS IMAP公共组件桌面服务
VTS_BASE_CLIENT=VTS IMAP公共组件客户端
VTS_BASE_COMMON=VTS IMAP公共组件

#The return error code resource defination.
#  0 ~ 256 is valid error code
#  0 is successful,need no resource
#
#  1~200 is serious error,The install program will abort the installation
#  201 ~ 256 is ignorable error,The install program will continue installation,and will log the error 
1=严重错误
2=严重错误
101=可忽略的错误
220=数据库初始化失败。
