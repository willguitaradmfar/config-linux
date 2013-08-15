sudo apt-get install php-apc
sudo /etc/init.d/php5-fpm restart
netstat -tap

echo '****** FAVOR MATAR O PROCESSO DA PORTA 9000'

sudo mkdir -p /var/www/www.example.com/web

sudo apt-get install unzip

cd /tmp
sudo mkdir joomla
cd joomla
sudo wget http://joomlacode.org/gf/download/frsrelease/16024/69674/Joomla_1.7.3-Stable-Full_Package.zip
sudo unzip Joomla_1.7.3-Stable-Full_Package.zip
sudo rm -f Joomla_1.7.3-Stable-Full_Package.zip
sudo mv * /var/www/www.example.com/web/

sudo chown -R www-data:www-data /var/www/www.example.com/web

cd /etc/nginx/sites-enabled/
sudo ln -s /etc/nginx/sites-available/www.example.com.vhost www.example.com.vhost


sudo /etc/init.d/nginx reload


