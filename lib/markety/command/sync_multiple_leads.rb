module Markety
  module Command
    module SyncMultipleLeads

      def sync_multiple_leads(leads, dedup_enabled=true)
        send_request(:sync_multiple_leads, sync_lead_request_hash(leads, dedup_enabled))
      end

    private

      def sync_lead_request_hash(leads, dedup_enabled)
        {
          "leadRecordList" => {
            "leadRecord" => leads.map(&:synchronisation_hash),
          },
          "dedupEnabled" => dedup_enabled
        }
      end

    end
  end
end
