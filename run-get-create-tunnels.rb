require_relative 'vpc'
require_relative 'create_jump_config'
require_relative 'create_public_config'
require_relative 'create_private_config'

instance_id_jump=nil, jump_box_pem=nil, login_user_name=nil, instance_id=nil, private_ip_address=nil, public_ip_address=nil, jump_public_ip_address=nil, pem_for_instance=nil
aws_instance_id=0 
aws_public_ip=1 
aws_private_ip=2 
aws_pem=3
aws_description=4

#vpc=Vpc.new('vpc-686f850c');
vpc=Vpc.new('vpc-686f850c')
vpc.get_instances
servers=[]
vpc.instances.each do |i|  servers << %W(#{i.instance_id} #{i.public_ip} #{i.private_ip} #{i.key_name} #{i.instance_name}) end
#jumpbox example:
#["i-3bb509e3", "52.37.50.155", "10.0.1.233", "Attila_PROD", "US Bank WFI: Jump Box 18146"]
#regular server example:
#["i-98b60a40", "54.200.78.252", "10.0.1.224", "US Bank WFI", "US Bank WFI: NAT 18147"]
#note we have to convert the key to have underscores. so, US_Bank_WFI.pem

# we must know the jump box before we can configure the tunnels
servers.each do |server|
  if server[aws_description].downcase.include?("jump")
      jump_box_pem = server[aws_pem] + ".pem"
      instance_id_jump = server[aws_instance_id]
      jump_public_ip_address = server[aws_public_ip]
      login_user_name="ubuntu"
      CreateJumpConfig.new(instance_id_jump, jump_public_ip_address, jump_box_pem, login_user_name).render
  end
end

servers.each do |server|
  if server[aws_description].downcase.include?("jump")
    next
  else
    if server[aws_pem][/\s/]    
      pem_for_instance = server[aws_pem].tr!(' ', '_') + ".pem" if server[aws_pem][/\s/]
    else
      pem_for_instance = server[aws_pem] + ".pem" 
    end

    instance_id = server[aws_instance_id]
    if ( server[aws_public_ip].nil? || server[aws_public_ip] == '' )
      private_ip_address = server[aws_private_ip]
      login_user_name = "ubuntu"
      CreatePrivateConfig.new(instance_id_jump, instance_id, private_ip_address, pem_for_instance, login_user_name).render

    else
      public_ip_address = server[aws_public_ip]
      login_user_name = server[aws_description].downcase.include?("nat") ? "ec2-user" : "ubuntu"
      login_user_name = server[aws_description].downcase.include?("openvpn") ? "openvpnas" : "ubuntu"
      CreatePublicConfig.new(instance_id, public_ip_address, pem_for_instance, login_user_name).render
    end

  end
end
