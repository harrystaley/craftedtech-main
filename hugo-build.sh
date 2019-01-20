#! /bin/bash
sudo hugo
sudo scp -r public/* /var/www/craftedtech.net/
sudo chown -R www-data:www-data /var/www/
sudo rm -r public
sudo systemctl restart nginx
