################################################################################
#                   SingleOSS 1.0 U2000组件树资源(zh_CN)
#
#
################################################################################

Base                                    = 公共组件
Base.InstallInfo                        = 公共组件
NE_Management                           = 网元管理
NE_Management.InstallInfo               = 网元管理
NML_Management                          = 网络业务管理
NML_Management.InstallInfo              = 网络业务管理
Other                                   = 其他组件
Other.InstallInfo                       = 其他组件

AgentIntegrate_COMPONENT                =  解决方案集成接口
AgentIntegrate_COMPONENT.InstallInfo    =  为U2000解决方案中的其他系统提供集成接口服务。

Base_Component                          = 基础组件
Base_Component.InstallInfo              = 网管基础组件，包括WEB服务、网元分布式部署服务、网元操作日志和运行日志数据采集、物理资源存量数据管理等功能
ENGR_CAU_COMPONENT                      = 客户端自动升级
ENGR_CAU_COMPONENT.InstallInfo          = 提供客户端自动升级功能
PMS                                     = 性能管理
PMS.InstallInfo                         = 提供性能管理功能，包括性能监控、门限管理、性能查询、性能报表、性能采集等功能
IP_COMMON_COMPONENT                     = IP公共组件
IP_COMMON_COMPONENT.InstallInfo         = IP公共组件
NML_COMMON_COMPONENT                    = 业务管理基础组件
NML_COMMON_COMPONENT.InstallInfo        = 提供端到端公共管理功能，包括时钟视图、告警相关性规则管理功能。
NML_VLAN_COMPONENT                      = Nativeeth业务管理
NML_VLAN_COMPONENT.InstallInfo          = 提供Native Ethernet业务管理功能，可以快捷地配置和维护微波以太业务，只需指定业务的接入接口，U2000即可自动完成路由的计算与各网元上业务的创建。
NML_CPS_COMPONENT                       = 组合业务网络管理
NML_CPS_COMPONENT.InstallInfo           = 提供组合业务管理功能，将不同承载技术的业务组合成一个整体进行管理，支持VLL+VPLS、PWE3+EPL、VPLS+L3VPN。
NML_IP_COMPONENT                        = IP业务管理
NML_IP_COMPONENT.InstallInfo            = 提供IP端到端管理功能，可以快捷地配置和维护Tunnel、PWE3、VLL、VPLS、L3VPN、汇聚PWE3业务，支持端到端方式的保护、OAM、BFD、测试功能。

default_trap_receiver                   = 缺省Trap接收器
default_trap_receiver.InstallInfo       = 提供网元Trap上报的接受功能，主要用于SNMP接口设备。
GEM_COMPONENT                           = 绿色能源管理
GEM_COMPONENT.InstallInfo               = 提供绿色能源管理功能。

PRODUCT_CUSTOMIZE_COMPONENT             = 平台定制组件
PRODUCT_CUSTOMIZE_COMPONENT.InstallInfo = 提供平台定制功能
TrapReceiver_not_default                = 扩展Trap接收器
TrapReceiver_not_default.InstallInfo    = 提供网元Trap上报的接受功能，作为缺省Trap接收器的扩展，用于SNMP接口设备。
