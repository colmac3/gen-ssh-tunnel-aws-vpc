require "erb"
class CreatePublicConfig
	attr_accessor :instance_id, :public_ip_address, :pem_for_instance, :login_user_name, :template

  def initialize(instance_id=nil, public_ip_address=nil, pem_for_instance=nil, login_user_name=nil)
    @instance_id=instance_id
    @public_ip_address=public_ip_address
    @pem_for_instance=pem_for_instance
    @login_user_name=login_user_name
    @template = File.read('./instances_public.erb')
  end

  def render
    jump_config = ERB.new(@template).result( binding )
    File.open('config', 'a') { |f| f.write(jump_config) } 
  end
end
