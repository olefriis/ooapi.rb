# TODO: This is just a stub for now

CERTIFICATE_STATUS_VALID = 1
CERTIFICATE_STATUS_REVOKED = 2

class OcesCertificate
  def validity_status
    CERTIFICATE_STATUS_VALID
  end
end