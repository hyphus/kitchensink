#!/bin/bash

set -ex

cd /tmp/

# dotfiles
git clone --depth 1 https://github.com/hyphus/dotfiles.git 
cp /tmp/dotfiles/.bash_profile /root/.bash_profile 
cp /tmp/dotfiles/.vimrc /root/.vimrc 
cp /tmp/dotfiles/.tmux.conf /root/.tmux.conf 

mkdir /root/.ssh/
cat << EOF > /root/.ssh/config 
Host *
    ServerAliveCountMax 5
    ServerAliveInterval 60
EOF

# vim plugins
vim +'PlugInstall --sync' +qall &> /dev/null

# tmux
git clone --depth 1 https://github.com/tmux-plugins/tpm /root/.tmux/plugins/tpm 
tmux start-server 
tmux new-session -d 
sleep 1 # to give new-session time to init 
tmux source ~/.tmux.conf 
~/.tmux/plugins/tpm/scripts/install_plugins.sh 
tmux kill-server

# aliases
echo "alias python=python3" >> /root/.bash_profile 
echo "alias pip=pip3" >> /root/.bash_profile 
echo "alias proxychains='proxychains4 -q'" >> /root/.bash_profile 
echo "alias pbcopy='xclip -sel clip'" >> /root/.bash_profile

# command completion
echo "complete -C '/usr/bin/aws_completer' aws" >> /root/.bash_profile
echo "source /etc/profile.d/bash_completion.sh" >> /root/.bash_profile

curl -s -L https://get.spectralops.io/latest/x/sh | sh 
mv /root/.spectral/spectral /usr/local/bin/spectral

pip3 install trufflehog3 boto3

ln -fs /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
dpkg-reconfigure -f noninteractive tzdata
