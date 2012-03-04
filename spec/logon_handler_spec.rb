require File.dirname(__FILE__) + '/../lib/logon_handler'
require File.dirname(__FILE__) + '/../lib/environment/oces_environments'

describe LogonHandler do
  before do
    OcesEnvironments.reset_for_testing
  end
  
  it 'handles MOCES-3 logon' do # Weird test name. What's MOCES-3?!?
    # TODO: Remove when signature properties are implemented
    SignatureProperties.current_challenge('mychallenge')
    
    OcesEnvironments.environments = [:oces_i_danid_systemtest]
    xml_dsig = File.read(File.dirname(__FILE__) + '/resources/xmldsig/openlogon_moces3.xml')

    LogonHandler.validate_and_extract_certificate_and_status(xml_dsig, 'mychallenge', nil)
  end
  
  it 'handles POCES-II logon' do
    # TODO: Remove when signature properties are implemented
    SignatureProperties.current_challenge('1891710781545552145')

    OcesEnvironments.environments = [:oces_ii_danid_preprod]
    xml_dsig = File.read(File.dirname(__FILE__) + '/resources/xmldsig/openlogon_pocesII.xml')

    LogonHandler.validate_and_extract_certificate_and_status(xml_dsig, '1891710781545552145', 'www.nemid.nu')
  end
  
  #it 'fails for wrong environment'
  #it 'fails for wrong request issuer for POCES-II logon'
  #it 'fails if logon handler gets sign signature'
  #it 'fails with wrong challenge'
  #it 'fails with no challenge'
  #it 'fails on error APP001'
  #it 'fails on error APP002'
  #it 'fails on error APP003'
  #it 'fails on error APP004'
  #it 'fails on error APP005'
  #it 'fails on error SRV001'
  #it 'fails on error SRV002'
  #it 'fails on error SRV003'
  #it 'fails on error SRV004'
  # TODO: ...and lots of other fails... specs
  
  #it 'can get subject DN with Danish letters'
  #it 'can log in with Campus certificate'
end