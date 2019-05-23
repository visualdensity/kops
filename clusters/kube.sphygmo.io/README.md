# Private cluster

## 1. Pre-requisites

To start, you will require the following:

 * [AWS credential access](https://github.com/kubernetes/kops/blob/master/docs/aws.md) for kops and terraform
 * aws-cli, terraform and kops installed

## First, setup your environment variables
Edit the `env-vars` file and ensure your `AWS_PROFILE` is correct. Then run the
following:

    source ./env-vars

You should see the following if you run the `env` command in the command line:

    KOPS_STATE_STORE=s3://vd-kops-state-store/kops
    KOPS_NAME=kube.sphygmo.io
    KOPS_BUCKET=vd-kops-state-store
    AWS_PROFILE=vd


## To Create new Cluster

### 1. Use kops to create the cluster registry

    kops create -f cluster.yaml

### 2. Create secret (mandatory)

    kops create secret --name $KOPS_NAME sshpublickey admin -i ~/.ssh/id_rsa.pub


### 3. Update cluster and generate terraform config

    kops update cluster --name $KOPS_NAME --target terraform --out output/terraform

### 4. Switch to use terraform plan

    cp ./.terraform/backend.tf ./output/terraform/
    terraform init -backend-config="key=terraform/${KOPS_NAME}/terraform.tfstate" -backend-config="bucket=${KOPS_BUCKET}" output/terraform/
    terraform plan -out output/terraform/create_plan output/terraform

### 5. Apply the plan 
    
    terraform apply output/terraform/create_plan


## To destroy

### 1. Generate a destroy plan

    terraform plan -destroy -out output/terraform/destroy_plan output/terraform


### 2. Apply the destroy plan

    terraform apply output/terraform/destroy_plan 

### 3. Clean up kops registry

    kops delete cluster --unregister --name $KOPS_NAME --yes
