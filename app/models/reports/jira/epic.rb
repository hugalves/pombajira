require "csv"

module Reports
  module Jira
    class Epic
      attr_reader :epic

      def initialize(epic)
        @epic = epic
      end

      def build_csv!
        issues = build!
        index = 0
        CSV.open("file.csv", "wb") do |csv|
          issues.each do |issue|
            key    = issue.keys.first
            values = issue.values.flatten!.inject(:merge)

            if index == 0
              header = ["KEY"]
              header.concat(values.keys)
              csv << header
            end

            data = [key]
            data = [data.concat(values.values) * ',']
            csv  << data

            index = index + 1
          end
        end
      end

      private

      def build!
        keys = issues
        keys.map do |issue|
          { issue => Reports::Jira::Transition.new(issue).process }
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
