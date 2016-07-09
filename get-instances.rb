require 'json'
vpc='vpc-686f850c'
instances_json=JSON.parse(`aws ec2 describe-instances --filters Name=vpc-id,Values=#{vpc}  --query 'Reservations[*].Instances[*].[InstanceId, PublicIpAddress, NetworkInterfaces[0].PrivateIpAddress, Tags[?contains(Key, \`Name\`) == \`true\`], State.Name]' --output json --profile openspan`)
#instances_json=JSON.parse(`aws ec2 describe-instances --filters Name=vpc-id,Values=vpc-686f850c  --query 'Reservations[*].Instances[*].[InstanceId, PublicIpAddress, NetworkInterfaces[0].PrivateIpAddress, Tags[?contains(Key, \`Name\`) == \`true\`], State.Name]' --output json --profile openspan`)

instance=instances_json[0][0][0]
public_ip=instance=instances_json[0][0][1]
private_ip=instances_json[0][0][2]
instance_name=instances_json[0][0][3][0]["Value"]
instance_state=instances_json[0][0][4]


