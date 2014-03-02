require "selenium/webdriver"

module Selenium::More
  module Hooks
    def self.included(base)
      base.extend(ClassMethods)
    end

    def self.module_to_prepend(method_name, before: nil, after: nil)
      raise ArgumentError, "at least one of before or after is needed" unless before || after

      Module.new do
        define_method method_name do |*args|
          before.call(self)     if before
          ret = super(*args)
          after.call(self, ret) if after

          ret
        end
      end
    end

    def hook(method_name, opts)
      if respond_to?(method_name.to_sym)
        self.singleton_class.prepend Hooks.module_to_prepend(method_name, opts)
      else
        raise NoMethodError, "no #{method_name} to hook"
      end
    end

    module ClassMethods
      def hook(method_name, opts)
        if instance_methods.include?(method_name.to_sym)
          prepend Hooks.module_to_prepend(method_name, opts)
        else
          raise NoMethodError, "no #{method_name} to hook"
        end
      end
    end
  end
end
