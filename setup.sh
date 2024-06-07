#!/bin/bash

  # Mettre à jour le système
sudo apt update && sudo apt upgrade -y

  # Installer des outils de base
sudo apt install -y vim git curl wget ufw

  # Configurer le pare-feu
sudo ufw allow OpenSSH
sudo ufw enable

  # Créer un utilisateur sudo
read -p "Entrer le nom d'utilisateur : " username
sudo adduser $username
sudo usermod -aG sudo $username

  # Désactiver l'accès SSH pour root
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sudo systemctl reload sshd

  # Ajouter les clés SSH pour le nouvel utilisateur
sudo -u $username mkdir -p /home/$username/.ssh
read -p "Entrer la clé SSH publique : " ssh_key
echo $ssh_key | sudo -u $username tee -a /home/$username/.ssh/authorized_keys

  # Fin du script
echo "Configuration de base terminée."
