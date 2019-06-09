FROM alpine:3.8
#2019-06-05

ENV DNS_1=1.0.0.1                 \
    DNS_2=8.8.8.8                 \
    NODE_ID=0                     \
    SPEEDTEST=6                   \
    CLOUDSAFE=1                   \
    AUTOEXEC=1                    \
    ANTISSATTACK=1                \
    MU_SUFFIX=zhaoj.in            \
    MU_REGEX=%5m%id.%suffix       \
    API_INTERFACE=modwebapi       \
    WEBAPI_URL=https://zhaoj.in   \
    WEBAPI_TOKEN=glzjin           \
    MYSQL_HOST=127.0.0.1          \
    MYSQL_PORT=3306               \
    MYSQL_USER=ss                 \
    MYSQL_PASS=ss                 \
    MYSQL_DB=shadowsocks          \
    REDIRECT=cloudflare.com       \
    por=443                       \
    FAST_OPEN=false
    
RUN apk update    
RUN apk add --no-cache tzdata   && \
    echo "Hongkong" > /etc/timezone && \ 
    ln -sf /usr/share/zoneinfo/Hongkong /etc/localtime 

RUN apk --no-cache add \
                        wget \
                        python3-dev \
                        libsodium-dev \
                        openssl-dev \
                        udns-dev \
                        mbedtls-dev \
                        pcre-dev \
                        libev-dev \
                        libtool \
                        libffi-dev            && \
     apk --no-cache add --virtual .build-deps \
                        git \
                        tar \
                        make \
                        py3-pip \
                        autoconf \
                        automake \
                        build-base \
                        linux-headers         && \
     ln -s /usr/bin/python3 /usr/bin/python   && \
     ln -s /usr/bin/pip3    /usr/bin/pip      && \
     git clone -b test https://github.com/aiastia/testssr.git "/root/shadowsocks" --depth 1 && \
     pip install --upgrade pip                && \
     cd  /root/shadowsocks                    && \
     pip install -r requirements.txt          && \
     cp  apiconfig.py userapiconfig.py        && \
     rm -rf ~/.cache && touch /etc/hosts.deny && \
     wget https://raw.githubusercontent.com/aiastia/banip/master/hosts.deny -O hosts.deny && \
     cat ./hosts.deny >> /etc/hosts.deny &&\
     ls


WORKDIR /shadowsocks

CMD sed -i "s|NODE_ID = 0|NODE_ID = ${NODE_ID}|"                               /root/shadowsocks/userapiconfig.py && \
    sed -i "s|SPEEDTEST = 6|SPEEDTEST = ${SPEEDTEST}|"                         /root/shadowsocks/userapiconfig.py && \
    sed -i "s|CLOUDSAFE = 1|CLOUDSAFE = ${CLOUDSAFE}|"                         /root/shadowsocks/userapiconfig.py && \
    sed -i "s|AUTOEXEC = 0|AUTOEXEC = ${AUTOEXEC}|"                            /root/shadowsocks/userapiconfig.py && \
    sed -i "s|ANTISSATTACK = 0|ANTISSATTACK = ${ANTISSATTACK}|"                /root/shadowsocks/userapiconfig.py && \
    sed -i "s|MU_SUFFIX = \"zhaoj.in\"|MU_SUFFIX = \"${MU_SUFFIX}\"|"              /root/shadowsocks/userapiconfig.py && \
    sed -i "s|MU_REGEX = \"%5m%id.%suffix\"|MU_REGEX = \"${MU_REGEX}\"|"           /root/shadowsocks/userapiconfig.py && \
    sed -i "s|API_INTERFACE = \"modwebapi\"|API_INTERFACE = \"${API_INTERFACE}\"|" /root/shadowsocks/userapiconfig.py && \
    sed -i "s|WEBAPI_URL = \"https://zhaoj.in\"|WEBAPI_URL = \"${WEBAPI_URL}\"|"   /root/shadowsocks/userapiconfig.py && \
    sed -i "s|WEBAPI_TOKEN = \"glzjin\"|WEBAPI_TOKEN = \"${WEBAPI_TOKEN}\"|"       /root/shadowsocks/userapiconfig.py && \
    sed -i "s|MYSQL_HOST = \"127.0.0.1\"|MYSQL_HOST = \"${MYSQL_HOST}\"|"          /root/shadowsocks/userapiconfig.py && \
    sed -i "s|MYSQL_PORT = 3306|MYSQL_PORT = ${MYSQL_PORT}|"                   /root/shadowsocks/userapiconfig.py && \
    sed -i "s|MYSQL_USER = \"ss\"|MYSQL_USER = \"${MYSQL_USER}\"|"                 /root/shadowsocks/userapiconfig.py && \
    sed -i "s|MYSQL_PASS = \"ss\"|MYSQL_PASS = \"${MYSQL_PASS}\"|"                 /root/shadowsocks/userapiconfig.py && \
    sed -i "s|MYSQL_DB = \"shadowsocks\"|MYSQL_DB = \"${MYSQL_DB}\"|"              /root/shadowsocks/userapiconfig.py && \
    sed -i "s|\"redirect\": \"\"|\"redirect\": \"${REDIRECT}\"|"               /root/shadowsocks/user-config.json && \
    sed -i "s|\"fast_open\": false|\"fast_open\": ${FAST_OPEN}|"               /root/shadowsocks/user-config.json && \
    echo -e "${DNS_1}\n${DNS_2}\n" > dns.conf && \
    python /root/shadowsocks/server.py
