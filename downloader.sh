!/bin/bash

REMOTEUSER=""
REMOTEHOST=""
REMOTEPORT=""

LOCALPATH=""
REMOTEPATH=""

SIZE=""

while :
do
        FILES=$(ssh -p$REMOTEPORT -l $REMOTEUSER $REMOTEHOST "ls -lh $REMOTEPATH" | grep -v total | grep $SIZE | rev | cut -d' ' -f1 | rev | head -n 1)
        if [ $(echo $FILES | wc -w) -gt 0 ]
        then
                FILES=$(echo $FILES | sed 's/ /,/g');
                rsync -avz --remove-source-files -e "ssh -p $REMOTEPORT" $REMOTEUSER@$REMOTEHOST:$REMOTEPATH$FILES $LOCALPATH
        fi
        echo "[*] Sleeping..."
        sleep 600
done
