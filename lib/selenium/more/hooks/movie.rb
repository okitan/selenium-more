require "selenium/more/hooks"
require "selenium/more/hooks/sequential_capture"

module Selenium::More::Hooks
  module Movie
    def self.included(base)
      base.include Selenium::More::Hooks::SequentialCapture
    end

    def save_movie(movie_name)
      pattern = sequential_capture_pattern.sub(/%\d+d/, "*")

      Selenium::More.configuration.movie_conversion_strategy.call(
        input_pattern: File.join(sequential_capture_dir, pattern),
        output_path:   movie_name,
      )
    end

    def reset_movie
      reset_sequential_capture
    end
  end
end
