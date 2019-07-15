#/bin/sh


#1 appname
#2 com.quonext.quotravel
#3 quotravel-core
#4 puerto
#5 puname

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

wget https://raw.githubusercontent.com/miguelperezcolom/scripts/master/config/app.properties
sed -i "s/xappname/$1/g" /home/$1/app.properties
sed -i "s/xdatabase/$1/g" /home/$1/app.properties
sed -i "s/xpuname/$5/g" /home/$1/app.properties


wget https://raw.githubusercontent.com/miguelperezcolom/scripts/master/scripts/deploy.sh
sed -i "s/xappname/$1/g" /home/$1/deploy.sh
sed -i "s/xgrupo/$2/g" /home/$1/deploy.sh
sed -i "s/xartefacto/$3/g" /home/$1/deploy.sh


cd /etc/init.d
curl https://raw.githubusercontent.com/miguelperezcolom/scripts/master/config/service.txt --output $1
sed -i "s/xappname/$1/g" $1
sed -i "s/xport/$4/g" $1
chkconfig $1 on


#ssh root@vps1 'bash -s' < installapp.sh appname
#ssh root@vps1 'curl -s https://raw.githubusercontent.com/miguelperezcolom/scripts/master/scripts/installapp.sh | bash -s appname'
#ssh root@vps1 'curl -s https://raw.githubusercontent.com/miguelperezcolom/scripts/master/scripts/installapp.sh | bash -s demo com.quonext.quotravel quotravel-core 8301 quotravel'

