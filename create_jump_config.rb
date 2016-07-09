require "erb"
class CreateJumpConfig
	attr_accessor :instance_id_jump, :jump_public_ip_address, :jump_box_pem, :login_user_name, :jump_template

  def initialize(instance_id_jump=nil, jump_public_ip_address=nil, jump_box_pem=nil, login_user_name=nil)
    @instance_id_jump=instance_id_jump
    @jump_public_ip_address=jump_public_ip_address
    @jump_box_pem=jump_box_pem
    @login_user_name=login_user_name
    @jump_template = File.read('./jump.erb')
  end

  def render
    jump_config = ERB.new(@jump_template).result( binding )
    File.open('config', 'a') { |f| f.write(jump_config) } 
  end
end

