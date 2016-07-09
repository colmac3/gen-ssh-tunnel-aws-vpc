# gen-ssh-tunnel-aws-vpc
Generates an ssh config file of instance id's and a tunnel using a jumpbox into the VPC. ssh i-123456 is all that is needed
to ssh to an instance.

First, you ruby purest out there, dont send me any email.  

This project is very raw and has bugs. I never intended for anyone but myself to use it. So if you happen to find this project, expect bugs. It is a work in progress. Basically, run-get-create-tunnels.rb starts the process. 
the vpc-id is currenty hard coded into this file. change it to your vpc and the aws cli describe instances is called
and the ssh config file is created from that. this program explects a jumpbox with a tag, the key-Name and the Value needs to
contain the string "Jump Box"
