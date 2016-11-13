#!/bin/sh
set -e
keyname=$1
aws ec2 create-key-pair --key-name "${keyname}" | jq -r '.KeyMaterial' >~/.ssh/"${keyname}".pem
chmod 600 ~/.ssh/"${keyname}".pem

