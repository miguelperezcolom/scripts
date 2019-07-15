#/bin/sh


display_usage() {
	echo "Script para instalar fichero configuración nginx."
	echo -e "\nUsage:\ninstallapp-nginx.sh <appname> <host> <domain> <backend_server> <backend_port>\n"
	}

# if less than two arguments supplied, display usage
if [  $# -le 5 ]
then
    display_usage
    exit 1
fi

cd /etc/nginx/conf.d
curl https://raw.githubusercontent.com/miguelperezcolom/scripts/master/config/nginxd.conf --output $1.conf
sed -i "s/xhost/$2/g" $1.conf
sed -i "s/xdomain/$3/g" $1.conf
sed -i "s/xserver/$4/g" $1.conf
sed -i "s/xport/$5/g" $1.conf
service nginx reload

certbot --nginx -d $2.$3

#ssh root@vps1 'bash -s' < installapp.sh appname
#ssh root@vps1 'curl -s https://raw.githubusercontent.com/miguelperezcolom/scripts/master/scripts/installapp.sh | bash -s appname'

