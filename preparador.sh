#!/bin/bash
mysqlRootPassword="senhadbroot" ##a senha de root do mysql para sua senha definitiva de root do mysql
adduser deploy
usermod -aG sudo deploy
sudo -H -u deploy bash -c "mkdir /home/deploy/setup/"
sudo cp adicionarInstancia_peloNome-v3.sh /home/deploy/setup/adicionarInstancia.sh
sudo apt-get update
sudo apt-get upgrade
sudo -H -u deploy bash -c "sudo apt update && sudo apt -y upgrade"
sudo -H -u deploy bash -c "curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -"
sudo -H -u deploy bash -c "sudo apt-get install -y nodejs"
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
sudo apt-get install -y libxshmfence-dev libgbm-dev wget unzip fontconfig locales gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils
sudo apt install -y mysql-server nginx
sudo npm install -g pm2
mysql -u root -B -N -e "
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${mysqlRootPassword}';
    FLUSH PRIVILEGES;
"
cd /home/deploy/setup
sudo -H -u deploy bash -c "git clone https://github.com/canove/whaticket whaticket"
sudo env PATH=\$PATH:/usr/bin pm2 startup ubuntu -u deploy --hp /home/deploy
sudo -H -u deploy bash -c "pm2 save"
sudo rm /etc/nginx/sites-enabled/default


echo " 888b     d888 8888888888 888     888 888    888 888     888 888888b. ";
echo " 8888b   d8888 888        888     888 888    888 888     888 888  "88b ";
echo " 88888b.d88888 888        888     888 888    888 888     888 888  .88P ";
echo " 888Y88888P888 8888888    888     888 8888888888 888     888 8888888K. ";
echo " 888 Y888P 888 888        888     888 888    888 888     888 888  "Y88b ";
echo " 888  Y8P  888 888        888     888 888    888 888     888 888    888 ";
echo " 888   "   888 888        Y88b. .d88P 888    888 Y88b. .d88P 888   d88P ";
echo " 888       888 8888888888  "Y88888P"  888    888  "Y88888P"  8888888P" ";

echo "Tarefa Concluída!"

echo "A maquina está pronta para primeira instalação :)"


