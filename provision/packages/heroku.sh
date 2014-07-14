#!/bin/sh

# install heroku
if which heroku >/dev/null; then
    echo "skip heroku installation"
else
	echo "heroku installation"
	wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh
fi