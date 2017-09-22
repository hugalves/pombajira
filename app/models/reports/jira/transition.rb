require 'csv'

module Reports
  module Jira
    class Transition
      attr_reader :issue

      def initialize(issue)
        @issue = issue
      end

      def process
        builder = Builders::Jira::Issue.new(issue)
        wrapper = Wrappers::Jira::History.new(builder)

        columns.map do |column|
          { "#{column}" => Converter.format(wrapper.fetch_time_of(column)) }
        end
      end

      def columns
        Settings
          .jira
          .deep_symbolize_keys[:board]
      end
    end
  end
end
