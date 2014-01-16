#!bin/bash -ex

cd usr/share/tomcat7
sudo ln -s /var/lib/tomcat7/conf conf
sudo ln -s /var/lib/tomcat7/webapps webapps
sudo chmod 777 /usr/share/tomcat7/webapps
sudo mv ~/CS462/wars/deploy.war /usr/share/tomcat7/webapps/deploy.war

sudo service tomcat7 restart
