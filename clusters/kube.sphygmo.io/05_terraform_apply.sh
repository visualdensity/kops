#!/bin/bash

set -eo pipefail

echo "This is going to create $KOPS_NAME cluster. Are you absolutely sure? (y/n)"
read yn

if [ "$yn" == "y" ];
then
    echo "Applying the plan..."
    terraform apply output/terraform/create_plan
fi


echo "You can use this to check instances if you don't have a lot of instances :)"
echo
echo "  aws ec2 describe-instances | jq -r '.Reservations[].Instances[] | { PrivateIP: .PrivateIpAddress, Type: .SecurityGroups[0].GroupName, State: .State.Name }'"
echo
