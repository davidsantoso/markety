require 'markety/response/generic_response'
require 'markety/response/get_lead_response'
require 'markety/response/sync_lead_response'

class ResponseFactory

  def self.create_response(cmd_type,savon_response)
    case cmd_type
      when :get_lead
        GetLeadResponse.new(savon_response)
      when :sync_lead
        SyncLeadResponse.new(savon_response)
      else
        GenericResponse.new(cmd_type,savon_response)
    end
  end

end
