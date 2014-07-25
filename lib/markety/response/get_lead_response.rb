require 'markety/lead'
require 'markety/response/generic_response'

class GetLeadResponse < GenericResponse
  attr_reader :leads

  def initialize(response)
    super(:get_lead_response,response)
    h = self.to_hash
    @leads = []

puts ">>>"+h.inspect

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

end
