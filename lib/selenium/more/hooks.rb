require "selenium/webdriver"

module Selenium::More
  module Hooks
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def hook(method, opts)
        if self.instance_methods.include?(method.to_sym)
          mod = Module.new do
            define_method method do |*args|
              instance_eval(&opts[:before]) if opts[:before]
              super(*args)
              instance_eval(&opts[:after])  if opts[:after]
            end
          end

          self.prepend(mod)
        else
          raise NoMethodError, "no #{method} to hook"
        end
      end
    end
  end
end
