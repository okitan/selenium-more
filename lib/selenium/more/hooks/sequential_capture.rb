require "selenium/more/hooks"
require "tmpdir"

module Selenium::More::Hooks
  module SequentialCapture
    def self.included(base)
      base.include Selenium::More::Hooks

      base.hook :get, before: ->(driver, url)             { driver.save_sequential_capture },
                      after:  ->(driver, ret, url)        { driver.save_sequential_capture }
      base.hook :find_element,  before: ->(driver, *args) { driver.save_sequential_capture }
      base.hook :find_elements, before: ->(driver, *args) { driver.save_sequential_capture }
    end

    attr_writer :sequential_capture_dir, :sequential_capture_pattern

    def save_sequential_capture
      save_screenshot(p next_sequential_capture_filename) unless current_url == "about:blank"
    end

    def reset_sequential_capture
      @capture_sequence.times {|i| File.delete(sequential_capture_filename(i) }
      @capture_sequence = 0
    end

    def sequential_capture_dir
      @sequential_capture_dir || Selenium::More.configuration.sequential_capture_dir || Dir.tmpdir
    end

    def sequential_capture_pattern
      @sequential_capture_pattern || Selenium::More.configuration.sequential_capture_pattern || "%06d.png"
    end

    protected
    def sequential_capture_filename(sequence)
      File.join(sequential_capture_dir, sequential_capture_pattern % sequence)
    end

    def next_sequential_capture_filename
      @capture_sequence ||= 0
      sequential_capture_filename(@capture_sequence += 1)
    end
  end
end
