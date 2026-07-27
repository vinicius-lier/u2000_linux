@ECHO OFF

REM ############################################################################
REM #           U2000V1R6C01 TR5 释放禁用占用80端口的服务
REM #   
REM #   
REM #   
REM #   
REM ############################################################################

echo exec %0 script...
echo Y|net stop w3svc > nul 2>&1
sc config w3svc start= disabled > nul 2>&1
rem 解决环境上没有此服务时执行以上命令返回非0值问题
exit 0