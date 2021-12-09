#!/bin/bash

#This script gets the necessary files and makes the project work for a blank installation of a raspberry.
#FOR USE IN /var/www/html , elsewhere will not work.

git clone git@github.com:gge3/idg1100-project.git /home/pi/Downloads/tempdir

cp -f /home/pi/Downloads/tempdir/default /etc/nginx/sites-available
sudo ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

cp -f /home/pi/Downloads/tempdir/scraping.sh /var/www/html
cp -f /home/pi/Downloads/tempdir/pages.sh /var/www/html
cp -f /home/pi/Downloads/tempdir/ovw.sh /var/www/html
cp -f /home/pi/Downloads/tempdir/repoupdate.sh /var/www/html

chmod +x /var/www/html/scraping.sh
chmod +x /var/www/html/pages.sh
chmod +x /var/www/html/ovw.sh
chmod +x /var/www/html/repoupdate.sh

bash +x /var/www/html/scraping.sh
bash +x /var/www/html/pages.sh
bash +x /var/www/html/ovw.sh

line1="0 */6 * * * bash +x /var/www/html/scraping.sh"
line2="0 */6 * * * bash +x /var/www/html/pages.sh"
line3="0 */6 * * * bash +x /var/www/html/ovw.sh"
line4="0 */6 * * * bash +x /var/www/html/repoupdate.sh"

(crontab -u $(whoami) -l; echo "$line1" ) | crontab -u $(whoami) -
(crontab -u $(whoami) -l; echo "$line2" ) | crontab -u $(whoami) -
(crontab -u $(whoami) -l; echo "$line3" ) | crontab -u $(whoami) -
(crontab -u $(whoami) -l; echo "$line4" ) | crontab -u $(whoami) -

rm -r /home/pi/Downloads/tempdir



