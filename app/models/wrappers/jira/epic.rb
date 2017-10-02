module Wrappers
  module Jira
    class Epic < Base
      def issues_keys
        all
          .fetch('issues')
          .map { |i| i['key'] }
      end
    end
  end
end
