#!/bin/bash

# Vérifiez si le nom de la base de données est spécifié en argument
if [ -z "$1" ]; then
    echo "Veuillez spécifier le nom de la base de données en argument."
    echo "Utilisation : ./applyBackupDB.sh <nom_de_la_base_de_donnees> <fichier_sauvegarde.sql>"
    exit 1
fi

# Nom de la base de données WordPress
DB_NAME="my-wpdb"

# Spécifiez les informations de connexion à la base de données
DB_USER="root"
DB_PASSWORD="password"

# Chemin vers le dossier de sauvegarde
BACKUP_DIR="$HOME/OneDrive/Bureau/wordpress-local/backupAll"

# Vérifiez si le dossier de sauvegarde existe
if [ ! -d "$BACKUP_DIR" ]; then
    echo "Le dossier de sauvegarde $BACKUP_DIR n'existe pas."
    exit 1
fi

# Chemin vers le fichier de sauvegarde SQL
BACKUP_FILE="$BACKUP_DIR/$1.sql"

# Vérifiez si le fichier de sauvegarde existe
if [ ! -f "$BACKUP_FILE" ]; then
    echo "Le fichier de sauvegarde $BACKUP_FILE n'existe pas."
    exit 1
fi



# Accédez au conteneur MySQL et restaurez la sauvegarde
docker-compose exec -T mysql mysql -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" < "$BACKUP_FILE"


# Vérifiez si la restauration a réussi
if [ $? -eq 0 ]; then
    echo "La sauvegarde de la base de données a été restaurée avec succès."
else
    echo "La restauration de la base de données a échoué."
fi
