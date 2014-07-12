#!/bin/sh

if which rpm >/dev/null; then
	echo "skip rpm built tool installation"
else
	echo "rpm built tool installation"
	yes "" | apt-get install rpm
fi