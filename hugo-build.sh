#! /bin/bash
sudo git pull
sudo hugo
sudo scp -r static/* /var/www/craftedtech.net/
sudo chown -R www-data:www-data /var/www/
sudo rm -r static
sudo systemctl restart nginx
