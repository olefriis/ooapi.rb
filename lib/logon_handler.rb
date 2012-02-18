require 'validation/error_code_checker'
require 'signatures/opensign_signature_factory'
require 'validation/challenge_verifier'
require 'environment/service_provider_setup'
require 'certificates/certificate_and_status'

class LogonHandler
  def self.validate_and_extract_certificate_and_status(login_data, challenge, logonto)
    signature = create_openlogon_signature(login_data)
    validate_signature_parameters(challenge, logonto, signature)

    if signature.verify
      certificate = signature.signing_certificate
      status = certificate.validity_status

      if status == CERTIFICATE_STATUS_VALID && ServiceProviderSetup.current_checker.is_revoked?(certificate)
        status = CERTIFICATE_STATUS_REVOKED
      end

      return CertificateAndStatus.new(certificate, status)
    end

    raise Exception, "the signature of the login data is invalid. Data is #{login_data}"
  end
  
  def self.create_openlogon_signature(login_data)
    if ErrorCodeChecker.is_error?(login_data)
      raise Exception.new(ErrorCodeChecker.extract_error(loginData))
    end
    abstract_signature = OpensignSignatureFactory.generate_opensign_signature(login_data)
    if !abstract_signature.is_a?(OpenlogonSignature)
      raise Exception, "argument of type #{abstract_signature.class} is not valid output from the logon applet"
    end
		abstract_signature
  end
  
  def self.validate_signature_parameters(challenge, logonto, signature)
    validate_challenge(challenge, signature)
    validate_logonto(signature, logonto) if logonto
  end
  
  def self.validate_challenge(challenge, signature)
    ChallengeVerifier.verify_challenge(signature, challenge)
  end
  
  def self.validate_logonto(signature, logonto)
    logonto_property = signature.signature_properties['logonto']
    request_issuer_property = signature.signature_properties['RequestIssuer']

    if logonto_property && request_issuer_property
      raise Exception, "Invalid signature logonto and RequestIssuer parameters cannot both be set"
    end

    if logonto_property.nil? && request_issuer_property.nil?
      raise Exception, "Invalid signature either logonto or RequestIssuer parameters must be set"
    end

    if logonto_property
      logonto_property_value = logonto_property.value
      if logonto_property_value != logonto
        raise Exception, "Invalid signature logonto parameter does not match expected value. Expected: #{logonto} actual: #{logonto_property_value}"
      end
    end

    if request_issuer_property
      request_issuer_value = request_issuer_property.value
      if request_issuer_value != logonto
        raise Exception, "Invalid signature RequestIssuer parameter does not match expected value. Expected: #{logonto} actual: #{requestIssuerValue}"
      end
    end
  end
end