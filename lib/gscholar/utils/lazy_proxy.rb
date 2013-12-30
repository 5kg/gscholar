module GScholar
  module Utils
    class LazyProxy < BasicObject
      def initialize(&block)
        @initializer = block
      end

      def method_missing(method, *args, &block)
        @obj ||= @initializer.call
        @obj.send(method, *args, &block)
      end
    end
  end
end
