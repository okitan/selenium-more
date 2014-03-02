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

          hook :current_url, before: ->(driver)      { driver.spy << "before_hook1" },
                             after:  ->(driver, ret) { driver.spy << "after_hook1" }
          hook :current_url, before: ->(driver)      { driver.spy << "before_hook2" },
                             after:  ->(driver, ret) { driver.spy << "after_hook2" }
        end
      end

      let(:original_driver) { described_class.for :remote, desired_capabilities: :htmlunit }
      let(:driver)          {           klass.for :remote, desired_capabilities: :htmlunit }

      it "is called before and after in order" do
        expect { driver.current_url }.to change { driver.spy }.to(%w[ before_hook2 before_hook1 after_hook1 after_hook2 ])
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

    context "when no method is available" do
      it "raise NoMethodError" do
        expect {
          Class.new(described_class) do
            include Selenium::More::Hooks

            hook :hoge, before: ->(driver) { driver }
          end
        }.to raise_exception(NoMethodError, "no hoge to hook")
      end
    end
  end

  context "#hook" do
    let(:klass) do
      Class.new(described_class) do
        include Selenium::More::Hooks

        def spy
          @spy ||= []
        end
      end
    end

    let(:driver) do
      driver = klass.for :remote, desired_capabilities: :htmlunit
      driver.hook :current_url, before: ->(driver)      { driver.spy << "before_hook1" },
                                after:  ->(driver, ret) { driver.spy << "after_hook1" }
      driver.hook :current_url, before: ->(driver)      { driver.spy << "before_hook2" },
                                after:  ->(driver, ret) { driver.spy << "after_hook2" }
      driver
    end

    it "is called before and after in order" do
      expect { driver.current_url }.to change { driver.spy }.to(%w[ before_hook2 before_hook1 after_hook1 after_hook2 ])
    end
  end

  context "convination with .hook and #hook" do
      let(:klass) do
        Class.new(described_class) do
          include Selenium::More::Hooks

          def spy
            @spy ||= []
          end

          hook :current_url, before: ->(driver)      { driver.spy << "before_hook1" },
                             after:  ->(driver, ret) { driver.spy << "after_hook1" }
        end
      end

      let(:driver) do
        driver = klass.for :remote, desired_capabilities: :htmlunit
        driver.hook :current_url, before: ->(driver)      { driver.spy << "before_hook2" },
                                  after:  ->(driver, ret) { driver.spy << "after_hook2" }
        driver
      end

      it "is called before and after in order" do
        expect { driver.current_url }.to change { driver.spy }.to(%w[ before_hook2 before_hook1 after_hook1 after_hook2 ])
      end
  end
end
