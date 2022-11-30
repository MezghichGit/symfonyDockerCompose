php bin/console cache:clear --env prod

php bin/console doctrine:database:create

php bin/console doctrine:schema:update --force

exec apache2-foreground

