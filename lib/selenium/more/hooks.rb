require "selenium/more"

module Selenium::More
  module Hooks
    def self.included(base)
      base.extend(ClassMethods)
    end

    def self.module_to_prepend(method_name, before: nil, after: nil)
      raise ArgumentError, "at least one of before or after is needed" unless before || after

      Module.new do
        define_method method_name do |*args|
          before.call(self, *args)     if before
          ret = super(*args)
          after.call(self, ret, *args) if after

          ret
        end
      end
    end

    def hook(method_name, opts)
      if respond_to?(method_name.to_sym)
        # when ruby < 2.1.0, prepend is private method
        self.singleton_class.__send__(:prepend, Hooks.module_to_prepend(method_name, opts))
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
