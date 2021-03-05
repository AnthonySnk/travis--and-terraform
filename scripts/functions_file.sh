#!/bin/bash
set -e

get_inf(){
    echo "DOWNLOADING VARIABLES"
    aws s3 cp s3://"$bucketName"/"$environment"/terraform.tfvars .
    mv ./terraform.tfvars ./development
}