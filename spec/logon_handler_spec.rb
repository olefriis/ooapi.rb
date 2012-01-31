require File.dirname(__FILE__) + '/../lib/logon_handler'
require File.dirname(__FILE__) + '/../lib/oces_environments'

describe LogonHandler do
  it 'handles MOCES-3 logon' do # Weird test name. What's MOCES-3?!?
    OcesEnvironments.environments = [:oces_i_danid_systemtest]
    xml_dsig = File.read(File.dirname(__FILE__) + '/resources/xmldsig/openlogon_moces3.xml')

    LogonHandler.validate_and_extract_certificate_and_status(xml_dsig, 'mychallenge', nil)
  end
  
  it 'handles POCES-II logon' do
    OcesEnvironments.environments = [:oces_ii_danid_preprod]
    xml_dsig = File.read(File.dirname(__FILE__) + '/resources/xmldsig/openlogon_pocesII.xml')

    LogonHandler.validate_and_extract_certificate_and_status(xml_dsig, '1891710781545552145', 'www.nemid.nu')
  end
  
  pending 'fails for wrong environment'
  pending 'fails for wrong request issuer for POCES-II logon'
  pending 'fails if logon handler gets sign signature'
  pending 'fails with wrong challenge'
  pending 'fails with no challenge'
  pending 'fails on error APP001'
  pending 'fails on error APP002'
  pending 'fails on error APP003'
  pending 'fails on error APP004'
  pending 'fails on error APP005'
  pending 'fails on error SRV001'
  pending 'fails on error SRV002'
  pending 'fails on error SRV003'
  pending 'fails on error SRV004'
  # TODO: ...and lots of other fails... specs
  
  pending 'can get subject DN with Danish letters'
  pending 'can log in with Campus certificate'
end