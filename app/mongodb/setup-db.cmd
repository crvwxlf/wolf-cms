@echo off

set DB_ADMIN="admin"
set DB_ADMIN_PASS="Pa$$w0rd"
set RW_USER="rwuser"
set RW_USER_PASS="password1234"
set RO_USER="rouser"
set RO_USER_PASS="password123"
set DATABASE="datas"
set MONGO_EXPOSE_PORT=27017
set DOCKER_NAME="mongo-server"

echo Setup container

echo Création du conteneur docker mongo
docker run -d --name "%DOCKER_NAME%" -p %MONGO_EXPOSE_PORT%:27017 -d mongo

timeout /T 5 /NOBREAK

echo Création des uilisateurs

docker exec %DOCKER_NAME% mongosh %DATABASE% --eval "db.createUser({ user: '%DB_ADMIN%', pwd: '%DB_ADMIN_PASS%', roles: [{ role: 'dbAdmin', db: '%DATABASE%' }] }); db.createUser({ user: '%RW_USER%', pwd: '%RW_USER_PASS%', roles: [{ role: 'readWrite', db: '%DATABASE%' }] }); db.createUser({ user: '%RO_USER%', pwd: '%RO_USER_PASS%', roles: [{ role: 'read', db: '%DATABASE%' }] }); db.createCollection('empty');"
echo Done !
