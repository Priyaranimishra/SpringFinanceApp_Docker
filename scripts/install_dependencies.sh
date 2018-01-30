#!/bin/bash
set -e
CATALINA_HOME=/usr/share/tomcat8-codedeploy
TOMCAT_VERSION=8.0.47
# Tar File Name
TOMCAT8_CORE_TAR_FILENAME="apache-tomcat-$TOMCAT_VERSION.tar.gz"
# Download Tomcat URL
TOMCAT8_CORE_DOWNLOAD_URL="http://www-us.apache.org/dist/tomcat/tomcat-8/v$TOMCAT_VERSION/bin/$TOMCAT8_CORE_TAR_FILENAME"
# The top level directory after unpacking the tar file
TOMCAT8_CORE_UNPACKED_DIRNAME="apache-tomcat-$TOMCAT_VERSION"
# Clear install directory
if [ -d $CATALINA_HOME ]; then
    rm -rf $CATALINA_HOME
fi
mkdir -p $CATALINA_HOME
apt-get update
sudo apt-get install -y openjdk-8-jdk
export JAVA_HOME=/usr/lib/jvm/java-8-oracle
export PATH=${PATH}:${JAVA_HOME}/bin
# Download the latest Tomcat8 version
cd /home/ubuntu
sudo apt-get install -y wget
wget $TOMCAT8_CORE_DOWNLOAD_URL
if [[ -d /home/ubuntu/$TOMCAT8_CORE_UNPACKED_DIRNAME ]]; then
    rm -rf /home/ubuntu/$TOMCAT8_CORE_UNPACKED_DIRNAME
fi
tar xzf $TOMCAT8_CORE_TAR_FILENAME
if [ -d /opt/tomcat ]; then
	rm -rf /opt/tomcat
fi
mkdir /opt/tomcat
mv $TOMCAT8_CORE_UNPACKED_DIRNAME /opt/tomcat
cd /
cd /opt/tomcat/$TOMCAT8_CORE_UNPACKED_DIRNAME
export CATALINA_HOME=/opt/tomcat/$TOMCAT8_CORE_UNPACKED_DIRNAME
export PATH=${PATH}:${CATALINA_HOME}/bin
source /etc/profile
cd bin/
chmod +x *
./startup.sh