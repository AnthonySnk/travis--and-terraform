#!/bin/bash

set -e
echo "Executing Terraform Apply on merged code"
terraform init $tf_init_cli_options
terraform apply $tf_apply_cli_options