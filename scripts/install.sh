#!/bin/bash
set -e
source ./scripts/functions_file.sh

echo "DOWNLOADING TERRAFORM"
wget https://releases.hashicorp.com/terraform/"$tf_version"/terraform_"$tf_version"_linux_amd64.zip
unzip terraform_"$tf_version"_linux_amd64.zip
sudo mv terraform /usr/local/bin/
rm terraform_"$tf_version"_linux_amd64.zip

echo "DOWNLOADING cliv2 AWS"
wget "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
unzip awscli-exe-linux-x86_64.zip
sudo ./aws/install
versionAWScli=$(aws --version)
rm awscli-exe-linux-x86_64.zip
echo "AWS CLI VERSION: $versionAWScli"

echo "CALLING FUNCTION FILE"
get_inf
# DEVELOPER
# - instalar terraform con version 0.13.6
# - pasar el file de claves