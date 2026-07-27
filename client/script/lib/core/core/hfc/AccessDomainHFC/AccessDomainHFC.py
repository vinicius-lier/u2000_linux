#coding=utf-8

import logging
import os
import sys,os,logging,time,shutil,re,codecs
import xml.dom.minidom as Dom
from logging.handlers import RotatingFileHandler
from Access_common_util import *


pythonFilePath = os.getcwd()
clientPath = pythonFilePath + '/../..'

logfile = clientPath + '/client/client/var/log/accessHFC.log'
head_list=["NE IP","Command","Result（Regex Match）" ]
logging.basicConfig(level=logging.INFO,
                    format='%(asctime)s %(filename)s %(process)d %(thread)d [line:%(lineno)d] %(levelname)s %(message)s',
                    datefmt='%a, %d %b %Y %H:%M:%S',
                    filename=logfile,
                    filemode='w')
Rthandler = RotatingFileHandler(logfile, maxBytes=50*1024*1024, backupCount=5)
format='%(asctime)s %(filename)s %(process)d %(thread)d [line:%(lineno)d] %(levelname)s %(message)s'
formatter = logging.Formatter(format)
Rthandler.setFormatter(formatter)
Rthandler.setLevel(logging.INFO)
logging.getLogger('').addHandler(Rthandler)

global commandlists
commandlists=[]

def Exc_DevCommand_B(devList, commandList, outPutPath):
    global commandlists
    commandlists = commandList
    body = {OperationMarkKey : ExcAccessCommandToNEKey,
           Devs: devList,
           Commands: commandlists
            }

    # print param
    logging.info('Exc_AccessCommand_T,Devs:' + str(devList))
    logging.info('Exc_AccessCommand_T,Commands:' + str(commandList))
    logging.info('Exc_AccessCommand_T,outPutPath:' + outPutPath)

    # get rep
    req = create_url_req(body)
    logging.info('Exc_AccessCommand_T,req:' + str(req))

    # get rsp
    rsp = send_http_req(req)
    logging.info('Exc_AccessCommand_T,rsp:' + str(rsp))

    # get DirName
    dirName = outPutPath.split(os.sep)[-1]
    logging.info('Exc_AccessCommand_T,dirName:' + dirName)

    # get HSKName
    HSKName = getHSLName(dirName)
    logging.info('Exc_AccessCommand_T,HSKName:' + HSKName)

    # get parentDir
    parentDir = outPutPath.replace(dirName, "")
    logging.info('Exc_AccessCommand_T,parentDir:' + parentDir)

    # delete outPutPath
    del_dir(parentDir, HSKName, outPutPath)

    # return result
    result = "please check the result in the directory: " + outPutPath + "\n"

    if isinstance(rsp, basestring):
        if str(rsp) == "400":
            result= "ERROR:Enter an incorrect command, Or is not in the whitelist"
        elif str(rsp) == "403":
            result = "ERROR:User authentication failed"
        elif str(rsp) == "10061":
            result = "ERROR:Failed to connect server"
        else:
            result = "ERROR:Server Exception"
    else:
        for item in rsp:
            devinfo=dict(item)
            logging.info('Exc_AccessCommand_T,devinfo:' + str(devinfo))
            logging.info('Exc_AccessCommand_T,devresult:' + devinfo["result"])
            save_result(devinfo["devIP"], devinfo["result"], str(outPutPath))
            result = result + devinfo["devIP"] + "_result.xml" + "\n"
    return result

def Parse_DevResult_B(devList, commands, regexpressions, outPutPath):
    # print param
    logging.info('ParseAccResult_T,Devs:' + str(devList))
    logging.info('ParseAccResult_T,Devs:' + str(type(devList)))
    logging.info('ParseAccResult_T,command:' + str(commands))
    logging.info('ParseAccResult_T,regexpression:' + str(regexpressions))
    logging.info('ParseAccResult_T,outPutPath:' + str(outPutPath))
    wr_data = [ ["NE IP","Command","Result（Regex Match）" ]]
    # get content
    for dev in devList:
        for file in os.listdir(outPutPath):
            if dev == file.split("_result.xml")[0]:
                fullpath = os.path.join(outPutPath, file)
                logging.info('ParseAccResult_T,get content from : ' + fullpath)
                doc = Dom.parse(fullpath)
                collection = doc.documentElement
                servlets = collection.getElementsByTagName("commond")
                for i in range(len(commands)):
                    comm = commands[i]
                    if comm in commandlists:
                        item = commandlists.index(comm) + 1
                        logging.info('ParseAccResult_T,item:\n' + str(item))
                        for servlet in servlets:
                            command = servlet.getElementsByTagName('serialno')[0]
                            command_data = command.childNodes[0].data.strip()
                            logging.info('ParseAccResult_T,command:\n' + command_data)
                            if command_data == str(item) :
                                logging.info('ParseAccResult_T,command:\n' + command_data)
                                result = servlet.getElementsByTagName('result')[0]
                                result_lines = result.childNodes[0].data.strip().split("\n")
                                result_data=echckregfunc(result_lines,regexpressions[i])
                                logging.info('ParseAccResult_T,result:\n' + result_data)
                                raw_data=[dev, comm , result_data ]
                                wr_data.append(raw_data)
                    else:
                        raw_data = [dev, comm,""]
                        wr_data.append(raw_data)
    return wr_data
