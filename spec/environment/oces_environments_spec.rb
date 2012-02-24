require File.dirname(__FILE__) + '/../../lib/environment/oces_environments'

describe OcesEnvironments do
  before do
    OcesEnvironments.reset_for_testing
  end

  it 'has OCES-II Production as default environment' do
    OcesEnvironments.trusted_environments.length.should == 1
    OcesEnvironments.trusted_environments[0].should == OcesEnvironments.OCESII_DANID_ENV_PROD
  end

  it 'can set environment' do
    OcesEnvironments.environments = [OcesEnvironments.OCESI_DANID_ENV_SYSTEMTEST, OcesEnvironments.OCESII_DANID_ENV_INTERNALTEST]
    OcesEnvironments.trusted_environments.length.should == 2
    OcesEnvironments.trusted_environments.should == [OcesEnvironments.OCESI_DANID_ENV_SYSTEMTEST, OcesEnvironments.OCESII_DANID_ENV_INTERNALTEST]
  end

  it 'cannot set environment twice' do
    lambda {
      OcesEnvironments.environments = OcesEnvironments.OCESII_DANID_ENV_INTERNALTEST
      OcesEnvironments.environments = OcesEnvironments.OCESII_DANID_ENV_INTERNALTEST
    }.should raise_error
  end

  it 'cannot mix OCES-I test and OCES-II production environments' do
    lambda {
      OcesEnvironments.environments = [OcesEnvironments.OCESI_DANID_ENV_PROD, OcesEnvironments.OCESII_DANID_ENV_INTERNALTEST]
    }.should raise_error
  end

  it 'cannot mix OCES-II test and OCES-II production environments' do
    lambda {
      OcesEnvironments.environments = [OcesEnvironments.OCESII_DANID_ENV_PROD, OcesEnvironments.OCESII_DANID_ENV_INTERNALTEST]
    }.should raise_error
  end

  it 'can set dual production environments' do
    OcesEnvironments.environments = [OcesEnvironments.OCESI_DANID_ENV_PROD, OcesEnvironments.OCESII_DANID_ENV_PROD]
    OcesEnvironments.trusted_environments.length.should == 2
    OcesEnvironments.trusted_environments.should == [OcesEnvironments.OCESI_DANID_ENV_PROD, OcesEnvironments.OCESII_DANID_ENV_PROD]
  end
end