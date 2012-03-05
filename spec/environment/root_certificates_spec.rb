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
  
  it 'can lookup certificate for OCES-II Production' do
    RootCertificates.lookup_certificate(OcesEnvironments.OCESII_DANID_ENV_PROD)
  end
  
  pending 'can get environment on CA' do
    OcesEnvironments.reset_for_testing
    OcesEnvironments.environments = OcesEnvironments.OCESI_DANID_ENV_SYSTEMTEST
    xml_dsig = FileReader.ReadFile("/xmldsig/openlogon.xml");
    certificate_chain = XmlDsigParser.certificate_chain(xml_dsig)
    oces_certificate = OcesCertificateFactory.generate(certificate_chain)
    RootCertificates.environment(oces_certificate.signing_ca).should == OcesEnvironments.OCESI_DANID_ENV_SYSTEMTEST
  end
  
  it 'cannot get environment on nil' do
    lambda { RootCertificates.environment(nil) }.should raise_error
  end
  
  it 'can lookup certificate by subject DN' do
    certificate = RootCertificates.lookup_certificate_by_subject_dn("CN=TRUST2408 OCES Primary CA, O=TRUST2408, C=DK")
    subject_dn(certificate).should == "CN=TRUST2408 OCES Primary CA, O=TRUST2408, C=DK"
  end
  
  pending 'can lookup certificate by subject DN irrespective of case' do
    certificate = RootCertificates.lookup_certificate_by_subject_dn("CN=TRUST2408 OCES Primary CA, O=TRUST2408,  c = DK")
    subject_dn(certificate).should == "CN=TRUST2408 OCES Primary CA, O=TRUST2408, C=DK"
  end
  
  it 'cannot lookup certificate by non-existent subject DN' do
    lambda { RootCertificates.lookup_certificate_by_subject_dn("CN=non-existent, O=TDC, C=DK") }.should raise_error
  end

  def subject_dn_for_ca(environment)
    subject_dn(RootCertificates.lookup_certificate(environment))
  end
  
  def subject_dn(certificate)
    certificate.subject.to_a.reverse.map{|name| "#{name[0]}=#{name[1]}"}.join(', ')
  end
end