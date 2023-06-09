#!/usr/bin/env bash

echo "Now entering EC2"

HOST=`cat terraform.tfstate | jq --raw-output '.outputs.ec2_instance_public_dns.value'`
KEY_PAIR_FILE=~/saa_c03_studies.pem
USER=ec2-user

scp -i $KEY_PAIR_FILE instance_metadata.sh $USER@"$HOST":/home/$USER/instance_metadata.sh
ssh -i $KEY_PAIR_FILE $USER@"$HOST"

echo "Bye!"
