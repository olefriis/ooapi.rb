require 'openssl'

describe :PocesCertificate do
  PocesCertificate = Struct.new(:pid)

  def read_certificate_file(file_name)
    certificate = OpenSSL::X509::Certificate.new(File.read(file_name))
    pid = nil
    certificate.subject.to_a.each do |entry|
      type, value = entry[0..1]
      if type == 'serialNumber' && value.start_with?('PID:')
        pid = value[4..-1]
        return PocesCertificate.new(pid)
      end
    end
  end
  
  before do
    @poces = read_certificate_file(File.dirname(__FILE__) + '/resources/openlogon_pocesII.raw')
  end
  
  it 'knows its PID' do
    @poces.pid.should == '9208-2002-2-11246611991057'
  end
end