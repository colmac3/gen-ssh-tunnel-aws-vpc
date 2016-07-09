require "erb"
class CreatePrivateConfig
	attr_accessor :instance_id_jump, :instance_id, :private_ip_address, :pem_for_instance, :login_user_name, :template

  def initialize(instance_id_jump, instance_id=nil, private_ip_address=nil, pem_for_instance=nil, login_user_name=nil)
    @instance_id=instance_id
    @instance_id_jump=instance_id_jump
    @private_ip_address=private_ip_address
    @pem_for_instance=pem_for_instance
    @login_user_name=login_user_name
    @template = File.read('./instances_private.erb')
  end

  def render
    jump_config = ERB.new(@template).result( binding )
    File.open('config', 'a') { |f| f.write(jump_config) } 
  end
end
