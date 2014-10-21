module Markety
  module Command

    # GetLead commands return Response::GetLeadResponse objects
    module GetLead

      # IDs are unique per lead, so the response can only contain one lead.
      def get_lead_by_idnum(idnum)
        get_lead(LeadKey.new(LeadKeyType::IDNUM, idnum))
      end

      # Multiple leads can share an email address,
      # so this may result in more than one lead in the response.
      def get_leads_by_email(email)
        get_lead(LeadKey.new(LeadKeyType::EMAIL, email))
      end


    private

      def get_lead(lead_key)
        send_request(:get_lead, {"leadKey" => lead_key.to_hash})
      end

    end
  end
end
