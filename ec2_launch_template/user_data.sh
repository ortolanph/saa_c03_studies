#!/bin/bash

LOG_FILE=~/logfile.log

function log() {
  echo "[%1][$(date +'%d/%m/%Y %T')] %2" >> $LOG_FILE
}

touch $LOG_FILE
log "INIT" "Welcome to instance configurator"

log "INSTALL" "Installing pakages"
yum update -y
yum install tree nginx -y

log "STORAGE" "Mounting Storage B"
sudo mkfs -t xfs /dev/xvdb
sudo mkdir -p /data/my_volume_b
sudo mount /dev/xvdb /data/my_volume_b

log "STORAGE" "Mounting Storage C"
sudo mkfs -t xfs /dev/xvdc
sudo mkdir -p /data/my_volume_c
sudo mount /dev/xvdc /data/my_volume_c

log "STORAGE" "Sending a message to them"
echo "Welcome to the real World" > /data/my_volume_b/README.txt
echo "Welcome to the real World" > /data/my_volume_c/README.txt

log "SERVER" "Starting NGINX"
sudo systemctl start nginx.service

log "STORAGE" "Creating a file to understand that everything is fine"
MOUNT_INFO=$(mount)
echo "<PRE>$MOUNT_INFO</PRE>" > index.html
cp index.html /usr/share/nginx/html

\log "END" "This is the end"