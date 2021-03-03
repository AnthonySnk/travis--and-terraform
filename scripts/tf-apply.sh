#!/bin/bash

set -e
echo "Executing Terraform Apply on merged code"
cd $workspace
terraform init $tf_init_cli_options
terraform plan $tf_apply_cli_options

# terraform apply $tf_apply_cli_options