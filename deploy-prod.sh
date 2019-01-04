#!/usr/bin/env bash

#drush sset system.maintennance_mode 1
#drush vset site_readonly
drush config-set readonlymode.settings enable 1 -y
echo Maintenance mode enabled.
drush cr

git pull origin master
composer install --no-dev
drush cr

drush updb
drush cr

drush csex prod -y

drush cim -y
drush cr

git add config/prod
git commit -m 'Ajout de config de prod.'
git log

#drush sset system.maintennance_mode 0
drush config-set readonlymode.settings enable 0 -y
drush cr
echo Site is online.
