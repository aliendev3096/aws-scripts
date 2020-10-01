#!/bin/bash

ARG=$1
VERSION="1.0.0"

function start() {
 HOST=$(host myip.opendns.com resolver1.opendns.com | grep "myip.opendns.com has" | awk '{print $4}')
 echo "Updating System Packages\n"
 sudo yum update -y
 echo "Installing NGINX\n"
 sudo yum install nginx -y
 echo "Configuring NGINX\n"
 sudo chkconfig nginx on
 echo "Retrieving Web Server Content\n"
 sudo aws s3 cp s3://vang7572-webserver-storage/index.html /usr/share/nginx/html/index.html
 echo "Starting Webserver on ${HOST}\n"
 sudo service nginx start
}

function stop_nginx_service {
 echo "Stopping Nginx Service\n"
 sudo service nginx stop
 echo "Unstaging Nginx Files\n"
 sudo rm /usr/share/nginx/html/index.html
 echo "Removing Nginx from server\n"
 sudo yum remove nginx -y
}

function display_version() {
 echo $VERSION
}

function display_help() {
 echo "USAGE: ./provision.sh (argument)\n"
 echo "ARGUMENTS: \n"
 echo "-r | --remove : Stops Nginx Server and Removes Nginx\n"
 echo "-v | --version : Displays Script Version\n"
 echo "h | --help : Displays Usage\n"
 echo "Specifying no arguments will start the nginx server with a default screen"
 echo "\n"
}

case $ARG in
-v|--version)
 display_version
 ;;
-h|--help)
 display_help
 ;;
-r|--remove) 
 stop_nginx_service
 ;;
*)
 start
 ;;
esac
echo "Script 'Provisions' Completed!"



