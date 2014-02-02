require "spec_helper"

require "selenium/more/hooks"

describe Selenium::WebDriver, "with", Selenium::More::Hooks do
  context ".hook" do
    context "of before" do
      let(:klass) do
        Class.new(::Selenium::WebDriver::Driver) do
          include Selenium::More::Hooks

          def spy
            @spy
          end

          hook :get, before: ->(driver) { @spy = "get_before_hook" }
        end
      end

      let(:driver) do
        klass.for :remote, desired_capabilities: :htmlunit
      end

      it "works" do
        expect { driver.get "http://localhost:9292" }.to change { driver.spy }.to "get_before_hook"
      end
    end
  end
end
