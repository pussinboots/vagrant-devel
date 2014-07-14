#!/bin/bash
PROJECT_DEPENDENCIES=$1
echo "project is $project"
PROVISION_DEPS=$PROJECT_DEPENDENCIES

DEPS=(`echo $PROVISION_DEPS | tr ";" "\n"`)

echo "project dependencies $PROVISION_DEPS"

for package in "${DEPS[@]}"
do
sh /vagrant/provision/packages/$package.sh
done
