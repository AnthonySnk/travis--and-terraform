#!/bin/bash
set -e

get_inf(){
    echo "DOWNLOADING VARIABLES"
    aws s3 cp s3://"$bucketName"/"$environment"/terraform.tfvars .
    
    if [ $environment -eq "dev" ]; then
        mv ./terraform.tfvars ./development
    elif [ $environment -eq "prod" ]
    then
        mv ./terraform.tfvars ./production
    fi
}