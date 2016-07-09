require_relative 'aws_instance'
require 'json'
class Vpc
    attr_accessor :instances, :instances_json 

    def initialize(vpc)
      @instances=[]  
      #@instances_json=JSON.parse(`aws ec2 describe-instances --filters Name=vpc-id,Values=#{vpc}  --query 'Reservations[*].Instances[*].[InstanceId, KeyName, PublicIpAddress, NetworkInterfaces[0].PrivateIpAddress, Tags[?contains(Key, \`Name\`) == \`true\`], State.Name]' --output json --profile openspan`);    
      @instances_json=JSON.parse(`aws ec2 describe-instances --filters Name=vpc-id,Values=#{vpc}  --query 'Reservations[*].Instances[*].[InstanceId, KeyName, PublicIpAddress, NetworkInterfaces[0].PrivateIpAddress, Tags[?Key==\`Name\`], State.Name]' --output json --profile openspan`);    
    end  

    def get_instances
      @instances_json.each do |i| 
        @instances << AwsInstance.new(i[0][0], i[0][1], i[0][2], i[0][3], i[0][4][0]["Value"], i[0][5])
      end
    end
end
