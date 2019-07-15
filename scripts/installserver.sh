# instalar certificado
mkdir /root/.ssh
cd /root/.ssh
curl https://raw.githubusercontent.com/miguelperezcolom/scripts/master/ssh/authorized_keys2 > authorized_keys
##chmod 700 /root/.ssh
##chmod 600 /root/.ssh/authorized_keys

# modficar sshdconfig
sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
systemctl restart sshd

yum install -y mlocate


# instalar wget
yum install -y wget


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

echo 'export MAVEN_HOME=/home/apache-maven-3.6.1' >> /etc/profile.d/miguel.sh
echo 'export PATH=$MAVEN_HOME/bin:$PATH' >> /etc/profile.d/miguel.sh
source /etc/profile.d/miguel.sh

# instalar nginx
yum install -y nginx
systemctl start nginx
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --reload

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
sed -i 's/host    all             all             127.0.0.1\/32            peer/host    all             all             127.0.0.1\/32            trust/g' /home/pgdata/pg_hba.conf
systemctl reload postgresql-11



#ssh root@vps2 'bash -s' < installserver.sh
#ssh root@vps2 'curl -s https://raw.githubusercontent.com/miguelperezcolom/scripts/master/scripts/installserver.sh | bash -s'