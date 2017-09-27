module Wrappers
  module Jira
    class History < Base
      attr_reader :histories

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

      def histories
        @histories ||= process!
      end

      def process!
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
    end
  end
end
