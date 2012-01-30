require File.dirname(__FILE__) + '/../lib/logon_handler'

describe LogonHandler do
  pending 'handles MOCES-3 logon' do
    # TODO: Weird test name. What's MOCES-3?!?
  end
  
  pending 'handles POCES-II logon', 'TODO'
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