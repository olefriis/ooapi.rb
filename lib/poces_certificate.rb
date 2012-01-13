require 'openssl'

class PocesCertificate
  def self.read(file_name)
    certificate = OpenSSL::X509::Certificate.new(File.read(file_name))
    certificate.subject.to_a.each do |entry|
      type, value = entry[0..1]
      if type == 'serialNumber' && value.start_with?('PID:')
        pid = value[4..-1]
        return PocesCertificate.new(pid)
      end
    end
  end
  
  attr_reader :pid
  
  def initialize(pid)
    @pid = pid
  end
end