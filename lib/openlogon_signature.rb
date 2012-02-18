# TODO: This is just a stub for now
require 'oces_certificate'
require 'signature_properties'

class OpenlogonSignature
  def verify
    true
  end
  
  def signing_certificate
    OcesCertificate.new
  end
  
  def signature_properties
    SignatureProperties.new
  end
end