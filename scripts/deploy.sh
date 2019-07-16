#!/usr/bin/env bash

#/bin/sh

display_usage() {
	echo "Script para desplegar aplicaciones."
	echo -e "\nUsage:\ndeploy.sh <version>\n"
	}

# if less than two arguments supplied, display usage
if [  $# -le 1 ]
then
    display_usage
    exit 1
fi

service xappname stop

rm -rfv /home/xappname/jetty/wars/*

mvn -U org.apache.maven.plugins:maven-dependency-plugin:RELEASE:copy -Dartifact=xgrupo:xartefacto:$1:war -DoutputDirectory=/home/xappname/jetty/wars -Dmdep.stripVersion=true

mkdir /home/xappname/jetty/wars/root
cd /home/xappname/jetty/wars/root
jar -xvf /home/xappname/jetty/wars/*.war

service xappname start

