#!/bin/bash
echo [$@]
echo "command=xdg-open \"https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#Instances:search=$@;sort=Name\""
echo "icon="
echo "subtext=Find EC2 Instances $@"
