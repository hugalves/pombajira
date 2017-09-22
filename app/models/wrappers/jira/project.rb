module Wrappers
  module Jira
    class Project < Base
      def fetch_project_id
        process!
          .detect { |project| project['key'] == project_key }
          .fetch('id')
      end

      private

      def process!
        all
      end

      def project_key
        Settings
          .jira
          .deep_symbolize_keys
          .fetch(:project_key)
      end
    end
  end
end
