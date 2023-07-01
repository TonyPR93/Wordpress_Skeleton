#!/bin/bash

# Spécifiez le nom de la base de données WordPress
DB_NAME="my-wpdb"

# Spécifiez les informations de connexion à la base de données
DB_USER="root"
DB_PASSWORD="password"
DB_HOST="mysql"

# Spécifiez le chemin où vous souhaitez sauvegarder le fichier SQL
BACKUP_DIR="$HOME/OneDrive/Bureau/wordpress-local/backup"
CURRENT_DATE="$(date +"%Y-%m-%d-%H-%M-%S")"
BACKUP_FILE="$DB_NAME-db-$CURRENT_DATE.sql"

# Créez le dossier de sauvegarde s'il n'existe pas
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir "$BACKUP_DIR"
fi

# Utilisez la commande mysqldump pour sauvegarder la base de données dans un fichier SQL
docker-compose exec mysql mysqldump -u$DB_USER -p$DB_PASSWORD --add-drop-table \
--ignore-table=$DB_NAME.wp_options \
--ignore-table=$DB_NAME.wp_comments \
--ignore-table=$DB_NAME.wp_commentmeta \
--ignore-table=$DB_NAME.wp_postmeta \
--ignore-table=$DB_NAME.wp_usermeta \
--ignore-table=$DB_NAME.wp_users \
$DB_NAME > $BACKUP_DIR/$BACKUP_FILE

# Vérifiez si la sauvegarde a réussi
if [ $? -eq 0 ]; then
    echo "La sauvegarde de la base de données a réussi : $BACKUP_FILE"
else
    echo "La sauvegarde de la base de données a échoué"
fi