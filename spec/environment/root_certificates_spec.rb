require File.dirname(__FILE__) + '/../../lib/environment/root_certificates'

describe RootCertificates do
  it 'can lookup root certificates' do
    # FIXME: Update when the rest of the certificates shows up.
    subject_dn_for_ca(OcesEnvironments.OCESI_DANID_ENV_PROD).should == "CN=TDC OCES CA, O=TDC, C=DK"
    subject_dn_for_ca(OcesEnvironments.OCESI_DANID_ENV_SYSTEMTEST).should == "CN=TDC OCES Systemtest CA II, O=TDC, C=DK"
    #assertEquals("", getSubjectDnForCa(Environment.OCESI_DANID_ENV_DEVELOPMENT));
    subject_dn_for_ca(OcesEnvironments.OCESII_DANID_ENV_PREPROD).should == "CN=TRUST2408 Systemtest VII Primary CA, O=TRUST2408, C=DK"
    subject_dn_for_ca(OcesEnvironments.OCESII_DANID_ENV_PROD).should == "CN=TRUST2408 OCES Primary CA, O=TRUST2408, C=DK"
    subject_dn_for_ca(OcesEnvironments.OCESII_DANID_ENV_EXTERNALTEST).should == "CN=TRUST2408 Systemtest IV Primary CA, O=TRUST2408, C=DK"
    subject_dn_for_ca(OcesEnvironments.OCESII_DANID_ENV_INTERNALTEST).should == "CN=DanID OCES Internal-Test Primary CA, O=DanID, C=DK"
    subject_dn_for_ca(OcesEnvironments.OCESII_DANID_ENV_IGTEST).should == "CN=TRUST2408 Systemtest IX Primary CA, O=TRUST2408, C=DK"
    subject_dn_for_ca(OcesEnvironments.OCESII_DANID_ENV_OPERATIONSTEST).should == "CN=DanID OCES Operations-Test Primary CA, O=DanID, C=DK"
    subject_dn_for_ca(OcesEnvironments.OCESII_DANID_ENV_DEVELOPMENT).should == "CN=DanID OCES Development Primary CA, O=DanID, C=DK"
    subject_dn_for_ca(OcesEnvironments.OCESII_DANID_ENV_DEVELOPMENTTEST).should == "CN=TRUST2408 Systemtest III Primary CA, O=TRUST2408, C=DK"
    subject_dn_for_ca(OcesEnvironments.CAMPUSI_DANID_ENV_PROD).should == "OU=TDC Internet Class II CA, O=TDC Internet, C=DK"
  end
  
  it 'cannot lookup certificate for nil' do
    lambda { RootCertificates.lookup_certificate(nil) }.should raise_error
  end

  def subject_dn_for_ca(environment)
    subject_dn(RootCertificates.lookup_certificate(environment))
  end
  
  def subject_dn(certificate)
    certificate.subject.to_a.reverse.map{|name| "#{name[0]}=#{name[1]}"}.join(', ')
  end
end