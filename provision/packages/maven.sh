#!/bin/sh

# install maven
if which mvn >/dev/null; then
    echo "skip maven installation"
else
	echo "maven installation"
	apt-get update
	apt-get install maven
fi