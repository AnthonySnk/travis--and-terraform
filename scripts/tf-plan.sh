#!/bin/bash

set -e
echo "Executing Terraform Plan on pull request code"
cd $workspace
terraform init $tf_init_cli_options
terraform validate $tf_validation_cli_options
terraform plan $tf_plan_cli_options