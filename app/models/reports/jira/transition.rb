require 'csv'

module Reports
  module Jira
    class Transition
      include ::Convertable

      attr_reader :issue, :project_id, :statuses

      def initialize(issue)
        @issue        = issue
        @project_id ||= project_id
        @statuses   ||= statuses
      end

      def process
        payload = Builders::Jira::Issue.new(issue).all
        wrapper = Wrappers::Jira::History.new(payload)

        statuses.map do |status|
          { "#{status}" => date_formatter(wrapper.fetch_time_of(status)) }
        end
      end

      private

      def statuses
        payload = Builders::Jira::Status.new(project_id).fetch
        wrapper = Wrappers::Jira::Status.new(payload)

        wrapper.process!
      end

      def project_id
        payload = Builders::Jira::Project.all
        wrapper = Wrappers::Jira::Project.new(payload)

        wrapper.fetch_project_id
      end
    end
  end
end
