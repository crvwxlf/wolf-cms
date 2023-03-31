#!/bin/bash

# Description: Script d'initialisation des utilisateurs et des permissions de la base MongoDB
# Auteur: Okhamhi
# Date: 28/03/2023
# Version: 1.0.0

# Instructions d'utilisation :
#   - <Instructions pour utiliser le script>

# Variables :
#   - <Description des variables utilisées dans le script>

# Fonctions :
#   - <Description des fonctions utilisées dans le script>

# Script :

readonly DB_ADMIN="admin"
readonly DB_ADMIN_PASS='Pa$$w0rd'
readonly RW_USER="rwuser"
readonly RW_USER_PASS='password1234'
readonly RO_USER="rouser"
readonly RO_USER_PASS="password123"

readonly DATABASE="datas"
readonly  DOCKER_NAME="mongo-server"

readonly MONGO_EXPOSE_PORT=27017

echo "Création du conteneur"
docker run -it --name "$DOCKER_NAME" -p $MONGO_EXPOSE_PORT:27017 -d mongo

echo "Setup permissions"

docker exec %DOCKER_NAME% mongosh %DATABASE% --eval "db.createUser({ user: "$DB_ADMIN", pwd: "$DB_ADMIN_PASS", roles: [{ role: 'dbAdmin', db: "$DATABASE" }] }); db.createUser({ user: "$RW_USER", pwd: "$RW_USER_PASS", roles: [{ role: 'readWrite', db: "$DATABASE" }] }); db.createUser({ user: "$RO_USER", pwd: "$RO_USER_PASS", roles: [{ role: 'read', db: "$DATABASE" }] }); db.createCollection('empty');"

echo "Done !"