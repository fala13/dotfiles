# dotfiles
My config files for vim, etc. Actually I now just use stock settings for most stuff and just vim mode in vs code and in chrome.

# cleanup csv files
```
awk -F',' '$4 < 10' payloads.txtn
sort -k5 -t, -u payloads.txt
```
# OOM
# from bnb-reth gh:
```
sudo sysctl -w vm.min_free_kbytes=4194304
echo "vm.min_free_kbytes=4194304" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
screen -wipe | tail -n2 | awk '{print $1}' | xargs  screen -wipe 
```

# GOLANG
```
make clean

goenv local 1.20.14
goenv global 1.20.14
goenv shell 1.20.14

export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"

make nccc_geth
```

# mdadm

```
sudo mdadm --create --verbose /dev/md2 --level=0 --raid-devices=4 --chunk=256 /dev/nvme3n1 /dev/nvme4n1 /dev/nvme5n1  /dev/nvme6n1

sudo mdadm --detail --scan >> /etc/mdadm.conf

sudo mkfs.xfs -f -d su=256k,sw=4 -l size=128m -n size=64k /dev/md0

sudo mount -o noatime,logbufs=8,discar /dev/md0 /mnt/raid
/dev/md0  /mnt/raid  xfs  defaults,noatime,logbufs=8,discard  0  2

// test
sudo fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=test --filename=test --bs=4k --iodepth=64 --size=1G --readwrite=randrw --rwmixread=75 ; sudo rm test

// clean
sudo mdadm --zero-superblock /dev/nvme0n1
```

# Rust
```
RUST_MIN_STACK=8388608 app
```
# commands I like but forget:
```
chown -R fala:users my_dir/

journalctl -u geth -f

docker system prune

ssh yoyo@yoyo.org -p 6969 -o ServerAliveInterval=10

rsync -arzv -e "ssh -i aws.pem" A B
rsync -av --inplace a/ b/

ulimit -m 40971520
ulimit -v 40971520
ulimit -c 0

aria2c -x4 -s4 --retry-wait=10 -m 0 https://snapshot.arbitrum.foundation/arb1/nitro-pruned.tar
```

# netrunning
# new arch firewall, because why wouldn't you need to remember new firewall command format every few years
```
sudo firewall-cmd --zone=public --add-port=7777/tcp --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --list-all

# checkz open portz
sudo lsof -i -P -n | grep LISTEN
```
https://www.yougetsignal.com/tools/open-ports/

# get my ip
wget -qO- https://ifconfig.me/ip

# ipc paths
netstat -lx | grep ipc

# synching?
```
# geth
--verbiosty=2
# op-node
OP_NODE_LOG_LEVEL=warn
```

curl -X POST --data '{"jsonrpc":"2.0","method":"eth_syncing","params":[],"id":1}' -H "Content-Type: application/json" http://localhost:8545
curl -s -X POST --data '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}' -H "Content-Type: application/json" http://localhost:8545 | jq '.result' | xargs printf "%d\n"
3845441


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
# core dumps 
/var/lib/systemd/coredump 
https://debugging.works/blog/analyzing-linux-coredump/ 
https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/managing_monitoring_and_updating_the_kernel/analyzing-a-core-dump_managing-monitoring-and-updating-the-kernel
coredumpctl list

export RUST_BACKTRACE=full
export RUSTFLAGS=-Zsanitizer=address RUSTDOCFLAGS=-Zsanitizer=address
cargo +nightly run -Zbuild-std  --target x86_64-unknown-linux-gnu --bin=

# Get a cs signatures dump:
```
curl -C - -O -L https://api.openchain.xyz/signature-database/v1/export
```

# OpenZeppelin requires newer soliditity version in forge?
```
forge install OpenZeppelin/openzeppelin-contracts@fd81a96f01cc42ef1c9a5399364968d0e07e9e90 --no-commit 
```

# arbitrum snapshot
```
wget -O - https://snapshot.arbitrum.foundation/arb1/nitro-pruned.tar | tar -xv
chown -R root:root arb1/
docker run --rm -it --add-host host.docker.internal:host-gateway -v /srv/arbitrum/:/home/user/.arbitrum -p 0.0.0.0:8547:8547 -p 0.0.0.0:8548:8548 offchainlabs/nitro-node:v3.2.1-d81324d --parent-chain.connection.url=$L1NODE --chain.id=42161 --http.api=net,web3,eth --http.corsdomain=* --http.addr=0.0.0.0 --http.vhosts=* --execution.rpc.classic-redirect=$REDIRECT --ws.port=8548 --ws.addr=0.0.0.0 --ws.origins=* --ipc.path=/home/user/.arbitrum/arb.ipc --ws.api=net,web3,eth,debug --node.staker.enable=false --parent-chain.blob-client.beacon-url=$BEACON --execution.caching.archive \
        --execution.caching.database-cache 20480 \
        --execution.caching.snapshot-cache 4000 \
        --execution.caching.stylus-lru-cache 2560 \
        --execution.caching.trie-clean-cache 6000 \
        --execution.caching.trie-dirty-cache 10240 \
        --execution.recording-database.trie-clean-cache 160 \
        --execution.recording-database.trie-dirty-cache 10240 \
        --execution.rpc.filter-log-cache-size 320 \
        --init.accounts-per-sync 1000000 \
        --init.prune-bloom-size 20480 \
        --init.prune-trie-clean-cache 6000 \
        --node.block-validator.batch-cache-limit 200 \
        --node.transaction-streamer.max-broadcaster-queue-size 500000 \
        --validation.arbitrator.execution.cached-challenge-machines 40 \
        --validation.jit.wasm-memory-usage-limit 42949672960
```

