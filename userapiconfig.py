﻿# Config
NODE_ID = 1


# hour,set 0 to disable
SPEEDTEST = 24
CLOUDSAFE = 1
ANTISSATTACK = 1
AUTOEXEC = 0
MULTI_THREAD = 1

MU_SUFFIX = 'cloudflare.com'  # zhaoj.in
MU_REGEX = '%5m%id.%suffix'  # zhaoj.in

SERVER_PUB_ADDR = '127.0.0.1'  # mujson_mgr need this to generate ssr link
API_INTERFACE = 'glzjinmod'  # glzjinmod, modwebapi

WEBAPI_URL = 'https://zhaoj.in'
WEBAPI_TOKEN = 'glzjin'

# mudb
MUDB_FILE = 'mudb.json'

# Mysql
MYSQL_HOST = '127.0.0.1'
MYSQL_PORT = 3306
MYSQL_USER = 'ss'
MYSQL_PASS = 'ss'
MYSQL_DB = 'shadowsocks'

MYSQL_SSL_ENABLE = 0
MYSQL_SSL_CA = ''
MYSQL_SSL_CERT = ''
MYSQL_SSL_KEY = ''

# API
API_HOST = '127.0.0.1'
API_PORT = 80
API_PATH = '/mu/v2/'
API_TOKEN = 'abcdef'
API_UPDATE_TIME = 60

# Manager (ignore this)
MANAGE_PASS = 'ss233333333'
# if you want manage in other server you should set this value to global ip
MANAGE_BIND_IP = '127.0.0.1'
# make sure this port is idle
MANAGE_PORT = 23333
