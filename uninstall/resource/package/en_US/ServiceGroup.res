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
#     服务组名称 = 服务组显示名称
# 参数：
#     服务组名称：在服务组描述文件内第二层<servicegroup>的name属性值。
#     服务组显示名称：在安装界面的服务组树上显示的服务组名称。
# 例子：
#     BaseGroup = 基础服务

# 定义服务组的安装详细描述信息
# 格式：
#     服务组名称.InstallInfo = 服务组详细描述信息。
# 参数：
#     服务组名称：在服务组描述文件内第二层<servicegroup>的name属性值。
#     服务组详细描述信息：在安装界面选择服务组时显示服务组的用途。使用\n表示回车符。
# 例子：
#     BaseGroup.InstallInfo = 提供系统运行的基础功能。


#-------------------------------------------------------------------------------
#--------------------------  基础服务组  ---------------------------------------
#-------------------------------------------------------------------------------
NW_ServiceGroup_Base=Base Service Group

NW_Service_BASEGroup=Base Group
NW_Service_BASEGroup.InstallInfo=Base Group


NW_Service_FRAME_UFLIGHT=Uflight Group
NW_Service_FRAME_UFLIGHT.InstallInfo=Uflight Group

NW_Service_COREGroup=Core Group
NW_Service_COREGroup.InstallInfo=Core Group

NW_Service_DCCView=DCC View
NW_Service_DCCView.InstallInfo=DCC View

NW_Service_imap_ds=DS
NW_Service_imap_ds.InstallInfo=DS

NW_Service_IP_PATHVIEWER=IP Path Viewer
NW_Service_IP_PATHVIEWER.InstallInfo=Supports IP service path viewer functions.

NW_Service_ITFGroup=
NW_Service_ITFGroup.InstallInfo=

NW_Service_SPM=Green Energy Management
NW_Service_SPM.InstallInfo=Supports green energy management.

NW_Service_trapreceiver=Extended Trap Receiver
NW_Service_trapreceiver.InstallInfo=Receive the trap reported from network elements, as the default extension for default trap receiver, use for SNMP interface device.


#-------------------------------------------------------------------------------
#--------------------------  网络服务组  ---------------------------------------
#-------------------------------------------------------------------------------
NW_ServiceGroup_NW=Network Service Group

NW_Service_Access_sub=
NW_Service_Access_sub.InstallInfo=

NW_Service_PM=Performance Management
NW_Service_PM.InstallInfo=Supports performance management, including performance monitoring, threshold management, performance query, performance report management and performance data collection.

NW_Service_PMCollector=Performance Management Collector
NW_Service_PMCollector.InstallInfo=Supports performance management, involving monitoring performance, managing thresholds, querying performance data, and managing performance reports.

NW_Service_ASON_OTN=Ason OTN Management
NW_Service_ASON_OTN.InstallInfo=Supports management of the ASON OTN network.

NW_Service_ASON_SDH=Ason SDH Management
NW_Service_ASON_SDH.InstallInfo=Supports management of the ASON SDH network

NW_Service_NEMGR_BITS=BITS Network Element Management
NW_Service_NEMGR_BITS.InstallInfo=Provides the management of BITS.

NW_Service_NEMGR_EXT=Third-Party Network Element Management
NW_Service_NEMGR_EXT.InstallInfo=Manages third-party transport NEs,include \nOptix OTU 40000\nOptix OSN 900A.

NW_Service_NEMGR_MARINE=Marine Network Element Management
NW_Service_NEMGR_MARINE.InstallInfo=Manages submarine cable NEs, include \nOptix BWS 1600S\nOptix PFE 1670\nOptix SLM 1630.

NW_Service_NEMGR_NAOTN=NA OTN Network Element Management
NW_Service_NEMGR_NAOTN.InstallInfo=Manages OTN NEs of NA version, include \nOptix OSN 1800(NA)\nOptix OSN 3800A\nOptix OSN 6800A\nOptix OSN 8800 T16/T32/T64(NA).

NW_Service_NEMGR_NAWDM=NA WDM Network Element Management
NW_Service_NEMGR_NAWDM.InstallInfo=Manages WDM NEs of NA version, include \nOptix BWS 1600A\nOptix BWS 1600G(NA).

NW_Service_NEMGR_OTN=OTN Network Element Management
NW_Service_NEMGR_OTN.InstallInfo=Manages OTN NEs, include \nOptix OSN 1800\nOptix OSN 3800\nOptix OSN 6800\nOptix OSN 8800 T16/T32/T64.

NW_Service_NEMGR_PTN=PTN Network Element  Management
NW_Service_NEMGR_PTN.InstallInfo=Manages shelf-shape and case-shape PTN Nes in the Metro Ethernet domain, include \nOptix PTN 3900\nOptix PTN 1900\nOptix PTN 910\nOptix PTN 912\nOptix PTN 950\nOptix PTN 905\nOptix RTN 910\nOptix RTN 950\nOptix RTN 980\nVirtual L2 NE\nVirtual L3 NE\nVirtual Physical Layer NE\nOptix PTN 3900-8\nATN910_V1\nATN950_V1.

NW_Service_NEMGR_ROUTER=Router Network Element Management
NW_Service_NEMGR_ROUTER.InstallInfo=Supports management of router NE series, including\nCX600\nNE40E\nNE80E\nNE5000E\nME60\nNE40\nNE80\nNE5000\nNE05\nNE08E\nNE16E\nNE20E\nNE08\nNE16\nNE20\nMA5200G\nNSE1000\nAR series\nSSP series\nATN980\nATN990.

NW_Service_NEMGR_RTN=RTN Network Element Management
NW_Service_NEMGR_RTN.InstallInfo=Manages RTN NEs, include \nOptix RTN 605\nOptix RTN 610\nOptix RTN 620.

NW_Service_NEMGR_SDH=SDH Network Element Management
NW_Service_NEMGR_SDH.InstallInfo=Manages SDH, MSTP, and OSN NEs, include \nOptix 155/622B_I\nOptix 155/622B_II\nOptix 155C\nOptix 155S\nOptix 2500\nOptix 2500 REG\nVirtual NE\nOptix 10G(Metro5000)\nOptix 155/622(Metro2050)\nOptix 155/622H(Metro1000)\nOptix Metro100\nOptix Metro1000V3\nOptix Metro1050\nOptix Metro1100\nOptix Metro200\nOptix Metro3100\nOptix Metro500\nOptix OSN 1500\nOptix OSN 2000\nOptix OSN 2500\nOptix OSN 2500 REG\nOptix OSN 3500\nOptix OSN 500\nOptix OSN 550\nOptix OSN 7500\nOptix OSN 7500II\nOptix OSN 9500\nOptix OSN 9560.

NW_Service_NEMGR_SWITCH=Switch Network Element Management
NW_Service_NEMGR_SWITCH.InstallInfo=Supports management of switch NE series,\nS23\nS33\nS53\nS63\nS93\nCX200D\nS_VASP.

NW_Service_NEMGR_VMF=VRP V8 Router NE Management
NW_Service_NEMGR_VMF.InstallInfo=Supports NE management of VRP V8 series routers include NE5000E,NE5000E-Multi.

NW_Service_NEMGR_WDM=WDM Network Element Management
NW_Service_NEMGR_WDM.InstallInfo=Manages LH WDM and Metro WDM NEs, include \nOptix BWS 1600G\nOptix BWS 1600G OLA\nOptix BWS 320GV3\nOptix BWS OAS\nOptix BWS OCS\nOptix BWS OIS\nOptix Metro 6020\nOptix Metro 6040\nOptix Metro 6040V2\nOptix Metro 6100\nOptix Metro 6100V1\nOptix Metro 6100V1E.

NW_Service_NEMGR_V8PTN=VRP V8 PTN NE Management
NW_Service_NEMGR_V8PTN.InstallInfo=Supports NE management of VRP V8 series PTN include Optix PTN 7900-32.

NW_Service_NML_COMMON=Service Management Base Component
NW_Service_NML_COMMON.InstallInfo=Provides end-to-end common management functions, such as clock view management and alarm correlation rule management.

NW_Service_NML_CPS=Composite Service Management
NW_Service_NML_CPS.InstallInfo=Provides the function to manage composite services, such as VLL+VPLS, PWE3+EPL, and VPLS+L3VPN services.

NW_Service_NML_ETH=MSTP Service Management
NW_Service_NML_ETH.InstallInfo=Provides the end-to-end Ethernet service management function, which helps to quickly configure or maintain EPL, EVPL, EPLAN, RPR EVPL, RPR EVPLAN, and ATM services. After the source and sink of a service are specified, the U2000 automatically calculates routes and creates the service on NEs.

NW_Service_NML_IP=IP Service Management
NW_Service_NML_IP.InstallInfo=Provides the end-to-end IP service management function, which helps to quickly configure or maintain tunnel, PWE3, VLL, VPLS, and L3VPN services. End-to-end protection, OAM, BFD, and testing are supported.

NW_Service_NML_OTN=OTN Service Management
NW_Service_NML_OTN.InstallInfo=Provides the end-to-end OTN service management function, which helps to quickly configure or maintain OCh, ODUk, and Client OTN services. After the source and sink of a service are specified, the U2000 automatically calculates routes and creates the service on NEs.

NW_Service_NML_SDH=SDH Service Management
NW_Service_NML_SDH.InstallInfo=Provides the end-to-end SDH service management function, which helps to quickly configure or maintain PDH microwave services, as well as SDH services of the VC12, VC3, VC4, and VC4-Xc levels. After the source and sink of a service are specified, the U2000 automatically calculates routes and creates the service on NEs.

NW_Service_NML_SDK=
NW_Service_NML_SDK.InstallInfo=

NW_Service_NML_VLAN=Nativeeth Service Management
NW_Service_NML_VLAN.InstallInfo=Provides the Native Ethernet service management function, which helps to quickly configure or maintain microware Ethernet services. After the service access interface is specified, the U2000 automatically calculates routes and creates the service on NEs.

NW_Service_PnP=Device Auto Config
NW_Service_PnP.InstallInfo=Provides the function of assigning IP addresses and initializing NE configurations automatically through DHCP after NEs go online.

