#!/bin/bash

set -e
echo "Executing Terraform Apply on merged code"
terraform init $tf_init_cli_options
terraform validate $tf_validation_cli_options
terraform plan $tf_plan_cli_options
# terraform apply $tf_apply_cli_options