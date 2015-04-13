module Markety
  module Response
    # Response class for SyncLead commands
    class SyncMultipleLeadsResponse < GenericResponse

      def initialize(response)
        super(:sync_multiple_leads_response, response)
      end

      def lead_responses
        response_hashes.map do |response_hash|
          LeadResponse.new(response_hash)
        end
      end

      def response_hashes
        [to_hash.fetch(:success_sync_multiple_leads, {}).fetch(:result, {}).fetch(:sync_status_list, {}).fetch(:sync_status, {})].flatten
      end
    end
  end
end
