- [GITOPS WITH TRAVIS AND TERRAFORM](#gitops-with-travis-and-terraform)
- [Files map](#files-map)
- [Review content](#review-content)
- [Env variables](#env-variables)
- [branches by default](#branches-by-default)
- [Use Cases](#use-cases)
  - [Dev branch](#dev-branch)
  - [Prod, master  branch](#prod-master--branch)
- [Script definitions](#script-definitions)

# GITOPS WITH TRAVIS AND TERRAFORM

First of all that we have to know that this project is oriented to deploy automatically infrastructure with Terraform and AWS. 
We need an account on Travis, AWS acces_key, access_secret_key, and git repo.

# Files map

```note
|-- root
    |-- development
        |-- main.tf
    |-- producction
        |-- main.tf
    |-- scripts
        |-- functions_file.sh
        |-- install.sh
        |-- tf-apply.sh
        |-- tf-plan.sh
    |-- .travis.yaml
```

# Review content

- The folder `development` contains the infra that we will test.
- The folder `production` contains infra that we will to test for production
- The folder `scripts` contains all script to exec the action to create infra with Travis and the next space we will talk about it.
- The file `.travis.yaml` is the main file that we need to have a deploy automallity.
  

# Env variables

In this part of the file `.travis.yaml` we set up the environment variables.

| variable                  | use                                                                      |
| ------------------------- | ------------------------------------------------------------------------ |
| bucketName                | this variables is where you have the file terraform.tfvar                |
| NOTE BUCKER               | `s3://"$bucketName"/"$environment"/terraform.tfvars`                     |
| environment               | setup the environment values by default                                  |
| folder_dev                | this the folder where we have to save the file for the dev branch        |
| folder_prod               | this the folder where we have to save the file for the production branch |
| onepasstool               | In case we want to use one password to get a password we have to define  |
| tf_version                | Terraform version that the script will use to deploy                     |
| tf_init_cli_options       | It's not necessary to edit                                               |
| tf_validation_cli_options | It's not necessary to edit                                               |
| tf_plan_cli_options       | It's not necessary to edit                                               |
| tf_apply_cli_options      | It's not necessary to edit                                               |
| tf_var_file               | The path on the file that we download from bucket                        |

```yaml
    env:
        - bucketName="my-bucket-test-12" environment="prod" folder_dev="./development" folder_prod="./production" onepasstool=1.8.0 tf_version=0.13.0 tf_init_cli_options="-input=false" tf_validation_cli_options="" tf_plan_cli_options="-lock=false -input=false" tf_apply_cli_options="-auto-approve -input=false" tf_var_file="./terraform.tfvars"
```

# branches by default

This is the name of branches by default

```yaml
branches:
  only:
    - master
    - dev
    - prod
```


# Use Cases

## Dev branch

- For example, if you make a pull request to branch `dev` .travis.yaml will active the deploy in the branch dev.
We can see the condition when it says when a pull request is committed to `dev` branch, the script has to set a variable `environment` this is for us to know in what environment We will work.
After that we script has to exec the script [tf-plan.sh](/scripts/tf-plan.sh), this is script just check if the infra is correctly built.

```yaml
jobs:
    include:
        - stage: terraform plan dev
        if: branch = dev and type IN (pull_request)
        script:
            - environment=dev
            - cd $folder_dev
            - bash ../scripts/tf-plan.sh
 ```

## Prod, master  branch

- With those branches, the script has to way to handle, first when the user made a pull request is similar to when you made a pull request on dev.
  
```yaml
    - stage: terraform plan prod
        if: branch IN (prod,master) and type IN (pull_request)
        script:
        - environment=$branch_PROD
        - cd $folder_prod
        - bash ../scripts/tf-plan.sh
```

- Second scenario is when you make a push or merge, .travis.yaml will detect that you are secure the infra that you would like to deploy, in this case, the script will run another file, to use terraform to apply and build the infrastructure.

```yaml
 - stage: terraform apply
      if: (branch IN (dev,prod,master)) and type IN (push,merge)
      script:
        - environment=$branch_PROD
        - cd $folder_prod
        - bash ../scripts/tf-apply.sh
```
# Script definitions

We have four files for scripts.
| script name       | function                                                                                                |
| ----------------- | ------------------------------------------------------------------------------------------------------- |
| functions_file.sh | At the moment this file has the function to get variables file for terraforming                         |
| install.sh        | This file has the content what the system needs to have to build the infrastructure (terraform,aws CLI) |
| tf-apply          | This file has the ability to deploy de infrastructure on aws account                                    |
| tf-plan           | This file has the task to testing the infrastructure before a merge or push to master branch            |