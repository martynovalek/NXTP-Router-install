# Install NXTP Router version 0.2.0-alpha.16

>**Minimum Hardware Requirements**<br>
>:black_square_button: 8GB RAM<br>
>:black_square_button: 30GB Storage<br>
>:black_square_button: Redis

## Quick router setup (oneliner script)
Use the code below to install it automatically: 
```
wget -q -O nxtp-router.sh https://raw.githubusercontent.com/martynovalek/NXTP-Router-install/main/nxtp-router-latest.sh && chmod +x nxtp-router.sh && sudo /bin/bash nxtp-router.sh
```
:warning: Prepare in advance a private key of your wallet from Metamask. You should enter it right after running the script.<br>
For safety reason create a new wallet address for router.

Whait just for 2 min.
As the installing is finished you will see `"Your Router installed and works!"`

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
**Get the Router version 0.2.0-alpha.16**
```
docker pull ghcr.io/connext/router:0.2.0-alpha.16
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

**Paste your private key Instead of <your_key>**
```
PRIVATE_KEY="<your_key>"
```
**Use command below to write key into `key.yaml` file**
```
sed -i 's/your_privatekey/'$PRIVATE_KEY'/g' key.yaml
```

**6. Setup `.env` file**
```
sed -i 's/latest/0.2.0-alpha.16/g' .env
```

**7. Run your Router**<br>
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

## Additional commands
#### Restart Docker:
```
cd $HOME/connext/nxtp-router-docker-compose
docker-compose restart
```
---
#### Update Router Version:
Open and modify `.env` to change ROUTER_VERSION<br>
You can check the latest version here: https://github.com/connext/nxtp/releases

```
cd $HOME/connext/nxtp-router-docker-compose
nano .env
```

<pre>
<kbd>Ctrl</kbd>+<kbd>X</kbd> then <kbd>y</kbd> - to save the changes
</pre> 

**Now update the stack:**
```
docker-compose pull
docker-compose up -d
```
---
#### Delete Router and everything relating to it:
```
cd ~/connext/nxtp-router-docker-compose
docker-compose down
docker system prune -a
cd && rm -rf $HOME/connext
```


