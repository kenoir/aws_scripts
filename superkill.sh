#/bin/bash

INSTANCE_ID=$1
ASG_NAME=`aws autoscaling describe-auto-scaling-instances --instance-ids i-0da256f4 | jq -r ".AutoScalingInstances[0].AutoScalingGroupName"`

echo "Terminating $INSTANCE_ID in $ASG_NAME"
read -p "Are you sure? (y/n)" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    aws ec2 modify-instance-attribute --instance-id $INSTANCE_ID --no-disable-api-termination --profile media-service
    aws autoscaling terminate-instance-in-auto-scaling-group --instance-id $INSTANCE_ID --should-decrement-desired-capacity --profile media-service
fi
