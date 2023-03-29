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

# Toutes les varaibles d'environement sont a éditer dans le Dockerfile

# TODO : Créer les variables globals 

echo "Setup permissions"

docker exec $MONGO_DOCKER mongo admin --eval "
use $DATABASE
db.createUser([{
  user: \"$DB_ADMIN\",
  pwd: \"$DB_ADMIN_PASS\",
  roles: [
    { role: \"dbAdmin\", db: $DATABASE }
  ]
},
{
  user: \"$RW_USER\",
  pwd: \"$RW_USER_PASS\",
  roles: [
    { role: \"readWrite\", db: $DATABASE }
  ]
},
{
  user: \"$RO_USER\",
  pwd: \"$RO_USER_PASS\",
  roles: [
    { role: \"read\", db: $DATABASE }
  ]
}])
"

echo "Done !"