#For latest version router
#!/bin/bash
exists()
{
  command -v "$1" >/dev/null 2>&1
}
if exists curl; then
echo ''
else
  sudo apt update && sudo apt install curl -y < "/dev/null"
fi
bash_profile=$HOME/.bash_profile
if [ -f "$bash_profile" ]; then
    . $HOME/.bash_profile
fi
sleep 1 
echo -e '\e[40m\e[92m'
echo -e ' ######################©æëo*=;;;=*oëæ©###################### '
echo -e ' #################§I~;&ë§§§§§§§§§§§§§ë&;~I§################# '
echo -e ' #############æ*^&Ñ§§§§§§§§§§§§§§§§§§§§§§§Ñ&^*æ############# '
echo -e ' ##########©&~£§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§£~&©########## '
echo -e ' ########æ;?Ñ§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§Ñ?;æ######## '
echo -e ' ######¶?=§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§=?¶###### '
echo -e ' #####£~Ñ§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§Ñ~£##### '
echo -e ' ###N=*§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§*=N### '
echo -e ' ##N/o§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§o/N## '
echo -e ' #N»%§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§%»N# '
echo -e ' #o?§§§§§§§§§§§§X=;;/*£§§§§§§§§§§§§§§§±*/;/=XÑ§§§§§§§§§§§?o# '
echo -e ' æ^Ñ§§§§§§§§Ñ»..........´I§§§§§§§§§&´........../Ñ§§§§§§§§Ñ^æ '
echo -e ' %*§§§§§§§§&...´IÑ§§§Ñ*...´ë§§§§§£....»@§§§Ñ&´...=§§§§§§§§*% '
echo -e ' ;±§§§§§§§I...?§§§§§§§§§&Ñ§§§§§§X...~Ñ§§§§§§§§*...?§§§§§§§±; '
echo -e ' ~Ñ§§§§§§Ñ´..~§§§§§§§§§§§§§§§§§§^..,Ñ§§§§§§§§§§»...±§§§§§§Ñ~ '
echo -e ' ~Ñ§§§§§§£...*§§§§=........X§§§@...»§§§§§§§§§§§X...&§§§§§§Ñ~ '
echo -e ' í@§§§§§§±...=§§§§%/////'..X§§§Ñ´..í§§§§§§§§§§§&...o§§§§§§@í '
echo -e ' ?o§§§§§§§~..´@§§§§§§§§§í..X§§§§?...%§§§§§§§§§@´..'§§§§§§§o? '
echo -e ' @;§§§§§§§@,...o§§§§§§§/...X§§§§§í...?§§§§§§§X´..´@§§§§§§§;@ '
echo -e ' N/X§§§§§§§§»....'»=/,.....X§§§§§§%....´;?/'..../§§§§§§§§X/N '
echo -e ' #É^Ñ§§§§§§§§§o~......,%;..X§§§§§§§§ë/.......^o§§§§§§§§§Ñ^É# '
echo -e ' ##@~§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§~@## '
echo -e ' ###@~Ñ§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§Ñ~@### '
echo -e ' ####É~±§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§±~É#### '
echo -e ' #####NI/§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§/IN##### '
echo -e ' #######æ;*§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§*;æ####### '
echo -e ' #########¶?/@§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§@/?¶######### '
echo -e ' ###########N±~=Ñ§§§§§§§§§§§§§§§§§§§§§§§§§§§Ñ=~±N########### '
echo -e ' ##############N§»^I@§§§§§§§§§§§§§§§§§§§@I^»§N############## '
echo -e ' ###################¶ë=í^;=&oXXXo&=;^í=ë¶################### '
echo -e '\e[0m'
sleep 1
mkdir -p $HOME/connext
if [ ! $Private_Key ]; then
read -p "Insert your Private_Key from Metamask: " Private_Key
echo 'export Private_Key='\"${Private_Key}\" >> $HOME/connext/your.key
fi

apt update && apt install git sudo unzip wget -y

#install docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

#install docker-compose
curl -SL https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

#install nxtp-route
cd $HOME/connext
git clone https://github.com/connext/nxtp-router-docker-compose.git
sleep 2 
cd $HOME/connext/nxtp-router-docker-compose
sleep 2 
git checkout amarok
sleep 2 
docker pull ghcr.io/connext/router:latest

#create env config key file
cp .env.example .env
sleep 2
wget -O config.json https://raw.githubusercontent.com/martynovalek/NXTP-Router-install/blob/main/config.json
sleep 2
wget -O key.yaml https://raw.githubusercontent.com/martynovalek/NXTP-Router-install/blob/main/key.yaml
sleep 2

#Paste private key to key.yaml
sed -i 's/your_privatekey/'$Private_Key'/g' key.yaml
sleep 2
docker-compose down
sleep 2
docker compose up -d
echo -e "Your Router \e[32minstalled and works\e[39m!"
