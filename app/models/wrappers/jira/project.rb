module Wrappers
  module Jira
    class Project < Base
      include Instantiable

      attr_reader :issue_key, :payload, :project_key
      def initialize(issue_key, payload)
        @issue_key   = issue_key
        @payload     = payload
        @project_key = project_key
      end

      def fetch_id!
        project_id || fetch_project_id!
      end

      private

      def fetch_project_id!
        id = all.detect { |project| project['key'] == project_key }.fetch('id')

        return id if redis_set(project_key, id)
        raise StandardError, 'Could not fetch redis key'
      end

      def project_id
        redis_key_from(project_key)
      end

      def project_key
        issue_key
          .split('-')
          .first
      end
    end
  end
end
