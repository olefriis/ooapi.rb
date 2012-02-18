# TODO: This is just a stub for now
require 'validation/partitioned_crl_revocation_checker'

class ServiceProviderSetup
  def self.current_checker
    PartitionedCrlRevocationChecker.new
  end
end