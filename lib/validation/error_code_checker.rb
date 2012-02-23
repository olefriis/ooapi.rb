class ErrorCodeChecker
  @@error_codes = ['APP001', 'APP002', 'APP003', 'APP004', 'APP005',
    'SRV001', 'SRV002', 'SRV003', 'SRV004', 'SRV005', 'SRV006',
    'CAN001', 'CAN002',
    'AUTH001', 'AUTH003', 'AUTH004', 'AUTH005', 'AUTH006', 'AUTH007', 'AUTH008', 'AUTH009',
    'LOCK001', 'LOCK002', 'LOCK003',
    'OCES001', 'OCES002', 'OCES003', 'OCES004', 'OCES005', 'OCES006']
  
  def self.error_codes
    @@error_codes
  end
  
  def self.is_error?(text)
    raise new Exception, 'text must not be nil' unless text

    error_codes.any? {|error_code| error_code.casecmp(text.strip) == 0 }
  end
  
  def self.extract_error(text)
    error_codes.find {|error_code| error_code.casecmp(text.strip) == 0 }
  end
  
  def initialize(text)
    @has_error = ErrorCodeChecker.is_error?(text)
    @error = ErrorCodeChecker.extract_error(text)
  end
  
  def has_error?
    @has_error
  end
  
  def extract_error
    @error
  end
end