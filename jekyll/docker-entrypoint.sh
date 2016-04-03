#!/bin/bash

# echo SSH_AUTH_SOCK $SSH_AUTH_SOCK
#
# echo GID $GROUP_ID
# echo UID $USER_ID
# echo USER $USERNAME
# echo GROUP $GROUPNAME
# echo HOME $HOMEDIR


groupadd -f -g $GROUP_ID $GROUPNAME
useradd -u $USER_ID -g $GROUP_ID $USERNAME
usermod -a -G sudo $USERNAME
mkdir --parent $HOMEDIR
chown -R $USERNAME:$GROUPNAME $HOMEDIR

mkdir -p $HOMEDIR/.ssh/
cp /root/.ssh/config $HOMEDIR/.ssh/config
cp /root/.gitignore $HOMEDIR/.gitignore

if [ -n "$SSH_PRIVATE_KEY" ] ;then
    echo "$SSH_PRIVATE_KEY" > $HOMEDIR/.ssh/id_rsa
    chmod 0600 $HOMEDIR/.ssh/id_rsa

    if [ -n "$SSH_PUBLIC_KEY" ] ;then
        echo "$SSH_PUBLIC_KEY" > $HOMEDIR/.ssh/id_rsa.pub
        chmod 0640 $HOMEDIR/.ssh/id_rsa.pub
    fi
fi

echo 'export PATH=/usr/local/bundle/bin:$PATH' >> $HOMEDIR/.bashrc

chown -R $USERNAME:$GROUPNAME $HOMEDIR /srv/apps

sudo -u $USERNAME -H -E "$@"

# exec "$@"
