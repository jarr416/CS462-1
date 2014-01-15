#!/bin/bash -ex

mkdir usr/local/glassfish4
wget http://download.java.net/glassfish/4.0/release/glassfish-4.0-web.zip
unzip glassfish-4.0-web.zip
rm glassfish-4.0-web.zip

glassfish4/bin/asadmin start-domain