curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

#Validate download
php wp-cli.phar --info

chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

#Check Info
wp --info
