module Reports
  module Jira
    class Epic
      attr_reader :epic

      def initialize(epic)
        @epic = epic
      end

      def build!
        keys = issues
        keys.map do |issue|
          Reports::Jira::Transition.new(issue).process
        end
      end

      def issues
        payload = Builders::Jira::Epic.new(epic).all
        wrapper = Wrappers::Jira::Epic.new(payload)
        wrapper.issues_keys
      end
    end
  end
end
