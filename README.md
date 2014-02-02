# Selenium::More [![Build Status](https://travis-ci.org/okitan/selenium-more.png?branch=master)](https://travis-ci.org/okitan/selenium-more)

Selenium WebDriver utilities.

## Features

* hook interface to selenium-webdriver
* utilities for test
 * session management
 * implicit and explicit wait
 * retry

## Installation

Add this line to your application's Gemfile:

    gem 'selenium-more'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install selenium-more

## Usage

### Hooks

When you include ::Selenium::More::Hooks to ::Selenium::WebDriver::Driver, you can add before/after hook to any existing driver function.

Sample Code:
```ruby
class Selenium::WebDriver::Driver
  include Selenium::More::Hooks

  hook :get, before: ->(driver)      { puts driver.current_url }
             after:  ->(driver, ret) { puts driver.currnent_url }
end

driver = Selenium::WebDriver.for :phantomjs

drvier.get "http://example.com/"
```

It prints.
```
about:blank
http://example.com/
```

### session management

T.B.D.

### Implicit and Explicit wait

T.B.D.

### retry

T.B.D.

## Development

java is needed to run selenium-server-standalone

## Contributing

1. Fork it ( http://github.com/<my-github-username>/selenium-more/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
