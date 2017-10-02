module Builders
  module Jira
    class Epic
      attr_reader :epic

      def initialize(epic)
        @epic = epic
      end

      def all
        issues_keys
      end

      private

      def issues_keys
        "/search?jql=\"Epic Link\" = \"#{epic}\""
      end
    end
  end
end
