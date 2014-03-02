require "selenium/webdriver"
require "selenium/more/configuration"

module Selenium
  module More
    class << self
      def configure(&block)
        @configuration ||= Configuration.new
        yield(@configuration) if block_given?
        @configuration
      end
      alias_method :configuration, :configure
    end
  end
end
