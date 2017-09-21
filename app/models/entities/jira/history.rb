module Entities
  module Jira
    class History
      attr_reader :created_at, :items

      def initialize(created, items=nil)
        @created_at = created
        @items      = items
      end
    end
  end
end
