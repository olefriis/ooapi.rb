require 'openssl'

class MocesCertificate
  def self.read(file_name)
    certificate = OpenSSL::X509::Certificate.new(File.read(file_name))
    certificate.subject.to_a.each do |entry|
      type, value = entry[0..1]
      if type == 'serialNumber' && value.start_with?('CVR:') && value[12..16] == '-RID:'
        cvr, rid = value[4..11], value[17..-1]
        return MocesCertificate.new(cvr, rid)
      end
    end
  end
  
  attr_reader :cvr, :rid
  
  def initialize(cvr, rid)
    @cvr, @rid = cvr, rid
  end
end