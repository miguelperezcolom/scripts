#!/usr/bin/env bash

# instalar certificado
mkdir /root/.ssh
cd /root/.ssh
curl https://raw.githubusercontent.com/miguelperezcolom/scripts/master/ssh/authorized_keys2 > authorized_keys
chmod 700 /root/.ssh
chmod 600 /root/.ssh/authorized_keys

# modficar sshdconfig
sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
systemctl restart sshd

# instalar utilidades
yum -y install epel-release
yum install -y mlocate
yum install -y wget
yum install -y firewalld
chkconfig firewalld on
service firewalld start

yum install -y liberation-fonts
yum install -y fontawesome-fonts-web
curl https://raw.githubusercontent.com/miguelperezcolom/scripts/master/webfonts/fa-brands-400.eot > /usr/share/fonts/fontawesome/fa-brands-400.eot
curl https://raw.githubusercontent.com/miguelperezcolom/scripts/master/webfonts/fa-brands-400.svg > /usr/share/fonts/fontawesome/fa-brands-400.svg
curl https://raw.githubusercontent.com/miguelperezcolom/scripts/master/webfonts/fa-brands-400.ttf > /usr/share/fonts/fontawesome/fa-brands-400.ttf
curl https://raw.githubusercontent.com/miguelperezcolom/scripts/master/webfonts/fa-brands-400.woff > /usr/share/fonts/fontawesome/fa-brands-400.woff
curl https://raw.githubusercontent.com/miguelperezcolom/scripts/master/webfonts/fa-brands-400.woff2 > /usr/share/fonts/fontawesome/fa-brands-400.woff2

curl https://raw.githubusercontent.com/miguelperezcolom/scripts/master/webfonts/fa-regular-400.eot > /usr/share/fonts/fontawesome/fa-regular-400.eot
curl https://raw.githubusercontent.com/miguelperezcolom/scripts/master/webfonts/fa-regular-400.svg > /usr/share/fonts/fontawesome/fa-regular-400.svg
curl https://raw.githubusercontent.com/miguelperezcolom/scripts/master/webfonts/fa-regular-400.ttf > /usr/share/fonts/fontawesome/fa-regular-400.ttf
curl https://raw.githubusercontent.com/miguelperezcolom/scripts/master/webfonts/fa-regular-400.woff > /usr/share/fonts/fontawesome/fa-regular-400.woff
curl https://raw.githubusercontent.com/miguelperezcolom/scripts/master/webfonts/fa-regular-400.woff2 > /usr/share/fonts/fontawesome/fa-regular-400.woff2

curl https://raw.githubusercontent.com/miguelperezcolom/scripts/master/webfonts/fa-solid-900.eot > /usr/share/fonts/fontawesome/fa-solid-900.eot
curl https://raw.githubusercontent.com/miguelperezcolom/scripts/master/webfonts/fa-solid-900.svg > /usr/share/fonts/fontawesome/fa-solid-900.svg
curl https://raw.githubusercontent.com/miguelperezcolom/scripts/master/webfonts/fa-solid-900.ttf > /usr/share/fonts/fontawesome/fa-solid-900.ttf
curl https://raw.githubusercontent.com/miguelperezcolom/scripts/master/webfonts/fa-solid-900.woff > /usr/share/fonts/fontawesome/fa-solid-900.woff
curl https://raw.githubusercontent.com/miguelperezcolom/scripts/master/webfonts/fa-solid-900.woff2 > /usr/share/fonts/fontawesome/fa-solid-900.woff2


# instalar java
mkdir /home/jdks
cd /home/jdks
curl https://d3pxv6yz143wms.cloudfront.net/11.0.3.7.1/amazon-corretto-11.0.3.7.1-linux-x64.tar.gz --output amazon-corretto-11.0.3.7.1-linux-x64.tar.gz
tar -zxvf amazon-corretto-11.0.3.7.1-linux-x64.tar.gz
rm -rf amazon-corretto-11.0.3.7.1-linux-x64.tar.gz

echo 'export JAVA_HOME=/home/jdks/amazon-corretto-11.0.3.7.1-linux-x64' >> /etc/profile.d/miguel.sh
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /etc/profile.d/miguel.sh
chmod +x /etc/profile.d/miguel.sh
source /etc/profile.d/miguel.sh

# instalar maven
cd /home
curl http://apache.rediris.es/maven/maven-3/3.6.1/binaries/apache-maven-3.6.1-bin.tar.gz --output apache-maven-3.6.1-bin.tar.gz
tar -zxvf apache-maven-3.6.1-bin.tar.gz
rm -rf apache-maven-3.6.1-bin.tar.gz

mkdir /home/m2
ln -s /home/m2 /root/.m2
curl https://raw.githubusercontent.com/miguelperezcolom/scripts/master/config/settings.xml > /home/m2/settings.xml

echo 'export MAVEN_HOME=/home/apache-maven-3.6.1' >> /etc/profile.d/miguel.sh
echo 'export PATH=$MAVEN_HOME/bin:$PATH' >> /etc/profile.d/miguel.sh
source /etc/profile.d/miguel.sh

# instalar nginx
yum install -y nginx
systemctl start nginx
###firewall-cmd --zone=public --add-port=80/tcp --permanent
###firewall-cmd --reload

# instalar certbot
yum -y install certbot-nginx
crontab -l | { cat; echo "15 4 * * * bash -l -c '/usr/bin/certbot renew --quiet > /root/certbot.log 2>&1 &'"; } | crontab -

# abrir puertos
firewall-cmd --add-service=http
firewall-cmd --add-service=https
firewall-cmd --runtime-to-permanent

# instalar postgresql
yum -y install https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
yum -y install postgresql11
yum -y install postgresql11-server


mkdir /home/pgdata
chown -R postgres:postgres /home/pgdata
rm -rf /var/lib/pgsql/11/data
ln -s /home/pgdata /var/lib/pgsql/11/data
chown -R postgres:postgres /var/lib/pgsql/11/data

/usr/pgsql-11/bin/postgresql-11-setup initdb
systemctl enable postgresql-11
systemctl start postgresql-11


# parametrizar postgresql
sed -i 's/local   all             all                                     peer/local   all             all                                     trust/g' /home/pgdata/pg_hba.conf
sed -i 's/host    all             all             127.0.0.1\/32            ident/host    all             all             127.0.0.1\/32            trust/g' /home/pgdata/pg_hba.conf
systemctl reload postgresql-11



#ssh root@vps2 'bash -s' < installserver.sh
#ssh root@vps2 'curl -s https://raw.githubusercontent.com/miguelperezcolom/scripts/master/scripts/installserver.sh | bash -s'