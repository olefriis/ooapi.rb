require File.dirname(__FILE__) + '/../../lib/certificates/moces_certificate'

describe MocesCertificate do
  before do
    @moces = MocesCertificate.read(File.dirname(__FILE__) + '/../resources/test_moces_ok.raw')
  end
  
  it 'knows its CVR' do
    @moces.cvr.should == '17202030'
  end
  
  it 'knows its RID' do
    @moces.rid.should == '1122334455'
  end
end