require 'markety/command'
require 'markety/response'

module Markety
  def self.new_client(access_key, secret_key, end_point, options = {})
    api_version = options.fetch(:api_version, '2_3')

    client = Savon.client do
      endpoint end_point
      wsdl "http://app.marketo.com/soap/mktows/#{api_version}?WSDL"
      env_namespace "SOAP-ENV"
      namespaces({"xmlns:ns1" => "http://www.marketo.com/mktows/"})
      pretty_print_xml true
      log false if options[:log] == false
    end

    auth_header = Markety::AuthenticationHeader.new(access_key, secret_key)

    client_options = {}
    client_options[:target_workspace] = options[:target_workspace] if options[:target_workspace]

    Client.new(client, auth_header, client_options)
  end

  class Client
    include Markety::Command::GetLead
    include Markety::Command::SyncLead
    include Markety::Command::ListOperation

    attr_reader :target_workspace

    def initialize(savon_client, authentication_header, options={})
      @client = savon_client
      @auth_header = authentication_header
      @target_workspace = options[:target_workspace]
    end


  private

    def send_request(cmd_type, message)
      @auth_header.set_time(DateTime.now)

      header_hash = @auth_header.to_hash
      if cmd_type==:sync_lead && @target_workspace
        header_hash.merge!({ "ns1:MktowsContextHeader"=>{"targetWorkspace"=>@target_workspace}})
      end

      begin
        response = request(cmd_type, message, header_hash) #returns a Savon::Response
      rescue Savon::SOAPFault => e
        response = e
      end
      ResponseFactory.create_response(cmd_type,response)
    end

    def request(cmd_type, message, header)
      @client.call(cmd_type, message: message, soap_header: header)
    end
  end
end
