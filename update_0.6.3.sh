#!/bin/bash
GREEN_COLOR='\033[0;32m'
RED_COLOR='\033[0;31m'
NO_COLOR='\033[0m'
BLOCK=1507363
VERSION=0.6.3
echo -e "$GREEN_COLOR YOUR NODE WILL BE UPDATED TO VERSION: $VERSION ON BLOCK NUMBER: $BLOCK $NO_COLOR\n"
for((;;)); do
height=$(chaind status |& jq -r ."SyncInfo"."latest_block_height")
if ((height>=$BLOCK)); then
cd $HOME
wget https://github.com/KYVENetwork/chain/releases/download/v0.6.3/chain_linux_amd64.tar.gz
tar -xvzf chain_linux_amd64.tar.gz
chmod +x chaind
sudo mv chaind $HOME/go/bin/
rm chain_linux_amd64.tar.gz

echo "restart the system..."
sudo systemctl restart kyved
for (( timer=60; timer>0; timer-- ))
        do
                printf "* second restart after sleep for ${RED_COLOR}%02d${NO_COLOR} sec\r" $timer
                sleep 1
        done
height=$(chaind status |& jq -r ."SyncInfo"."latest_block_height")
if ((height>$BLOCK)); then
echo -e "$GREEN_COLOR YOUR NODE WAS SUCCESFULLY UPDATED TO VERSION: $VERSION $NO_COLOR\n"
fi
chaind version --long | head
break
else
echo $height
fi
sleep 1
done
