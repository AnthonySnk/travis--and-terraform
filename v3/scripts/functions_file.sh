#!/bin/bash
set -e

get_inf(){
    aws s3 cp s3://one-password-bucket-travis/export-data.sh .
    aws s3 cp s3://one-password-bucket-travis/terraform.tfvars .
    bash ./export-data.sh
    rm export-data.sh
    echo "Exported data..."
    env
}

# op_signin(){
#     op signin ${LOGIN_URL_ONE} ${EMAIL_LOGIN} ${MASTER_KEY_BALL}
# }

# op_signout(){
#     unset LOGIN_URL_ONE
#     unset EMAIL_LOGIN
#     unset MASTER_KEY_BALL
# }

# get_values_tf_dev(){
# }

# get_values_tf_prod(){
# }