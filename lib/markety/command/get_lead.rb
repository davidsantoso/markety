module Markety
  module Command

    # GetLead commands return Response::GetLeadResponse objects
    module GetLead

      def get_lead_by_idnum(idnum)
        get_lead(LeadKey.new(LeadKeyType::IDNUM, idnum))
      end

      def get_lead_by_email(email)
        get_lead(LeadKey.new(LeadKeyType::EMAIL, email))
      end


    private

      def get_lead(lead_key)
        send_request(:get_lead, {"leadKey" => lead_key.to_hash})
      end

    end
  end
end
