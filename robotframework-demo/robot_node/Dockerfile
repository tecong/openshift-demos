FROM ubuntu:xenial-20160525

LABEL name="Docker image for the Robot Framework Selenium environment with Chrome and Xvfb"


ARG user=jenkins
ARG uid=995

ENV UBUNTU_FLAVOR="xenial" \
    UBUNTU_DATE="20160525"

ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true

RUN  echo "deb http://archive.ubuntu.com/ubuntu ${UBUNTU_FLAVOR} main universe\n" > /etc/apt/sources.list \
  && echo "deb http://archive.ubuntu.com/ubuntu ${UBUNTU_FLAVOR}-updates main universe\n" >> /etc/apt/sources.list \
  && echo "deb http://security.ubuntu.com/ubuntu ${UBUNTU_FLAVOR}-security main universe\n" >> /etc/apt/sources.list

#========================
# Miscellaneous packages
# Includes minimal runtime used for executing non GUI Java programs
#========================
RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
    bzip2 \
    ca-certificates \
    openjdk-8-jre-headless \
    sudo \
    unzip \
    wget \
  && rm -rf /var/lib/apt/lists/* \
  && sed -i 's/securerandom\.source=file:\/dev\/random/securerandom\.source=file:\/dev\/urandom/' ./usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/java.security

  
RUN  useradd -u ${uid} -g sudo -m -s /bin/bash ${user}  
  
  
#===================
# Timezone settings
#===================
ENV TZ "Europe/Helsinki"
RUN echo "Setting time zone to '${TZ}'" \
  && echo ${TZ} > /etc/timezone \
  && dpkg-reconfigure --frontend noninteractive tzdata

#==========
# Selenium
#==========
ENV SELENIUM_SERVER_VERSION 2.53
RUN mkdir -p /opt/selenium \
  && wget --no-verbose \
    https://selenium-release.storage.googleapis.com/${SELENIUM_SERVER_VERSION}/selenium-server-standalone-${SELENIUM_SERVER_VERSION}.0.jar \
    -O /opt/selenium/selenium-server-standalone.jar

#==============
# VNC and Xvfb
#==============
RUN apt-get update -qqy \
  && apt-get -qqy install \
    xvfb x11vnc \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir ~/.vnc/ && x11vnc -storepasswd 123456 ~/.vnc/passwd
  
#===============
# Google Chrome
#===============
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update -qqy \
  && apt-get -qqy install \
    google-chrome-stable \
  && rm /etc/apt/sources.list.d/google-chrome.list \
  && rm -rf /var/lib/apt/lists/*

#==================
# Chrome webdriver
#==================
ENV CHROME_DRIVER_VERSION 2.25
RUN wget --no-verbose -O /tmp/chromedriver_linux64.zip https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip \
  && rm -rf /opt/selenium/chromedriver \
  && unzip /tmp/chromedriver_linux64.zip -d /opt/selenium \
  && rm /tmp/chromedriver_linux64.zip \
  && mv /opt/selenium/chromedriver /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION \
  && chmod 755 /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION \
  && ln -fs /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION /usr/bin/chromedriver

#========================
# python dependencies
#========================
RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
    python \
    python-setuptools \
    python-wheel \
    python-pip \
  && rm -rf /var/lib/apt/lists/*

#==============================
# robotframework and libraries
#==============================
RUN pip install --upgrade pip
RUN pip install requests==2.9.1
RUN pip install robotframework==3.0
RUN pip install robotframework-selenium2library==1.7.4
RUN pip install robotframework-httplibrary==0.4.2
RUN pip install robotframework-requests==0.4.5
RUN pip install robotframework-pabot==0.23

ADD run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

VOLUME /robot

USER ${user}

CMD ["run.sh"]
