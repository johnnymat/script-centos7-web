#!/bin/bash
################################################################################
#
#	Xavatar / Tatar
#
################################################################################


	# Mise à jour du system
	
	clear
    echo ""
    echo "Updating system and installing required packages."
    echo ""
	sleep 3
	
	sudo yum -y update
	sudo yum -y upgrade
	sudo yum -y groupinstall "Development Tools" 
	sudo yum -y install gmp-devel mysql-devel curl-devel libidn-devel libssh2-devel python-devel openldap-devel vim memcached wget git
	echo ""
    echo "Arret du Firewall :"
	echo ""
	sudo systemctl stop firewalld
	echo ""
	sudo systemctl status firewalld
	echo ""
	echo "Vérifixation de SeLinux :"
	echo ""
	sudo sestatus
	echo ""
	sleep 5
	clear
	
	
	# Installation NGINX
	echo ""
    echo "Installation NGINX :"
    echo ""
	sleep 3
	sudo yum -y install nginx
	echo ""
	systemctl start nginx.service
	systemctl enable nginx.service
	echo ""
    echo "Vérification de NGINX :"
	echo ""
	sudo systemctl status nginx.service
	echo ""
	sleep 5
	clear
	
		
	# Installation DB (MariaDB)
	clear
	echo ""
    echo "Installation MariaDB :"
    echo ""
	sleep 3
	sudo yum -y install mariadb-server mariadb
	sudo systemctl start mariadb 
	sudo systemctl enable mariadb
	echo ""
    echo "Vérification de DB :"
	echo ""
	sudo systemctl status mariadb.service
	echo "Mise en route DB :"
	sudo mysql_secure_installation
	echo ""
	sleep 5
	clear
	
	# Installation PHP
	clear
	echo ""
    echo "Installation PHP :"
    echo ""
	sleep 3
	sudo yum -y install php php-mysql php-common php-fpm php-gd php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-snmp php-soap php-mcrypt curl curl-devel php-memcache
	sudo systemctl start memcached
	sudo systemctl enable memcached
	echo ""
    echo "Vérification de Memcache :"
	echo ""
	sudo systemctl status memcached
	echo ""
	sleep 5
	clear
	
	
	# Installation APC
	clear
	echo ""
    echo "Installation APC :"
    echo ""
	sleep 3
	sudo yum -y install php-pear php-devel httpd-devel pcre-devel gcc make
	cd
	sudo pecl install apc
	echo "extension=apc.so" >> /etc/php.d/apc.ini
	echo ""
	sleep 5
	clear
	
	
	# Installation phpMyAdmin
	clear
	echo ""
    echo "Installation phpMyAdmin :"
    echo ""
	sleep 3
	sudo yum -y install phpMyAdmin
	echo ""
    echo "Relance Apache :"
	echo ""
	sudo systemctl restart nginx.service
	echo ""
	echo ""
	sudo systemctl status nginx.service
	echo ""
	echo ""
	echo "Installation Finish. Voir le readme pour la conf."