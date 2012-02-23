require File.dirname(__FILE__) + '/../../lib/validation/error_code_checker'

# The test names in the original Java code are just plain absurd. However, right now they
# are mimicked in this spec.
describe ErrorCodeChecker do
  it 'is error' do
    ErrorCodeChecker.is_error?("NoError").should be_false
    ErrorCodeChecker.is_error?("SRV001").should be_true

    ErrorCodeChecker.error_codes.each do |error_code|
      ErrorCodeChecker.is_error?(error_code).should be_true
    end
  end
  
  # Weird test in Ruby. Not sure the extract_error method really makes sense in Java either...
  it 'extract error' do
    ErrorCodeChecker.extract_error("NoError").should be_nil
    ErrorCodeChecker.extract_error("SRV001").should_not be_nil

    ErrorCodeChecker.error_codes.each do |error_code|
      ErrorCodeChecker.extract_error(error_code).should_not be_nil
      ErrorCodeChecker.extract_error(error_code).should == error_code
    end
  end
  
  it 'has error' do
    ecc = ErrorCodeChecker.new("NoError")
    ecc.has_error?.should be_false
    ecc.extract_error.should be_nil

    ecc = ErrorCodeChecker.new("APP001")
    ecc.has_error?.should be_true
    ecc.extract_error.should == "APP001"

    ErrorCodeChecker.error_codes.each do |error_code|
      ecc = ErrorCodeChecker.new(error_code)
      ecc.has_error?.should be_true
      ecc.extract_error.should == error_code
    end
  end
end