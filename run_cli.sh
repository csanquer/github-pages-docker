#/bin/bash

if [ $# -lt 1 ]; then
    cmds="/bin/bash"
else
    cmds="$@"
fi

export GROUP_ID=`id -g`
export USER_ID=`id -u`
export USERNAME=jekyll
export GROUPNAME=$USERNAME
export HOMEDIR=/home/$USERNAME

docker-compose run --rm app $cmds
