module Builders
  module Jira
    class Issue
      attr_reader :id

      def initialize(id)
        @id = id
      end

      def all
        changelog
      end

      private

      def changelog
        "/issue/#{id}?expand=changelog"
      end
    end
  end
end
