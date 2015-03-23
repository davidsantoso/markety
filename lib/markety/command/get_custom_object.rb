module Markety
  module Command

    # GetLead commands return Response::GetLeadResponse objects
    module GetCustomObject

      def get_custom_object_by_idnum(idnum)
        send_request(:get_custom_objects, {"objTypeName" => "Job", "customObjKeyList" => {"attribute" => { "attrName" => "job_lead_id", "attrValue" => idnum}}})
      end

    end
  end
end
