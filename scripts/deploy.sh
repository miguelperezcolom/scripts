#/bin/sh

rm -rfv /home/quotraveldemo/jetty/wars/*

service quotraveldemo stop

mvn -U org.apache.maven.plugins:maven-dependency-plugin:RELEASE:copy -DrepoUrl=http://nexus.mateu.io/repository/mateu-central/ -Dartifact=com.quonext.quotravel:quotravel-core:$1:war -DoutputDirectory=/home/quotraveldemo/jetty/wars -Dmdep.stripVersion=true

mkdir /home/quotraveldemo/jetty/wars/quotravel
cd /home/quotraveldemo/jetty/wars/quotravel
jar -xvf /home/quotraveldemo/jetty/wars/*.war


service quotraveldemo start
