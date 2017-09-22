module Wrappers
  module Jira
    class Base
      attr_accessor :payload, :adapter

      def initialize(payload)
        @payload = payload
        @adapter = adapter
      end

      private

      def adapter
        ::Jira::Adapter
          .new(payload)
      end
    end
  end
end
