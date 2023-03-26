#!/usr/bin/env sh

sh -c rc-status; rc-service sshd stop; rc-service sshd start; 
if command -v omf > /dev/null; then
    echo "omf command exists"
else
    curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
    omf install bobthefish
fi

nvim --listen /tmp/nvimsocket
