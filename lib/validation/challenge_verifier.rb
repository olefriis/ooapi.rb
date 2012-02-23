class ChallengeVerifier
  def self.verify_challenge(signature, challenge)
    signature_challenge = signature.signature_properties['challenge']
    if signature_challenge == nil || signature_challenge.value == nil || signature_challenge.value != challenge
        raise Exception, "Challenge does not match expected value or expected value is nil, expected=#{challenge}, actual=#{if signature_challenge == nil; 'nil'; else signature_challenge.value; end}"
    end
  end
end