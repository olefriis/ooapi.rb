# TODO: This is just a stub for now

SignatureProperty = Struct.new(:key, :value)

class SignatureProperties
  # Temporary method to allow stubbing in logon_handler_spec
  def self.current_challenge(current_challenge)
    @@challenge = current_challenge
  end
  
  def [](property)
    return SignatureProperty.new('logonto', 'www.nemid.nu') if property == 'logonto'
    return SignatureProperty.new('challenge', @@challenge) if property == 'challenge'
  end
end