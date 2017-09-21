module Wrappers
  module Jira
    class History
      INITIAL_STATUS = 'Product Backlog'
      FINAL_STATUS   = 'Done'

      attr_reader :builder, :adapter, :histories

      def initialize(builder)
        @builder     = builder.all
        @adapter     = adapter
        @histories ||= all
      end

      def fetch_time_of(status)
        time_of(status)
      end

      def time_of(status)
        story   = fetch_by(status)
        from_id = from_id(story)

        time    = with_status_items.select do |h|
          h.items.detect do |i|
            i['to'] == from_id
          end
        end.first

        time.try(:created_at)
      end

      def fetch_by(status)
        with_status_items.select do |history|
          history.items.detect do |item|
            item['toString'] == status
          end
        end
      end

      def fetch_time_of_initial_status
        histories.first['created_at']
      end

      def initial_status?(status)
        status == INITIAL_STATUS
      end

      def fetch_time_of_final_status
        histories.first['created_at']
      end

      def final_status?(status)
        status == FINAL_STATUS
      end

      def to_id(story)
        story
          .first
          .items
          .detect { |h| h['field'] == 'status' }
          .fetch('to')
      end

      def from_id(story)
        story
          .first
          .items
          .detect { |h| h['field'] == 'status' }
          .fetch('from')
      end

      def with_status_items
        histories.select do |history| history.items.any? { |item| item['field'] == 'status' } end
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
