#/bin/sh

service xappname stop

rm -rfv /home/xappname/jetty/wars/*

mvn -U org.apache.maven.plugins:maven-dependency-plugin:RELEASE:copy -Dartifact=xgrupo:xartefacto:$1:war -DoutputDirectory=/home/xappname/jetty/wars -Dmdep.stripVersion=true

mkdir /home/xappname/jetty/wars/root
cd /home/xappname/jetty/wars/root
jar -xvf /home/xappname/jetty/wars/*.war

service xappname start


# $1 = com.quonext.quotravel
# $2 = quotravel-core
# $3 = 0.0.1-SNAPSHOT
