#!/bin/bash
file="/var/lib/tomcat8/webapps/finance.war"
if [ -f $file ] ; then
	sudo rm -rf $file
fi