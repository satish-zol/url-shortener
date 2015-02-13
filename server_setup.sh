echo "* Updating system"
apt-get update
apt-get -y upgrade
echo "* Installing packages"
apt-get -y install build-essential libmagickcore-dev imagemagick libmagickwand-dev libxml2-dev libxslt1-dev git-core nginx redis-server curl nodejs htop

id -u deploy &> /dev/null

if [ $? -ne 0 ]
then
  echo "* Creating user deploy"
  useradd -m -g staff -s /bin/bash deploy
  echo "* Adding user deploy to sudoers"
  chmod +w /etc/sudoers
  echo "deploy ALL=(ALL) ALL" >> /etc/sudoers
  chmod -w /etc/sudoers
else
  echo "* deploy user already exists"
fi

echo "* Installing rvm"
. /etc/profile.d/rvm.sh &> /dev/null

type rvm &> /dev/null

if [ $? -ne 0 ]
then
  curl -L https://get.rvm.io | bash -s
  echo "source /etc/profile.d/rvm.sh" >> /etc/bash.bashrc
  . /etc/profile.d/rvm.sh &> /dev/null
else
  echo "* rvm already installed"
fi

cat /etc/environment | grep RAILS_ENV
if [ $? -ne 0 ]
then
  echo "RAILS_ENV=production" >> /etc/environment
fi

echo "* Adding ssh key to authorized_keys"
test -d /home/deploy/.ssh
if [ $? -ne 0 ]
then
  mkdir /home/deploy/.ssh
  chmod 700 /home/deploy/.ssh
  chown deploy /home/deploy/.ssh
  chgrp staff /home/deploy/.ssh
fi

chmod 600 /home/deploy/.ssh/authorized_keys
chown deploy /home/deploy/.ssh/authorized_keys
chgrp staff /home/deploy/.ssh/authorized_keys

echo "* Install ruby version 2.1.2"
ruby -v &> /dev/null
if [ $? -ne 0 ]
then
  rvm install 2.1.2
else
  echo "* Ruby already installed"
fi

echo "* Add user deploy to rvm group"
usermod -a -G rvm deploy

rvm --default use 2.1.2
ruby -v
echo "* DONE *"
echo "* Rebooting system *"
reboot