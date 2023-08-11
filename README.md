# dotfiles
My config files for vim, etc. Actually I now just use stock settings for most stuff and just vim mode in vs code and in chrome.

# commands I like but forget:
chown -R fala:users my_dir/

journalctl -u geth -f

docker system prune

ssh yoyo@yoyo.org -p 6969 -o ServerAliveInterval=10

# netrunning
# new arch firewall, because why wouldn't you need to remember new firewall command format every few years
firewall-cmd --zone=public --add-port=7777/tcp --permanent
firewall-cmd --reload
firewall-cmd --list-all

# get my ip
wget -qO- https://ifconfig.me/ip

# ipc paths
netstat -lx | grep ipc

# synching?
curl -X POST --data '{"jsonrpc":"2.0","method":"eth_syncing","params":[],"id":1}' -H "Content-Type: application/json" http://localhost:8545
