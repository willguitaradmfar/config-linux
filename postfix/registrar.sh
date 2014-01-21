
sudo postmap /etc/postfix/virtual
sudo /etc/init.d/postfix restart
sudo tail -f /var/log/mail.log 
