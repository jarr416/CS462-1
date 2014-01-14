#!/bin/bash -ex
	sudo apt-get update -y
	sudo apt-get upgrade -y
	sudo apt-get install git -y
	git clone https://github.com/pdcopeland727/CS462.git
	chmod a+x CS462/script.sh
	./script.sh
