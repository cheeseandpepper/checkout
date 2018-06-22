require File.expand_path('../lib/checkout/version', __FILE__)

Gem::Specification.new do |s|
  s.authors       = ['Mike Lerner']
  s.email         = 'cheeseandpepper@gmail.com'
  s.name          = %q{checkout}
  s.version       = Checkout::VERSION
  s.date          = %q{2018-06-21}
  s.summary       = %q{checkout lets you switch branches easily}
  s.require_paths = ["lib"]
  s.executables   = ["checkout"]  
  
  s.files = [
    "lib/checkout.rb",
    "lib/checkout/runner.rb",
    "lib/checkout/version.rb"
  ]
end
