#!/usr/bin/env ruby

# @note This example need imagemagick installed

require "bundler/setup"
require "selenium/more"

require "selenium/more/hooks/movie"
require "selenium/more/hooks/movie/strategies/imagemagick"

class Selenium::WebDriver::Driver
  include Selenium::More::Hooks
  include Selenium::More::Hooks::Movie
end

Selenium::More.configure do |c|
  c.movie_conversion_strategy = Selenium::More::Hooks::Movie::Strategies::Imagemagick.new
end

driver = Selenium::WebDriver.for :phantomjs
driver.get "https://www.google.co.jp/"
driver.get "https://www.twitter.com/"
driver.get "https://www.facebook.com/"

driver.save_movie "tmp/hoge.gif"
