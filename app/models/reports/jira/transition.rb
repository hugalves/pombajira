module Reports
  module Jira
    class Transition
      include ::Utilizable

      attr_reader :issue, :project_id, :statuses

      def initialize(issue)
        @issue        = issue
        @project_id ||= project_id
        @statuses   ||= statuses
      end

      def process
        payload  = Builders::Jira::Issue.new(issue).all
        wrapper  = Wrappers::Jira::History.new(payload)
        statuses = fetch_statuses

        statuses.map do |status|
          { "#{status}" => date_formatter(wrapper.fetch_time_of(status)) }
        end
      end

      private

      def fetch_statuses
        payload = Builders::Jira::Status.new(project_id).fetch
        wrapper = Wrappers::Jira::Status.new(payload)

        wrapper.process!
      end

      def project_id
        payload = Builders::Jira::Project.all
        wrapper = Wrappers::Jira::Project.new(issue, payload)
        wrapper.fetch_id!
      end
    end
  end
end
