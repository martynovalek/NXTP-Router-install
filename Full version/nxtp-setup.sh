#!/bin/bash

echo "=============================================================="
echo -e "\033[0;35m"
echo " ██████╗ ██████╗ ███╗   ██╗███╗   ██╗███████╗██╗  ██╗████████╗";
echo "██╔════╝██╔═══██╗████╗  ██║████╗  ██║██╔════╝╚██╗██╔╝╚══██╔══╝";
echo "██║     ██║   ██║██╔██╗ ██║██╔██╗ ██║█████╗   ╚███╔╝    ██║   ";
echo "██║     ██║   ██║██║╚██╗██║██║╚██╗██║██╔══╝   ██╔██╗    ██║   ";
echo "╚██████╗╚██████╔╝██║ ╚████║██║ ╚████║███████╗██╔╝ ██╗   ██║   ";
echo " ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝   ╚═╝   ";
echo -e "\e[0m"          
echo "=============================================================="
#Made by Haxxana
sleep 1
echo " "



function Installingrequiredtool {
echo " "
echo -e "\e[1m\e[32mInstalling required tool ... \e[0m" && sleep 1
sudo apt update && sudo apt upgrade -y
sudo apt install curl git sudo unzip wget -y < "/dev/null"
}


function Installingdocker {
echo " "
if ! command -v docker &> /dev/null
then
echo " "
echo -e "\e[1m\e[32mInstalling Docker ... \e[0m" && sleep 1
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh < "/dev/null"
fi


echo " "
docker compose version
if [ $? -ne 0 ]
then
DOCKER_VER="$(curl -fsSLI -o /dev/null -w %{url_effective} https://github.com/docker/compose/releases/latest | awk 'BEGIN{FS="v"} {print $2}')"
echo -e "\e[1m\e[32mInstalling Docker Compose latest v$DOCKER_VER ... \e[0m" && sleep 1
curl -SL https://github.com/docker/compose/releases/download/v$DOCKER_VER/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo chown $USER /var/run/docker.sock
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
fi
}


function backupPK {
echo " "
echo -e "\e[1m\e[32mPreparing to backup router private key ... \e[0m" && sleep 1
cd $HOME/connext/nxtp-router-docker-compose
cat key.yaml |grep privateKey | awk -F'"' '{print $2}' > $HOME/connext/router_private_key.json
echo -e "\e[1m\e[92mYour Private Key:  \e[0m" $(cat $HOME/connext/router_private_key.json)
pkBkpPath="$HOME/connext/router_private_key.json"
echo -e "\e[7mHas been saved at: $pkBkpPath\e[0m"
cd $HOME
}


function createpk {
echo " "
echo -e "\e[1m\e[32mCreate Private Key ... \e[0m" && sleep 1
openssl rand -hex 32 > $HOME/connext/router_private_key.json
echo -e "\e[1m\e[92mYour Private Key:  \e[0m" $(cat $HOME/connext/router_private_key.json)
pkBkpPath="$HOME/connext/router_private_key.json"
echo -e "\e[7mHas been saved at: $pkBkpPath\e[0m"
}



function installnxtp {
echo " "
echo -e "\e[1m\e[32mPreparing to install Router ... \e[0m" && sleep 1
mkdir -p $HOME/connext
cd $HOME/connext
git clone https://github.com/connext/nxtp-router-docker-compose.git
}


function coreversion_amarok {
echo " "
echo -e "\e[1m\e[32mSwitch to amarok version ... \e[0m" && sleep 1
cd $HOME/connext/nxtp-router-docker-compose
git checkout amarok
}



function createConfig {
echo " "
read -p "Insert your Project ID from Infura: " Project_ID
cd $HOME/connext/nxtp-router-docker-compose
echo -e "\e[1m\e[32mPreparing config ... \e[0m" && sleep 1
wget -O config.json https://raw.githubusercontent.com/martynovalek/NXTP-Router-setup/main/Full%20version/config.json
sed -i 's/project_ID/'${Project_ID}'/g' $HOME/connext/nxtp-router-docker-compose/config.json
sleep 2
}



#function upvernxtp {
#cd $HOME/connext/nxtp-router-docker-compose
#read -p "Insert Router Version: " nxtpv
#cp .env.example .env
#curl -fsSLI -o /dev/null -w %{url_effective} https://github.com/connext/nxtp/releases/latest | awk 'BEGIN{FS="v"} {print $2}' > nxtp.version
#echo " "
#echo -e "\e[1m\e[32mLast NXTP Version : $(cat $HOME/connext/nxtp-router-docker-compose/nxtp.version)\e[0m" && sleep 1
#sed -i 's/latest/'$(cat $HOME/connext/nxtp-router-docker-compose/nxtp.version)'/g' .env
#docker pull ghcr.io/connext/router:$(cat $HOME/connext/nxtp-router-docker-compose/nxtp.version)
#}


function upvernxtp {
cd $HOME/connext/nxtp-router-docker-compose
cp .env.example .env
curl -fsSLI -o /dev/null -w %{url_effective} https://github.com/connext/nxtp/releases/latest | awk 'BEGIN{FS="v"} {print $2}' > nxtp.version
echo " "
echo -e "\e[1m\e[32mLatest NXTP Version: $(cat $HOME/connext/nxtp-router-docker-compose/nxtp.version)\e[0m" && sleep 1
sed -i 's/latest/'$(cat $HOME/connext/nxtp-router-docker-compose/nxtp.version)'/g' .env
docker pull ghcr.io/connext/router:$(cat $HOME/connext/nxtp-router-docker-compose/nxtp.version)
}


function upgrade {
CURRENT=$(cat $HOME/connext/nxtp-router-docker-compose/.env | grep ROUTER_VERSION | awk -F '=' '{print$2}')
echo -e "\e[1m\e[32mCurrent installed NXTP Version: $CURRENT\e[0m" && sleep 1
NEW="$(curl -fsSLI -o /dev/null -w %{url_effective} https://github.com/connext/nxtp/releases/latest | awk 'BEGIN{FS="v"} {print $2}')"
echo -e "\e[1m\e[32mNew NXTP Version: $NEW\e[0m" && sleep 1
sed -i.bak -e "s/$CURRENT/$NEW/" $HOME/connext/nxtp-router-docker-compose/.env
echo -e "\e[1m\e[32mPreparing to upgrade ... \e[0m" && sleep 1
}


function manupvernxtp {
cd $HOME/connext/nxtp-router-docker-compose
read -p "Insert Router Version: " nxtpv 
cp .env.example .env
echo " "
echo -e "\e[1m\e[32mInstall NXTP Version : ${nxtpv}\e[0m" && sleep 1
sed -i 's/latest/'${nxtpv}'/g' .env
docker pull ghcr.io/connext/router:${nxtpv}
}


function setautokeyfile {
cd $HOME/connext/nxtp-router-docker-compose
cp key.example.yaml key.yaml
sed -i 's/dkadkjasjdlkasdladadasda/'$(cat $HOME/connext/router_private_key.json)'/g' key.yaml
}


function setyourkeyfile {
echo " "
echo -e "\e[1m\e[32mPreparing your Private Key ... \e[0m" && sleep 1
cd $HOME/connext/nxtp-router-docker-compose
cp key.example.yaml key.yaml
read -p "Insert your Private Key from Metamask: " yourpk
sed -i 's/dkadkjasjdlkasdladadasda/'${yourpk}'/g' key.yaml
echo -e "\e[1m\e[32mYour Key has been writen into key.yaml ... \e[0m" && sleep 1
}


function setlastver {
echo " "
cd $HOME/connext/nxtp-router-docker-compose
cp .env.example .env
echo " "
echo -e "\e[1m\e[32mLast NXTP Version : sha-498913b \e[0m" && sleep 1
sed -i 's/latest/sha-498913b/g' .env
docker pull ghcr.io/connext/router:sha-498913b
}


function dockerpull {
echo " "
echo -e "\e[1m\e[32mPreparing pull docker ... \e[0m" && sleep 1
cd $HOME/connext/nxtp-router-docker-compose
docker-compose pull
}


function dockerdown {
echo " "
echo -e "\e[1m\e[32mPreparing down Router ... \e[0m" && sleep 1
cd $HOME/connext/nxtp-router-docker-compose
docker-compose down
sleep 2
}


function dockerup {
echo " "
echo -e "\e[1m\e[32mPreparing Start Router ... \e[0m" && sleep 1
cd $HOME/connext/nxtp-router-docker-compose
docker-compose up -d
sleep 2
}


function delete {
echo " "
echo -e "\e[1m\e[32mPreparing Delete Router ... \e[0m" && sleep 1
cd $HOME/connext/nxtp-router-docker-compose
docker-compose down
docker system prune -a
cd $HOME
rm -rf $HOME/connext
}




PS3='Please enter your choice (input your option number and press enter): '
options=("Install + Auto PKey" "Install + Your PKey" "Auto Upgrade" "Manual Upgrade" "Backup PKey" "Delete" "Quit")

select opt in "${options[@]}"
do
    case $opt in
        "Install + Auto PKey")
echo " "
echo -e '\e[1m\e[32mYou choose Install Router with auto Private Key ...\e[0m' && sleep 1
Installingrequiredtool
Installingdocker
installnxtp
coreversion_amarok
#setlastver
upvernxtp
createConfig
createpk
setautokeyfile
#dockerpull
dockerup
echo -e "\e[1m\e[32mYour Router was Install!\e[0m" && sleep 1
echo -e "Check logs: docker logs --follow --tail 100 router"
echo -e "\e[1m\e[92mYour Private Key:  \e[0m" $(cat $HOME/connext/router_private_key.json)
echo -e "\e[1m\e[92mHas been saved at $HOME/connext/router_private_key.json\e[0m" && sleep 1
break
;;

"Install + Your PKey")
echo " "
echo -e '\e[1m\e[32mYou choose Install Router with your Private Key ...\e[0m' && sleep 1
Installingrequiredtool
Installingdocker
installnxtp
coreversion_amarok
#setlastver
upvernxtp
createConfig
setyourkeyfile
#dockerdown
#dockerpull
dockerup
echo -e "\e[1m\e[32mYour Router was Install!\e[0m" && sleep 1
echo -e "Check logs: docker logs --follow --tail 100 router"
sleep 1
break
;;

"Auto Upgrade")
echo " "
echo -e '\e[1m\e[32mYou choose Upgrade Version ...\e[0m' && sleep 1
upgrade
dockerdown
#upvernxtp
dockerpull
dockerup
#echo -e "\e[1m\e[32mYour Router was upgraded to : $(cat $HOME/connext/nxtp-router-docker-compose/nxtp.version)\e[0m" && sleep 1
echo -e "\e[1m\e[32mYour Router was upgraded to: $(cat $HOME/connext/nxtp-router-docker-compose/.env | grep ROUTER_VERSION | awk -F '=' '{print$2}')\e[0m" && sleep 1
break


;;

"Manual Upgrade")
echo " "
echo -e '\e[1m\e[32mYou choose Manual Upgrade Version ...\e[0m' && sleep 1
dockerdown
manupvernxtp
dockerpull
dockerup
echo -e "\e[1m\e[32mYour Router was upgraded to : ${nxtpv} \e[0m" && sleep 1
break


;;


"Backup PKey")
echo " "
echo -e '\e[1m\e[32mYou choose Backup Private Key ...\e[0m' && sleep 1
backupPK
break

;;
"Delete")
echo " "
echo -e '\e[1m\e[32mYou choose Delete All Router Files and Data ...\e[0m' && sleep 1
delete
break

;;
"Quit")
break
;;

*) echo -e "\e[91mInvalid option $REPLY\e[0m";;
    esac
done
