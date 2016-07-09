require "erb"

class CreateSSHConfig
	attr_accessor :instance_id_jump, :instance_id_ipaddress, 
                      :jump_box_pem, :ubuntu_login_user_name, 
                      :instance_id_for_private_ip, :private_ip_address, :ssh_key_for_instance,
                      :instances_private_template, :instances_public_template, :jump_template

  def initialize(instance_id_jump=nil, instance_id_ipaddress=nil, jump_box_pem=nil, ubuntu_login_user_name=nil, instance_id_for_private_ip=nil, private_ip_address=nil, ssh_key_for_instance=nil)
    @instance_id_jump=instance_id_jump
    @instance_id_ipaddress=instance_id_ipaddress
    @jump_box_pem=jump_box_pem
    @ubuntu_login_user_name=ubuntu_login_user_name
    @instance_id_for_private_ip=instance_id_for_private_ip
    @private_ip_address=private_ip_address
    @ssh_key_for_instance=ssh_key_for_instance

    @instances_private_template = File.read('./instances_private.erb')
    @instances_public_template = File.read('./instances_public.erb')
    @jump_template = File.read('./jump.erb')
  end

  def render
    templates = [@jump_template, @instances_public_template, @instances_private_template]
    ERB.new(temp).result( binding )
  end

end


