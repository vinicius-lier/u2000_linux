#Display string for package name

VTS=Versatile Tools Suite

VTS_COMMON=VTS Common Platform 
VTS_COMMON.InstallInfo = The common platform mainly includes the foundational components used by service tools.
VTS_COMMON.UninstallInfo = The common platform mainly includes the foundational components used by service tools.

VTS_VTSCOMMON=VTS Common package
VTS_COMMON_CLIENT=VTS Common package client
VTS_COMMON_DS=VTS Common package Desktop Service

VTS_VTSCOMMON_DIST=VTS Common package
VTS_COMMON_CLIENT=VTS Common package client
VTS_COMMON_DS=VTS Common package Desktop Service

VTS_BASE_DS=VTS IMAP Common package Desktop Service
VTS_BASE_CLIENT=VTS IMAP Common package client
VTS_BASE_COMMON=VTS IMAP Common package

#The return error code resource defination.
#  0 ~ 256 is valid error code
#  0 is successful,need no resource
#
#  1~200 is serious error,The install program will abort the installation
#  201 ~ 256 is ignorable error,The install program will continue installation,and will log the error 
1=serious error
2=serious error
101=ingorable error
220=Failed to initialize the database.
