require "selenium/more"

require "selenium_connect"

RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.order = 'random'

  config.before(:suite) do
    ::SeleniumConnect.start ::SeleniumConnect::Configuration.new browser: "htmlunit"
  end
end
