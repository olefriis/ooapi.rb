require File.dirname(__FILE__) + '/../../lib/certificates/poces_certificate'

describe PocesCertificate do
  before do
    @poces = PocesCertificate.read(File.dirname(__FILE__) + '/../resources/openlogon_pocesII.raw')
  end
  
  it 'knows its PID' do
    @poces.pid.should == '9208-2002-2-11246611991057'
  end
end