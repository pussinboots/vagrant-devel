#!/bin/bash
project=$1
PROJECT_DEPENDENCIES=$2
echo "project is $project"
PROVISION_DEPS=$PROJECT_DEPENDENCIES

DEPS=(`echo $PROVISION_DEPS | tr ";" "\n"`)

echo "project dependencies $PROVISION_DEPS"

for package in "${DEPS[@]}"
do
sh /vagrant/provision/packages/$package.sh
done
