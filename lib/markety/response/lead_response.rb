module Markety
  module Response
    class LeadResponse

      attr_accessor :status, :error_message, :lead_id

      def initialize(response)
        self.status = response[:status]
        self.error_message = response[:error]
        self.lead_id = response[:lead_id]
      end

      def success?
        !failed?
      end

      private

      def failed?
        status == "FAILED"
      end

    end
  end
end
