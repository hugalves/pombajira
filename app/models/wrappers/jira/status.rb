module Wrappers
  module Jira
    class Status < Base
      def process!
        all
          .first
          .fetch('statuses')
          .map { |status| status['name'] }
      end
    end
  end
end
