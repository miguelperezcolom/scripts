#/bin/sh

createdb -U postgres $1
mkdir /home/$1
cd /home/$1
wget https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/9.4.19.v20190610/jetty-distribution-9.4.19.v20190610.tar.gz
tar -zxvf jetty-distribution-9.4.19.v20190610.tar.gz
mv jetty-distribution-9.4.19.v20190610 jetty
rm -rf jetty-distribution-9.4.19.v20190610.tar.gz
cd jetty
java -jar start.jar --add-to-start=console-capture
mkdir wars
cp ../oldjetty/webapps/quotravel.xml .
cd ..
mkdir tmp
./deploy.sh 0.0.1-SNAPSHOT
