#!/usr/bin/env bash

PROJECT_NAME="ansible_project"

echo "Création de l'arborescence du projet Ansible : $PROJECT_NAME..."


mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME" || exit 1

mkdir -p inventory/{production,staging}/{group_vars,host_vars}
mkdir -p playbooks
mkdir -p roles/exemple1/{tasks,handlers,vars,defaults,files,templates}
mkdir -p files
mkdir -p templates
mkdir -p vars

echo "Structure de dossiers créée."


cat << EOF > ansible.cfg
[defaults]
# Chemin de l'inventaire. C'est l'emplacement que nous avons défini.
inventory = ./inventory
# Chemin de recherche des rôles.
roles_path = ./roles
# Utiliser le module de callback 'default' pour une sortie standard.
stdout_callback = yaml
# Pour les versions plus récentes d'Ansible, vous pouvez aussi utiliser 'community.general.yaml'
# stdout_callback = community.general.yaml
# Activer le chiffrement Ansible Vault
vault_identity_list = @~/.ansible/vault_identities
# Ou spécifier un fichier de mot de passe directement
#
vault_password_file = ~/.ansible/vault_pass.txt
# Modifier l'utilisateur par défaut si nécessaire
# remote_user = votre_utilisateur_ssh
[ssh_connection]
# Garder les connexions ouvertes pour accélérer les playbooks
pipelining = True
# Utiliser les connexions SSH natives (plus rapide)
ssh_args = -o ControlMaster=auto -o ControlPersist=60s -o PreferredAuthentications=publickey
EOF
echo "  -> Fichier ansible.cfg créé."


echo "💨 Arborescence du projet Ansible '$PROJECT_NAME' générée avec succès !"
