# Quick scripted steps to launch an EC2 instance with whitelisted IPs

Start with these to see the VPCs and subnets configured. The IDs will be needed later.
```
aws ec2 describe-vpcs | jq '.Vpcs[].VpcId'
aws ec2 describe-subnets | jq -j '.Subnets[] | .SubnetId, " ", .AvailabilityZone, "\n"'
```

First, create the security group that will whitelist IPs you want to use. Always tag it something.
```
aws ec2 create-security-group --group-name whitelist --description "IP based whitelist security group" --vpc-id vpc-some-id
aws ec2 create-tags --resources sg-some-id --tags Key=Name,Value=Something
```

Allows traffic to ssh port from my IPs.
```
aws ec2 authorize-security-group-ingress --group-id sg-some-id --protocol tcp --port 22 --cidr 192.168.1.0/24
```

Allows traffic from THIS security group. This will allow multiple instances in this security group to talk.
```
aws ec2 authorize-security-group-ingress --group-id sg-some-id --protocol all --source-group sg-some-id
```

Create a key pair to use and save the private key in your .ssh directory. You will need to change the permission to 600 after this.
```
aws ec2 create-key-pair --key-name xx | jq -r '.KeyMaterial' > ~/.ssh/xx.pem
```

Pick a AMI to use. This is a Ubuntu version. ami: ami-a9d276c9.

Now, you can run the instance.
```
aws ec2 run-instances --associate-public-ip-address --image-id ami-a9d276c9 --count 1 --key-name xx --security-group-ids sg-some-id --instance-type t2.micro --subnet-id subnet-some-id
aws ec2 create-tags --resources reservation-some-id --tags Key=Name,Value=Something
```

This will show you the public IP associated with the instances
```
aws ec2 describe-instances | jq -j '.Reservations[].Instances[] | .PublicIpAddress, " ", .PublicDnsName, "\n"'
```

