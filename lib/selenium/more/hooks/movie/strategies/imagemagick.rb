# This strategy requires imagemagick installed
module Selenium::More::Hooks::Movie::Strategies
  class Imagemagick
    def initialize
    end

    def call(input_pattern: nil, output_path: nil)
      # TODO: decide to support Ruby >= 2.1.0
      raise ArgumentError, "specify input_patern"  unless input_pattern
      raise ArgumentError, "specify output_patern" unless output_path

      # Note: we have vulnability of command line injection
      `convert #{input_pattern} #{output_path}`
    end
  end
end
