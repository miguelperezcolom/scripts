#/bin/sh


# appname
# com.quonext.quotravel
# quotravel-core
# 0.0.1-SNAPSHOT
# dominio
# puerto

createdb -U postgres $1
mkdir /home/$1
cd /home/$1
wget https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/9.4.19.v20190610/jetty-distribution-9.4.19.v20190610.tar.gz
tar -zxvf jetty-distribution-9.4.19.v20190610.tar.gz
mv jetty-distribution-9.4.19.v20190610 jetty
rm -rf jetty-distribution-9.4.19.v20190610.tar.gz
cd jetty
java -jar start.jar --add-to-start=console-capture
cd webapps
wget https://raw.githubusercontent.com/miguelperezcolom/scripts/master/jetty/root.xml
cd ..
mkdir wars
cd ..
mkdir tmp

wget https://raw.githubusercontent.com/miguelperezcolom/scripts/master/scripts/deploy.sh
sed -i "s/xappname/$1/g" /home/$1/deploy.sh
sed -i "s/xappname/$1/g" /home/$1/deploy.sh
sed -i "s/xappname/$1/g" /home/$1/deploy.sh
sed -i "s/xappname/$1/g" /home/$1/deploy.sh





#ssh root@vps1 'bash -s' < installapp.sh appname
#ssh root@vps1 'curl -s https://raw.githubusercontent.com/miguelperezcolom/scripts/master/scripts/installapp.sh | bash -s appname'

