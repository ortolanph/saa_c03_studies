#!/usr/bin/env bash

BASE_URL="http://169.254.169.254/latest"
TOKEN=`curl -s -X PUT "$BASE_URL/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`

function ami_info() {
  AMI_ID=`curl -s -H "X-aws-ec2-metadata-token: $TOKEN" -v $BASE_URL/meta-data/ami-id`
  AMI_LAUNCH_INDEX=`curl -s -H "X-aws-ec2-metadata-token: $TOKEN" -v $BASE_URL/meta-data/ami-launch-index`
  AMI_MANIFEST_PATH=`curl -s -H "X-aws-ec2-metadata-token: $TOKEN" -v $BASE_URL/meta-data/ami-manifest-path`

  echo "AMI INFO"
  echo ""
  echo "AMI ID.............: $AMI_ID"
  echo "AMI LAUNCH INDEX...: $AMI_LAUNCH_INDEX"
  echo "AMI MANIFEST PATH..: $AMI_MANIFEST_PATH"
  echo ""
}

function instance_info() {
  INSTANCE_ACTION=`curl -s -H "X-aws-ec2-metadata-token: $TOKEN" -v $BASE_URL/meta-data/instance-action`
  INSTANCE_ID=`curl -s -H "X-aws-ec2-metadata-token: $TOKEN" -v $BASE_URL/meta-data/instance-id`
  INSTANCE_TYPE=`curl -s -H "X-aws-ec2-metadata-token: $TOKEN" -v $BASE_URL/meta-data/instance-type`
  PROFILE=`curl -s -H "X-aws-ec2-metadata-token: $TOKEN" -v $BASE_URL/meta-data/profile`
  RESERVATION_ID=`curl -s -H "X-aws-ec2-metadata-token: $TOKEN" -v $BASE_URL/meta-data/reservation-id`

  echo "INSTANCE INFO"
  echo ""
  echo "INSTANCE ID........: $INSTANCE_ID"
  echo "INSTANCE ACTIOM....: $INSTANCE_ACTION"
  echo "INSTANCE TYPE......: $INSTANCE_TYPE"
  echo "PROFILE............: $PROFILE"
  echo "RESERVATION ID.....: $RESERVATION_ID"
  echo ""
}

function network_info() {
  HOSTNAME=`curl -s -H "X-aws-ec2-metadata-token: $TOKEN" -v $BASE_URL/meta-data/hostname`
  PUBLIC_HOSTNAME=`curl -s -H "X-aws-ec2-metadata-token: $TOKEN" -v $BASE_URL/meta-data/public-hostname`
  PUBLIC_IPV4=`curl -s -H "X-aws-ec2-metadata-token: $TOKEN" -v $BASE_URL/meta-data/public-ipv4`
  LOCAL_HOSTNAME=`curl -s -H "X-aws-ec2-metadata-token: $TOKEN" -v $BASE_URL/meta-data/local-hostname`
  LOCAL_IPV4=`curl -s -H "X-aws-ec2-metadata-token: $TOKEN" -v $BASE_URL/meta-data/local-ipv4`
  MAC_ADDRESS=`curl -s -H "X-aws-ec2-metadata-token: $TOKEN" -v $BASE_URL/meta-data/mac`
  SECURITY_GROUPS=`curl -s -H "X-aws-ec2-metadata-token: $TOKEN" -v $BASE_URL/meta-data/security-groups`

  echo "NETWORK INFO"
  echo ""
  echo "HOSTNAME...........: $HOSTNAME"
  echo "PUBLIC HOSTNAME....: $PUBLIC_HOSTNAME"
  echo "PUBLIC IPV4........: $PUBLIC_IPV4"
  echo "LOCAL HOSTNAME.....: $LOCAL_HOSTNAME"
  echo "LOCAL IPV4.........: $LOCAL_IPV4"
  echo "MAC ADDRESS........: $MAC_ADDRESS"
  echo "SECURITY GROUPS....: $SECURITY_GROUPS"
  echo ""
}

function other_info() {
  BLOCK_DEVICE_MAPPING=`curl -s -H "X-aws-ec2-metadata-token: $TOKEN" -v $BASE_URL/meta-data/block-device-mapping/`
  METRICS=`curl -s -H "X-aws-ec2-metadata-token: $TOKEN" -v $BASE_URL/meta-data/metrics/`
  NETWORK=`curl -s -H "X-aws-ec2-metadata-token: $TOKEN" -v $BASE_URL/meta-data/network/`
  PLACEMENT=`curl -s -H "X-aws-ec2-metadata-token: $TOKEN" -v $BASE_URL/meta-data/placement/`
  PUBLIC_KEYS=`curl -s -H "X-aws-ec2-metadata-token: $TOKEN" -v $BASE_URL/meta-data/public-keys/`

  echo "OTHER INFORMATION"
  echo ""
  echo "Block Device Mapping"
  echo "----- ------ -------"
  echo $BLOCK_DEVICE_MAPPING
  echo ""
  echo "Metrics"
  echo "-------"
  echo $METRICS
  echo ""
  echo "Additional Network Informationm"
  echo "---------- ------- ------------"
  echo $NETWORK
  echo ""
  echo "Placement"
  echo "---------"
  echo $PLACEMENT
  echo ""
  echo "Public Keys"
  echo "-----------"
  echo "$PUBLIC_KEYS"
  echo ""
}

function mounted_volumes() {
  mount | grep dev
}

instance_info
ami_info
network_info
other_info
mounted_volumes

echo "end_of_script"
