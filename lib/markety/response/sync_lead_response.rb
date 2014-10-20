require 'markety/lead'
require 'markety/response/generic_response'

module Markety
  module Response
    # Response class for SyncLead commands
    class SyncLeadResponse < GenericResponse
      
      # +:created+ or +:updated+ (or nil if unsuccessful)
      attr_reader :update_type
      # the updated or created Lead (or nil if unsuccessful)
      attr_reader :updated_lead
      # the ID of the created or updated Lead (or nil if unsuccessful)
      attr_reader :lead_id

      def initialize(response)
        super(:sync_response,response)
        h = self.to_hash

        if self.success?
          sync_status = h[:success_sync_lead][:result][:sync_status]
          @lead_id = sync_status[:lead_id]
          @update_type = sync_status[:status].downcase.to_sym
          @updated_lead = ::Markety::Lead.from_hash(h[:success_sync_lead][:result][:lead_record])
        else
          # overwrite super's crap error message with useful one
          @error_message = h[:fault][:detail][:service_exception][:message]
        end
      end
    end
  end
end
