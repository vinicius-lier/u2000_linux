################################################################################
#                   SingleOSS 1.0 U2000组件树资源(en_US)
#
#
################################################################################

Base                                    = Common Component
Base.InstallInfo                        = Common Component
NE_Management                           = Network Element  Management
NE_Management.InstallInfo               = Network Element  Management
NML_Management                          = Network Service Management
NML_Management.InstallInfo              = Network Service Management
Other                                   = Other Component
Other.InstallInfo                       = Other Component

AgentIntegrate_COMPONENT                =  Solution Integrate Interface
AgentIntegrate_COMPONENT.InstallInfo    =  Provide integrate interface service to other systems in U2000 solution.

Base_Component                          = Base Component
Base_Component.InstallInfo              = U2000 base components, providing the functions of Web services, deploying NEs in distributed mode, collecting NE operation logs and running logs, and managing inventories of physical resources
ENGR_CAU_COMPONENT                      = Client Auto Upgrade
ENGR_CAU_COMPONENT.InstallInfo          = Provides the client upgrade services
PMS                                     = Performance Management
PMS.InstallInfo                         = Supports performance management, including performance monitoring, threshold management, performance query, performance report management and performance data collection.
IP_COMMON_COMPONENT                     = IP COMMON COMPONENT
IP_COMMON_COMPONENT.InstallInfo         = IP COMMON COMPONENT
NML_COMMON_COMPONENT                    = Service Management Base Component
NML_COMMON_COMPONENT.InstallInfo        = Provides end-to-end common management functions, such as clock view management and alarm correlation rule management.
NML_VLAN_COMPONENT                      = Nativeeth Service Management
NML_VLAN_COMPONENT.InstallInfo          = Provides the Native Ethernet service management function, which helps to quickly configure or maintain microware Ethernet services. After the service access interface is specified, the U2000 automatically calculates routes and creates the service on NEs.
NML_CPS_COMPONENT                       = Composite Service Management
NML_CPS_COMPONENT.InstallInfo           = Provides the function to manage composite services, such as VLL+VPLS, PWE3+EPL, and VPLS+L3VPN services.
NML_IP_COMPONENT                        = IP Service Management
NML_IP_COMPONENT.InstallInfo            = Provides the end-to-end IP service management function, which helps to quickly configure or maintain tunnel, PWE3, VLL, VPLS, and L3VPN services. End-to-end protection, OAM, BFD, and testing are supported.

default_trap_receiver                   = Default Trap Receiver
default_trap_receiver.InstallInfo       = Receive the trap reported from network elements, for the SNMP interface device.
GEM_COMPONENT                           = Green Energy Management
GEM_COMPONENT.InstallInfo               = Supports green energy management.

PRODUCT_CUSTOMIZE_COMPONENT             = product customize component
PRODUCT_CUSTOMIZE_COMPONENT.InstallInfo = Provides product customize functions
TrapReceiver_not_default                = Extended Trap Receiver
TrapReceiver_not_default.InstallInfo    = Receive the trap reported from network elements, as the default extension for default trap receiver, use for SNMP interface device.
