module Wrappers
  module Jira
    class History
      attr_reader :builder, :adapter, :histories

      def initialize(builder)
        @builder     = builder.all
        @adapter     = adapter
        @histories ||= all
      end

      def fetch_time_of(status)
        time_of(status)
      end

      private

      def time_of(status)
        story = fetch_by(status)
        story.try(:created_at)
      end

      def fetch_by(status)
        story = with_status_items.select do |history|
          history.items.detect do |item|
            item['toString'] == status
          end
        end

        Array(story).first
      end

      def with_status_items
        histories.select do |story|
          story.items.any? do |item|
            item['field'] == 'status'
          end
        end
      end

      def all
        fetch.map do |a|
          Entities::Jira::History.new(a['created'], a['items'])
        end
      end

      def fetch
        adapter
          .process
          .fetch('changelog')
          .fetch('histories')
      end

      def adapter
        ::Jira::Adapter
          .new(builder)
      end
    end
  end
end
