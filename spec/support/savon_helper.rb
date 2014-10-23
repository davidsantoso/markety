module SavonHelper
  extend self

  def create_response(xml)
    http_response = HTTPI::Response.new(200,{},xml) #should be 500 for failure, but this test doesn't care
    begin
      response = Savon::Response.new(http_response,Savon::GlobalOptions.new,Savon::LocalOptions.new)
    rescue Savon::SOAPFault => e
      response = e
    end
    response
  end

end
