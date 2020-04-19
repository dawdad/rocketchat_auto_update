#!/bin/bash

#

echo -e "Stopping Rocketchat"
sudo systemctl stop rocketchat

echo -e "create backup from rocktchat folder"
sudo mv /opt/Rocket.Chat /opt/Rocket.Chat_autoupgrade

echo -e "download new release of rocketchat"
curl -L https://releases.rocket.chat/latest/download -o /tmp/rocket.chat.tgz

echo -e "unpack new rocketchat to tmp"
tar -xzf /tmp/rocket.chat.tgz -C /tmp

echo -e "install new npm release"
cd /tmp/bundle/programs/server && npm install

echo -e "move to opt folder"
sudo mv /tmp/bundle /opt/Rocket.Chat

echo -e "change user right of /opt/rocket.chat"
sudo chown -R rocketchat:rocketchat /opt/Rocket.Chat

echo -e "start rocketchat"
sudo systemctl start rocketchat

echo -e "status rocketchat"
sudo systemctl status rocketchat
