# coding: utf-8
Gem::Specification.new do |spec|
  spec.name          = "selenium-more"
  spec.version       = File.read(File.expand_path("VERSION", File.dirname(__FILE__))).chomp
  spec.authors       = ["okitan"]
  spec.email         = ["okitakunio@gmail.com"]
  spec.summary       = "Selenium WebDriver Utilities."
  spec.description   = <<_DESCRIPTION_
Selenium WebDriver Utilities.
- Many hook points for selenium-webdirver.
- Manage multiple sessions
- Implicit and Explicit wait
- Retry
_DESCRIPTION_
  spec.homepage      = "https://github.com/okitan/selenium-more"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "selenium-webdriver"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"

  spec.add_runtime_dependency "rspec", "~> 3.0.0.beta"
end
