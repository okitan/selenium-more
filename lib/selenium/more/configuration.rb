module Selenium::More
  class Configuration
    # selenium/more/hooks/debug
    attr_accessor :debug_output, :debug_current_url, :debug_title

    # selenium/more/hooks/sequential_capture
    attr_accessor :sequential_capture_dir, :sequential_capture_pattern

    # seleniu/more/hooks/movie
    attr_accessor :movie_conversion_strategy
  end
end
