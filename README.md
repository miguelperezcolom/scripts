# scripts

Varios scripts para la instalación de servidores y aplicaciones


## Instalación de un nuevo servidor

ssh root@vps2 'curl -s https://raw.githubusercontent.com/miguelperezcolom/scripts/master/scripts/installserver.sh | bash -s'


## Instalar aplicación

ssh root@vps1 'curl -s https://raw.githubusercontent.com/miguelperezcolom/scripts/master/scripts/installapp.sh | bash -s appname groupId artifactId port puname'



## Publicar en nginx

ssh root@vps1 'curl -s https://raw.githubusercontent.com/miguelperezcolom/scripts/master/scripts/installapp-nginx.sh | bash -s appname host domain backend_server backend_port'



## Deploy

cd /home/app
./deploy.sh versión 