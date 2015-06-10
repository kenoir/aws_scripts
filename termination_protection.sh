#!/bin/bash
 
ASG=$1
DISABLE=$2
 
ACTION="--disable-api-termination"
INSTANCES=`aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names $ASG --profile media-service | jq '.AutoScalingGroups[0].Instances[].InstanceId' | xargs`
 
if [ "$2" = "disable" ]; then
    ACTION="--no-disable-api-termination"
fi
 
for i in $INSTANCES; do
    echo "Running 'aws ec2 modify-instance-attribute --instance-id $i $ACTION --profile media-service'"
 
    aws ec2 modify-instance-attribute --instance-id $i $ACTION --profile media-service
done
