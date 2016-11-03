ec2 describe-vpcs | jq '.Vpcs[].VpcId'
ec2 describe-subnets | jq -j '.Subnets[] | .SubnetId, " ", .AvailabilityZone, "\n"'

ec2 create-security-group --group-name whitelist --description "IP based whitelist security group" --vpc-id vpc-
# allows traffic to ssh port from my IPs
ec2 authorize-security-group-ingress --group-id sg- --protocol tcp --port 22 --cidr 136.32.176.0/24
# allows traffic from THIS sg
ec2 authorize-security-group-ingress --group-id sg- --protocol all --source-group sg-
ec2 create-tags --resources sg- --tags Key=Name,Value=

ami: ami-a9d276c9

ec2 create-key-pair --key-name xx | jq -r '.KeyMaterial' > ~/.ssh/xx.pem

ec2 run-instances --associate-public-ip-address --image-id ami-a9d276c9 --count 1 --key-name xx --security-group-ids sg- --instance-type t2.micro --subnet-id subnet-

ec2 describe-instances | jq -j '.Reservations[].Instances[] | .PublicIpAddress, " ", .PublicDnsName, "\n"'
