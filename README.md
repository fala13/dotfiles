# dotfiles
My config files for vim, etc. Actually I now just use stock settings for most stuff and just vim mode in vs code and in chrome.

# commands I like but forget:
```
chown -R fala:users my_dir/

journalctl -u geth -f

docker system prune

ssh yoyo@yoyo.org -p 6969 -o ServerAliveInterval=10

rsync -arzv -e "ssh -i aws.pem" A B

```

# netrunning
# new arch firewall, because why wouldn't you need to remember new firewall command format every few years
```
firewall-cmd --zone=public --add-port=7777/tcp --permanent
firewall-cmd --reload
firewall-cmd --list-all

# checkz open portz
sudo lsof -i -P -n | grep LISTEN
```

# get my ip
wget -qO- https://ifconfig.me/ip

# ipc paths
netstat -lx | grep ipc

# synching?
curl -X POST --data '{"jsonrpc":"2.0","method":"eth_syncing","params":[],"id":1}' -H "Content-Type: application/json" http://localhost:8545

# setup on aws linux
```
sudo yum install git -y

ssh-keygen -t ed25519 -C "yoyo"
cat ~/.ssh/id_ed25519.pub # use elsewhere

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
sudo yum install pkgconfig openssl-devel make glibc-devel gcc patch

sudo vim /etc/yum.repos.d/grafana.repo

sudo yum update -y 
sudo yum install docker 
sudo service docker start 
sudo usermod -a -G docker ec2-user
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```
paste:
```
[grafana]
name=grafana
baseurl=https://packages.grafana.com/oss/rpm
repo_gpgcheck=1
enabled=1
gpgcheck=1
gpgkey=https://packages.grafana.com/gpg.key
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
```
```
wget -q -O gpg.key https://rpm.grafana.com/gpg.key
sudo rpm --import gpg.key
sudo dnf install grafana-agent
```
