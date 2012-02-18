# TODO: This is just a stub for now
require 'signatures/openlogon_signature'

class OpensignSignatureFactory
  def self.generate_opensign_signature(login_data)
    OpenlogonSignature.new
  end
end