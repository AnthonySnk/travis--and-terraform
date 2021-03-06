#!/bin/bash

set -e
source scripts/functions_file.sh

echo "Downloading Terraform"
wget https://releases.hashicorp.com/terraform/"$tf_version"/terraform_"$tf_version"_linux_amd64.zip
unzip terraform_"$tf_version"_linux_amd64.zip
sudo mv terraform /usr/local/bin/
rm terraform_"$tf_version"_linux_amd64.zip

echo "Downloading 1password command line tools"
echo "Linux installer"
wget https://cache.agilebits.com/dist/1P/op/pkg/v"$onepasstool"/op_linux_amd64_v"$onepasstool".zip
unzip op_linux_amd64_v"$onepasstool".zip
sudo mv op /usr/local/bin/
rm op_linux_amd64_v"$onepasstool".zip
op --version

echo "Downloading cliv2 aws"
wget "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
unzip awscli-exe-linux-x86_64.zip
sudo ./aws/install
versionAWScli=$(aws --version)
rm awscli-exe-linux-x86_64.zip
echo "Currenly version aws cli is: $versionAWScli"


echo "Exec function file"
get_inf
# DEVELOPER
# - instalar terraform con version 0.13.6
# - pasar el file de claves