#coding=utf-8

import ssl
import httplib
import socket
import urllib
import urllib2
import json
import re
import time
import os
import uuid
import random
import time
import Logger
import logging
import shutil
from socket import create_connection
from urllib2 import *
from ssl import *
from kernel import GetGlobalEnv
Flag2_Key = 'userid'
Flag1_Key = 'token'
Host = 'AccessiSStarHost'

#trustCert
Flag2 = 'AccessiSStar_Flag2'

#token
Flag1 = 'AccessiSStar_Flag1'
User_Flag = 'AccessiSStarUser'

SUCCESS = 0

OperationMarkKey = 'mark'
Devs = 'devs'
Commands = 'commands'

ResultKey = 'result'
ErrcodeKey = 'errcode'
ExcAccessCommandToNEKey = 'Exc_AccessCommand_ToNE'

errorDict = {0:  "success",
             1:  "invalid parameters",
             2:  "failed"}


class HttpsConnection(httplib.HTTPSConnection):
    """
    Https connection mgr class, inherit with httplib.HTTPSConnection
    """
    def __init__(self, *args, **kwargs):
        httplib.HTTPSConnection.__init__(self, *args, **kwargs)

    def connect(self):
        sock = create_connection((self.host, self.port))
        if self._tunnel_host:
            self.sock = sock
            self._tunnel()
        try:
            self.key_file = GetGlobalEnv(Flag2)
            self.cert_file = GetGlobalEnv(Flag2)
            self.sock = ssl.wrap_socket(sock, ssl_version=ssl.PROTOCOL_TLSv1_2)
        except ssl.SSLError as e:
            return e.strerror
        return


class HttpsHandler(urllib2.HTTPSHandler):
    """
    A https opener, inherit with urllib2.HTTPSHandler
    """
    def https_open(self, req):
        return self.do_open(HttpsConnection, req)


def create_url_req(req_data):
    """
    Create url request for http(s) request.

    :param req_data: A request data information, json string type
    :return:require data
    """
    values = json.dumps(req_data)
    url = 'https://' + GetGlobalEnv(Host) + ':30106/bmsisstar'
    urllib2.install_opener(urllib2.build_opener(HttpsHandler()))
    req = urllib2.Request(url=url, data=values)
    req.add_header(Flag1_Key, GetGlobalEnv(Flag1))
    req.add_header(Flag2_Key, GetGlobalEnv(User_Flag))

    return req

def send_http_req(req):
    """
    Send http request
    :param req: request dada
    :return: response data
    """
    try:
        response = urllib2.urlopen(req,timeout=10)
        rsp = response.read()
        data = json.loads(rsp)
    except Exception, e:
        if len(re.findall("\d+",str(e)))>0:
            data=str(re.findall("\d+",str(e))[0])
        else:
            data=str(e)
    return data


def get_session():
    """
    Get a random session id with uuid as seed
    :return:A session string
    """
    #一些常量信息+时间戳+加随机数生成uuid做seed
    random.seed(uuid.uuid1())
    session = str(random.random())
    return session.replace(".", "0")


def record_count(userfile, context):
    """
    count 'context' in 'userfile' file. Use 'for ...in file-iterator' for large file read, do not read all context at one time
    :param userfile: file Name
    :param context: context witch want to count
    :return: count number
    """
    total = 0
    with open(userfile, 'r') as fp:
        for line in fp:
            total = total + line.count(context)
    return total


def translate_errcode(errcode):
    """
    Translate errcode(int) to error message.
    :param errcode: error code
    :return: error message. If can't find errcode in errorDict return "unknown reason"
    """
    if isinstance(errcode, int):
        if SUCCESS == errcode:
            return True, errorDict.get(errcode, "unknown reason of failure")
        else:
            return False, errorDict.get(errcode, "unknown reason of failure")
    else:
        return False, "unknown reason of failure"


def convert_string(message):
    """
    convert message to string type
    :param message:
    :return:
    """
    if isinstance(message, unicode):
        return str(message)
    elif isinstance(message, str):
        return message
    else:
        return ""

def save_result(devip, dev_result, result_path):
    """
    save result to the dir
    :param rep:
    :return:
    """
    filename = result_path + os.sep + devip + "_result.xml";
    f = open(filename,'a+')
    f.write(dev_result)
    f.close()

def del_dir(sourceDir, key, currentDir):
    for dir in os.listdir(sourceDir):
        fullpath = os.path.join(sourceDir, dir)
        if os.path.isdir(fullpath) and fullpath != currentDir and fullpath.endswith(key):
            shutil.rmtree(fullpath)

def getHSLName(DirName):
    ListDirName = DirName.split("-")
    DirKey = "";
    if len(ListDirName) == 1:
        DirKey = DirName
    else:
        for i in range(len(ListDirName)):
            if i > 1 :
                DirKey = DirKey + "-" + ListDirName[i];
    return DirKey

def echckregfunc(result_datas,regexpress):
    return_str=""
    for result_line in result_datas:
        if  len(regexpress) > 0:
            if re.search(regexpress,result_line):
                return_str= return_str + result_line +"\n"
        else:
            return_str = return_str + result_line +"\n"
    return return_str.lstrip("")
