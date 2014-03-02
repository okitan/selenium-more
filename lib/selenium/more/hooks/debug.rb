require "selenium/more/hooks"

module Selenium::More::Hooks
  module Debug
    def self.included(base)
      base.include ::Selenium::More::Hooks
      base.hook :get, before: ->(driver, url)             { driver.print_page_info },
                      after:  ->(driver, ret, url)        { driver.print_page_info }
      base.hook :find_element,  before: ->(driver, *args) { driver.print_page_info }
      base.hook :find_elements, before: ->(driver, *args) { driver.print_page_info }
    end

    def print_page_info
      config = ::Selenium::More.configuration

      output = ""

      if @previous_current_url != current_url
        output += "[#{title}]" if config.debug_title
        output += "(#{current_url})" if config.debug_current_url
      end
      @previous_current_url = current_url

      (config.debug_output || $stderr).puts(output) unless output.empty?
    end
  end
end
