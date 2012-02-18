# TODO: This is just a stub for now

SignatureProperty = Struct.new(:key, :value)

class SignatureProperties
  def [](property)
    return SignatureProperty.new('logonto', 'www.nemid.nu') if property == 'logonto'
  end
end