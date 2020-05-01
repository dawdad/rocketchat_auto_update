#!/bin/bash


function checkVersion () {
# Variables
URL_INSTALLED_VERSION="https://<ROCKETCHAT>/api/info"
URL_GIT_VERSION="https://api.github.com/repos/RocketChat/Rocket.Chat/releases/latest"

# check url version from rocketchat api
echo -e " -- get version of local rocketchat"
INST_VERSION=`curl -s "$URL_INSTALLED_VERSION" | egrep -m 1 '"version"' | awk -F '"' '{ print $4 }'`

# check new versions from git repo
echo -e " -- get newest version of git repo"
GIT_VERSION=`curl -s "$URL_GIT_VERSION" | egrep -m 1 '"tag_name"' | awk -F '"' '{ print $4 }'`

if [[ $GIT_VERSION == $INST_VERSION ]];then
        echo -e "Newest installed !!"
        exit 1
else
        echo -e "New Version avaible !!"
        echo -e "Installed:" $INST_VERSION
        echo -e "Git-Version:" $GIT_VERSION
fi
}

function updateRocketChat () {
## Upgrade

echo -e " -- Stopping Rocketchat"
#sudo systemctl stop rocketchat

echo -e " -- create backup from rocktchat folder"
#sudo mv /opt/Rocket.Chat /opt/Rocket.Chat_autoupgrade

echo -e " -- download new release of rocketchat"
#curl -L https://releases.rocket.chat/latest/download -o /tmp/rocket.chat.tgz

echo -e " -- unpack new rocketchat to tmp"
#tar -xzf /tmp/rocket.chat.tgz -C /tmp

echo -e " -- install new npm release"
#cd /tmp/bundle/programs/server && npm install

echo -e " -- move to opt folder"
#sudo mv /tmp/bundle /opt/Rocket.Chat

echo -e " -- change user right of /opt/rocket.chat"
#sudo chown -R rocketchat:rocketchat /opt/Rocket.Chat

echo -e " -- delete rocketchat download /tmp/rocket.chat.tgz"
#sudo rm -rf /tmp/rocket.chat.tgz

echo -e " -- start rocketchat"
#sudo systemctl start rocketchat

echo -e " -- status rocketchat"
#sudo systemctl status rocketchat
}


# check user is root
if [ "$EUID" -ne 0 ]; then
    echo "You need to run this script as root"
    exit 1
fi

# get function 
if [[ $1 == "check" ]];then
        checkVersion
        exit 0
elif [[ $1 == "update" ]]; then
	if [[ -e /opt/Rocket.Chat ]]; then
		updateRocketChat
	else
	    echo "Please install Rocketchat first."
        exit 1
    fi
else
    echo -e "Please select one option 'check' or 'update' "
fi
