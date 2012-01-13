require 'openssl'

describe :PocesCertificate do
  MocesCertificate = Struct.new(:cvr, :rid)

  def read_certificate_file(file_name)
    certificate = OpenSSL::X509::Certificate.new(File.read(file_name))
    cvr, rid = nil, nil
    certificate.subject.to_a.each do |entry|
      type, value = entry[0..1]
      if type == 'serialNumber' && value.start_with?('CVR:') && value[12..16] == '-RID:'
        cvr, rid = value[4..11], value[17..-1]
        return MocesCertificate.new(cvr, rid)
      end
    end
  end
  
  before do
    @poces = read_certificate_file(File.dirname(__FILE__) + '/resources/test_moces_ok.raw')
  end
  
  it 'knows its CVR' do
    @poces.cvr.should == '17202030'
  end
  
  it 'knows its RID' do
    @poces.rid.should == '1122334455'
  end
end