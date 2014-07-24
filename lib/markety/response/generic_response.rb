class GenericResponse
  attr_reader :error_message

  #response is a Savon::Reponse or a Savon::SOAPFault
  def initialize(cmd_type,response)
    @response = response
    @success = response.is_a? Savon::Response
    @error_message = @success ? nil : response.to_s
  end

  def success?
    @success
  end

  def to_xml
    @success ? @response.to_xml : @response.http.raw_body
  end

  def to_hash
    @response.to_hash
  end

end
