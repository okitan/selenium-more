require "spec_helper"

require "selenium/more/hooks"

describe Selenium::WebDriver::Driver, "with", Selenium::More::Hooks do
  context ".hook" do
    context "of before and after" do
      let(:klass) do
        Class.new(described_class) do
          include Selenium::More::Hooks

          def spy
            @spy ||= []
          end

          hook :current_url, before: ->(driver)      { driver.spy << "before_hook" },
                             after:  ->(driver, ret) { driver.spy << "after_hook" }
        end
      end

      let(:original_driver) { described_class.for :remote, desired_capabilities: :htmlunit }
      let(:driver)          {           klass.for :remote, desired_capabilities: :htmlunit }

      it "works" do
        expect { driver.current_url }.to change { driver.spy }.to(%w[ before_hook after_hook ])
      end

      it "returns value as is" do
        expect(driver.current_url).to eq(original_driver.current_url)
      end
    end

    context "of after" do
      let(:klass) do
        Class.new(described_class) do
          include Selenium::More::Hooks

          attr_accessor :spy

          hook :current_url, after:  ->(driver, ret) { driver.spy = ret }
        end
      end

      let(:original_driver) { described_class.for :remote, desired_capabilities: :htmlunit }
      let(:driver)          {           klass.for :remote, desired_capabilities: :htmlunit }

      it "passes ret value to after block" do
        expect { driver.current_url }.to change { driver.spy }.to(original_driver.current_url)
      end
    end
  end
end
