# 服务组资源定义文件模板 
# 注意: 对于非中文的资源文件请把中文注释删除！！

# 定义服务组组的显示名称
# 格式： 
#     服务组组名称 = 服务组组显示名称
# 参数：
#     服务组组名称：在服务组描述文件内首层<group>的name属性值。
#     服务组组显示名称：在安装界面的服务组树上显示的服务组名称。
# 例子：
#     BASESERVICE_GROUP = 基础组件组

# 定义服务组的显示名称
# 格式：
#     服务组名称= 服务组显示名称
# 参数：
#     服务组名称：在服务组描述文件内第二层<servicegroup>的name属性值：
#     服务组显示名称：在安装界面的服务组树上显示的服务组名称：
# 例子：
#     BaseGroup = 基础服务

# 定义服务组的安装详细描述信息
# 格式：
#     服务组名称InstallInfo = 服务组详细描述信息。
# 参数：
#     服务组名称：在服务组描述文件内第二层<servicegroup>的name属性值。
#     服务组详细描述信息：在安装界面选择服务组时显示服务组的用途。使用\n表示回车符。
# 例子：
#     BaseGroup.InstallInfo = 提供系统运行的基础功能。

#-------------------------------------------------------------------------------
#--------------------------  基础服务组 ---------------------------------------
#-------------------------------------------------------------------------------
NW_ServiceGroup_Basic=

NW_Service_BASEGroup
NW_Service_BASEGroup.InstallInfo


NW_Service_FRAME_UFLIGHT
NW_Service_FRAME_UFLIGHT

NW_Service_COREGroup
NW_Service_COREGroup

NW_Service_DCCView
NW_Service_DCCView

NW_Service_imap_ds
NW_Service_imap_ds

NW_Service_IP_PATHVIEWER
NW_Service_IP_PATHVIEWER

NW_Service_ITFGroup
NW_Service_ITFGroup

NW_Service_SPM
NW_Service_SPM

NW_Service_trapreceiver
NW_Service_trapreceiver


#-------------------------------------------------------------------------------
#--------------------------  网络服务组 ---------------------------------------
#-------------------------------------------------------------------------------
NW_ServiceGroup_NW

NW_Service_Access_sub
NW_Service_Access_sub

NW_Service_PM
NW_Service_PM

NW_Service_PMCollector
NW_Service_PMCollector

NW_Service_ASON_OTN
NW_Service_ASON_OTN

NW_Service_ASON_SDH
NW_Service_ASON_SDH

NW_Service_NEMGR_BITS
NW_Service_NEMGR_BITS

NW_Service_NEMGR_EXT
NW_Service_NEMGR_EXT

NW_Service_NEMGR_MARINE
NW_Service_NEMGR_MARINE

NW_Service_NEMGR_NAOTN
NW_Service_NEMGR_NAOTN

NW_Service_NEMGR_NAWDM
NW_Service_NEMGR_NAWDM

NW_Service_NEMGR_OTN
NW_Service_NEMGR_OTN

NW_Service_NEMGR_PTN
NW_Service_NEMGR_PTN

NW_Service_NEMGR_ROUTER
NW_Service_NEMGR_ROUTER

NW_Service_NEMGR_RTN
NW_Service_NEMGR_RTN

NW_Service_NEMGR_SDH
NW_Service_NEMGR_SDH

NW_Service_NEMGR_SWITCH
NW_Service_NEMGR_SWITCH

NW_Service_NEMGR_VMF
NW_Service_NEMGR_VMF

NW_Service_NEMGR_V8PTN
NW_Service_NEMGR_V8PTN

NW_Service_NEMGR_WDM
NW_Service_NEMGR_WDM



NW_Service_NML_COMMON
NW_Service_NML_COMMON

NW_Service_NML_CPS
NW_Service_NML_CPS

NW_Service_NML_ETH
NW_Service_NML_ETH

NW_Service_NML_IP
NW_Service_NML_IP

NW_Service_NML_OTN
NW_Service_NML_OTN

NW_Service_NML_SDH
NW_Service_NML_SDH

NW_Service_NML_SDK
NW_Service_NML_SDK

NW_Service_NML_VLAN
NW_Service_NML_VLAN

NW_Service_PnP
NW_Service_PnP
