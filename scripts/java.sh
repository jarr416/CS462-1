#!/bin/bash -ex

sudo apt-get install openjdk-7-jdk -y
update-java-alternatives -l
sudo update-java-alternatives -s java-1.7.0-openjdk
JAVA_HOME="/usr/lib/jvm/java-1.7.0-openjdk"
JRE_HOME="/usr/lib/jvm/java-1.7.0-openjdk/jre"
