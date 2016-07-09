class AwsInstance
  attr_accessor :instance_id, :key_name, :public_ip, :private_ip, :instance_name, :instance_state

  def initialize(instance_id, key_name, public_ip, private_ip, instance_name, instance_state)
    @instance_id=instance_id
    @key_name=key_name
    @public_ip=public_ip
    @private_ip=private_ip
    @instance_name=instance_name
    @instance_state=instance_state
  end

end
