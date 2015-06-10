#!/bin/bash

# This script assumes you are running your instance in an ASG with an ELB healthcheck.
# It removes the instance from it's ELB and prevents shutdown, isolating the instance from requests.
 
# You might want to do this to perform maintainance on an instance or to remove an instance from load.

INSTANCE_ID=$1
LOAD_BALANCER_ID=$2

aws ec2 modify-instance-attribute --instance-id $INSTANCE_ID --disable-api-termination --profile media-service
aws elb deregister-instances-from-load-balancer --load-balancer-name $LOAD_BALANCER_ID --instances $INSTANCE_ID 
