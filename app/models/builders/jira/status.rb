module Builders
  module Jira
    class Status
      attr_reader :project_id

      def initialize(project_id)
        @project_id = project_id
      end

      def fetch
        "/project/#{project_id}/statuses"
      end
    end
  end
end
