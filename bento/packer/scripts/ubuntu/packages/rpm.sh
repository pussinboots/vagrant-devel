#!/bin/sh

if which rpm >/dev/null; then
	echo "skip rpm built tool installation"
else
	echo "rpm built tool installation"
	apt-get -y install rpm
fi