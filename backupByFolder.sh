#!/bin/bash

# Spécifiez le nom de la base de données WordPress
DB_NAME="my-wpdb"

# Spécifiez les informations de connexion à la base de données
DB_USER="root"
DB_PASSWORD="password"
DB_HOST="mysql"

# Spécifiez le chemin où vous souhaitez sauvegarder les fichiers SQL
BACKUP_DIR="$HOME/OneDrive/Bureau/wordpress-local/backupByF"
CURRENT_DATE="$(date +"%Y-%m-%d-%H-%M-%S")"
BACKUP_FOLDER="$BACKUP_DIR/$CURRENT_DATE"

if [ ! -d "$BACKUP_DIR" ]; then
    mkdir "$BACKUP_DIR"
fi

# Créez le dossier de sauvegarde s'il n'existe pas
if [ ! -d "$BACKUP_FOLDER" ]; then
    mkdir "$BACKUP_FOLDER"
fi

# Récupérez la liste des tables de la base de données
TABLES=$(docker-compose exec mysql mysql -N -B -u$DB_USER -p$DB_PASSWORD -h $DB_HOST -e "use $DB_NAME;show tables;")

# Bouclez sur chaque table et exécutez la commande mysqldump pour la sauvegarder dans un fichier SQL distinct
for TABLE in $TABLES; do
    docker-compose exec mysql mysqldump -u$DB_USER -p$DB_PASSWORD --add-drop-table \
        $DB_NAME $TABLE > $BACKUP_FOLDER/$TABLE.sql
done

# Vérifiez si la sauvegarde a réussi
if [ $? -eq 0 ]; then
    echo "La sauvegarde de la base de données a réussi dans le dossier $BACKUP_DIR"
else
    echo "La sauvegarde de la base de données a échoué"
fi