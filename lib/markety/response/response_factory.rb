require 'markety/response/generic_response'
require 'markety/response/sync_lead_response'

class ResponseFactory

  def self.create_response(cmd_type,xmlresponse)
    case cmd_type
      when :sync_lead
        SyncLeadResponse.new(xmlresponse)
      else
        GenericResponse.new(cmd_type,xmlresponse)
    end
  end

end
