require 'markety/lead'
require 'markety/response/generic_response'

module Markety
  module Response
    # Response class for Command::GetLead calls.
    class GetLeadResponse < GenericResponse
      # Array of leads returned by the GetLead command
      attr_reader :leads

      def initialize(response)
        super(:get_lead_response,response)
        h = self.to_hash
        @leads = []

        if self.success?
          count = h[:success_get_lead][:result][:count].to_i
          lead_hashes = h[:success_get_lead][:result][:lead_record_list][:lead_record]
          lead_hashes = [lead_hashes] if count==1
          lead_hashes.each {|leadhash| @leads << ::Markety::Lead.from_hash(leadhash) }
        else
          # overwrite super's crap error message with useful one
          @error_message = h[:fault][:detail][:service_exception][:message]
        end
      end

      # Convenience shortcut to get first element of #leads (or nil if none).
      # Appropriate for responses to Command::GetLead#get_lead_by_idnum, which cannot
      # result in more than one lead.
      def lead
        @leads.first
      end
    end
  end
end
