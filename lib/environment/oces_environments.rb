class OcesEnvironments
  # OCES I enviroments
  def self.OCESI_DANID_ENV_PROD; 'OCESI_DANID_ENV_PROD'; end
  def self.OCESI_DANID_ENV_SYSTEMTEST; 'OCESI_DANID_ENV_SYSTEMTEST'; end
  def self.OCESI_DANID_ENV_DEVELOPMENT; 'OCESI_DANID_ENV_DEVELOPMENT'; end
  def self.CAMPUSI_DANID_ENV_PROD; 'CAMPUSI_DANID_ENV_PROD'; end

  # OCES II environments
  def self.OCESII_DANID_ENV_PREPROD; 'OCESII_DANID_ENV_PREPROD'; end
  def self.OCESII_DANID_ENV_PROD; 'OCESII_DANID_ENV_PROD'; end
  def self.OCESII_DANID_ENV_EXTERNALTEST; 'OCESII_DANID_ENV_EXTERNALTEST'; end
  def self.OCESII_DANID_ENV_INTERNALTEST; 'OCESII_DANID_ENV_INTERNALTEST'; end
  def self.OCESII_DANID_ENV_IGTEST; 'OCESII_DANID_ENV_IGTEST'; end
  def self.OCESII_DANID_ENV_OPERATIONSTEST; 'OCESII_DANID_ENV_OPERATIONSTEST'; end
  def self.OCESII_DANID_ENV_DEVELOPMENTTEST; 'OCESII_DANID_ENV_DEVELOPMENTTEST'; end
  def self.OCESII_DANID_ENV_DEVELOPMENT; 'OCESII_DANID_ENV_DEVELOPMENT'; end
  def self.OCESII_DANID_ENV_LOCALHOST_TESTING; 'OCESII_DANID_ENV_LOCALHOST_TESTING'; end

  @@environments = [self.OCESII_DANID_ENV_PROD]
  
  def self.reset_for_testing
    @@environments = [self.OCESII_DANID_ENV_PROD]
    @@has_been_set = false
  end

  def self.environments=(environments)
    environments = [environments].flatten # Make sure it's an array

    raise Exception, 'Environments cannot be set twice' if @@has_been_set
    puts 'No environments are trusted. This can cause all sorts of problems' if environments.empty?

    environments.each do |environment|
      raise Exception, "No root certificate for environment: #{environment}" unless RootCertificates.has_certificate?(environment)
    end
    number_of_production_environments = count_number_of_production_environments(environments)
    if number_of_production_environments > 0 && number_of_production_environments != environments.length
      raise Exception, "Production environments cannot be mixed with test environments"
    end

    @@has_been_set = true
    @@environments = environments
  end
  
  def self.trusted_environments
    @@environments
  end
  
  private
  def self.count_number_of_production_environments(environments)
    (environments & [self.OCESI_DANID_ENV_PROD, self.OCESII_DANID_ENV_PROD, self.CAMPUSI_DANID_ENV_PROD]).length
  end
end