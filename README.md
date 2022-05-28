# Spinning up NXTP Router version 0.2.0-beta.8 + update

>**Minimum Hardware Requirements**<br>
>:black_square_button: 8GB RAM<br>
>:black_square_button: 30GB Storage<br>
>:black_square_button: Redis (not necessary, as it is used in the docker by default)

## :warning: Prepair to install
1. Prepare in advance a **private key of your wallet** from Metamask. You should enter it right after running the script.<br>
For safety reason create a new wallet address for router.

2. **Setup provider endpoints.** Then you'll add it to `config.json` file to use your own.
For that we will use the nodes provided by the service [Infura](https://infura.io/). 

  2.1 Register at [infura.io](https://infura.io/) and create new project:
  
  <img width="1000" alt="Снимок экрана 2022-05-28 в 13 04 44" src="https://user-images.githubusercontent.com/88688304/170812549-0cc07f55-abae-4ad4-9ede-6a9ba7d812ce.png">

<img width="1000" alt="Снимок экрана 2022-05-28 в 12 39 32" src="https://user-images.githubusercontent.com/88688304/170812576-f7d57b0f-b455-4cab-b6fb-8cdf48f148b8.png">

  2.2 Open settings:
  
  <img width="1000" alt="Снимок экрана 2022-05-28 в 12 42 54" src="https://user-images.githubusercontent.com/88688304/170812595-66f5557e-8fc3-42c8-a08e-82ff270bcab2.png">

  2.3 And copy your project ID. It will be the same on any network
  
  <img width="1000" alt="Снимок экрана 2022-05-28 в 12 44 21" src="https://user-images.githubusercontent.com/88688304/170812613-de163f51-3cd6-4a47-aeda-680d812e3b53.png">

**Keep this data handy, you will need it for further installation**

## Quick router setup (oneliner script)
Use the code below to install it automatically: 
```
wget -q -O nxtp-router.sh https://raw.githubusercontent.com/martynovalek/NXTP-Router-install/main/nxtp-router-latest.sh && chmod +x nxtp-router.sh && sudo /bin/bash nxtp-router.sh
```
Just after you run the script, you need to insert the private key, and then the project ID.

Then whait just for 2 min. As the installing is finished you will see `"Your Router installed and works!"`

Check router logs:
```
cd $HOME/connext/nxtp-router-docker-compose
docker logs --follow --tail 100 router
```

## Manual install

**1. Update and install packages**
```
sudo apt update && sudo apt upgrade -y
apt install git sudo unzip wget curl htop -y
```

**2. Install Docker and Docker-compose**
```
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
rm get-docker.sh
```
```
curl -SL https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
```

**3. Install Router**
```
cd $HOME
mkdir -p connext && cd connext
git clone https://github.com/connext/nxtp-router-docker-compose.git
cd $HOME/connext/nxtp-router-docker-compose
git checkout amarok
```
**Get the Router version 0.2.0-beta.8**
```
docker pull ghcr.io/connext/router:0.2.0-beta.8
```

**4. Create .env, config and key files:**
```
cp .env.example .env
wget -O config.json https://raw.githubusercontent.com/martynovalek/NXTP-Router-install/main/config.json
wget -O key.yaml https://raw.githubusercontent.com/martynovalek/NXTP-Router-install/main/key.yaml
```

**Delete example files:**
```
rm config.example.json .env.example key.example.yaml
```

**5. Setup `key.yaml` file**

**Paste your private key from Metamask instead of <your_key>**
```
PRIVATE_KEY="<your_key>"
```
**Use command below to write key into `key.yaml` file**
```
sed -i 's/your_privatekey/'$PRIVATE_KEY'/g' key.yaml
```
**6. Setup `config.json` file.**

Paste your Project ID from Infura into the command below instead 'XXXX'
```
PROJECT_ID="XXXX"
```
```
sed -i 's/224d26fcdc02495c921bb5d74702002e/'$PROJECT_ID'/g' $HOME/connext/nxtp-router-docker-compose/config.json
```

**7. Setup `.env` file**
```
sed -i 's/latest/0.2.0-beta.8/g' .env
```

**8. Run your Router**<br>
Ensure your currently directory is `$HOME/connext/nxtp-router-docker-compose`
```
docker-compose down
docker-compose up -d
```

**Check logs:**
```
cd $HOME/connext/nxtp-router-docker-compose
docker logs --follow --tail 100 router
```

Now you can check data of your provider at infura.io
<img width="1000" alt="Снимок экрана 2022-05-28 в 12 50 19" src="https://user-images.githubusercontent.com/88688304/170814579-3c421ab0-3ff4-4b7a-8715-b131f2ea7c2e.png">


## Additional commands
#### Restart Docker:
```
cd $HOME/connext/nxtp-router-docker-compose
docker-compose restart
```
---
#### Update Router Version:
We have to modify `.env` to change ROUTER_VERSION<br>
You can check the latest version here: https://github.com/connext/nxtp/releases

**Enter new version instead of <new_ver>:**
```
NEW="<new_ver>"
```
Modify the `.env` file:
```
CURRENT=$(cat $HOME/connext/nxtp-router-docker-compose/.env | grep ROUTER_VERSION | awk -F '=' '{print$2}')
sed -i.bak -e "s/$CURRENT/$NEW/" $HOME/connext/nxtp-router-docker-compose/.env
```
Check current version in `.env` file:
```
cat $HOME/connext/nxtp-router-docker-compose/.env | grep ROUTER_VERSION | awk -F '=' '{print$2}'
```

**Now update the stack and check logs:**
```
cd $HOME/connext/nxtp-router-docker-compose
docker-compose down
docker-compose pull
docker-compose up -d
docker logs --follow --tail 100 router
```
---
#### Delete Router and everything relating to it:
```
cd ~/connext/nxtp-router-docker-compose
docker-compose down
docker system prune -a
cd && rm -rf $HOME/connext
```


