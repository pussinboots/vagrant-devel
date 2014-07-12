#!/bin/sh

if which createrepo >/dev/null; then
	echo "skip createrepo installation"
else
	echo "createrepo installation"
	yes "" | apt-get install createrepo
fi