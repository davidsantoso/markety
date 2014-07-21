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
    def initialize(savon_client, authentication_header, options={})
      @client = savon_client
      @auth_header = authentication_header
      @target_workspace = options[:target_workspace]
    end

    public

    def get_lead_by_idnum(idnum)
      get_lead(LeadKey.new(LeadKeyType::IDNUM, idnum))
    end

    def get_lead_by_email(email)
      get_lead(LeadKey.new(LeadKeyType::EMAIL, email))
    end

    def sync_lead(lead, sync_method)
      request_hash = create_sync_lead_request_hash(lead,sync_method)

      response = send_request(:sync_lead, request_hash)
      return Lead.from_hash(response[:success_sync_lead][:result][:lead_record])
    end

    def create_sync_lead_request_hash(lead, sync_method)
      raise "missing sync method" unless sync_method

      case sync_method
        when SyncMethod::MARKETO_ID
          raise "lead has no idnum" unless lead.idnum
        when SyncMethod::FOREIGN_ID
          raise "lead has no foreign_sys_person_id" unless lead.foreign_sys_person_id
        when SyncMethod::EMAIL
          raise "lead has no email" unless lead.email
        else
          raise "unrecognized Markety::SyncMethod '#{sync_method}'"
      end

      # the fields must come in a very particular order, thus why this flow is a little janky
      request_hash = {
        lead_record: { },
        return_lead: true,
      }

      # id fields must come first in lead_record
      request_hash[:lead_record][:id]=lead.idnum if sync_method==SyncMethod::MARKETO_ID
      use_foreign_id = lead.foreign_sys_person_id && [SyncMethod::MARKETO_ID,SyncMethod::FOREIGN_ID].include?(sync_method)
      request_hash[:lead_record][:foreignSysPersonId]=lead.foreign_sys_person_id if use_foreign_id
      request_hash[:lead_record]["Email"]=lead.email if lead.email

      # now lead attributes (which must be ordered name/type/value (type is optional, but must precede value if present)
      request_hash[:lead_record][:lead_attribute_list] = { attribute: lead.attributes_soap_array }

puts "=========="
puts request_hash.inspect
puts "=========="
      request_hash
    end


    def add_to_list(list_name, idnum)
      list_operation(list_name, ListOperationType::ADD_TO, idnum)
    end

    def remove_from_list(list_name, idnum)
      list_operation(list_name, ListOperationType::REMOVE_FROM, idnum)
    end

    def is_member_of_list?(list_name, idnum)
      list_operation(list_name, ListOperationType::IS_MEMBER_OF, idnum)
    end

    private

    def list_operation(list_name, list_operation_type, idnum)
      response = send_request(:list_operation, {
        list_operation: list_operation_type,
        strict:         'false',
        list_key: {
          key_type: 'MKTOLISTNAME',
          key_value: list_name
        },
        list_member_list: {
          lead_key: [{
            key_type: 'IDNUM',
            key_value: idnum
            }
          ]
        }
      })
      return response
    end

    def get_lead(lead_key)
      response = send_request(:get_lead, {"leadKey" => lead_key.to_hash})
      return Lead.from_hash(response[:success_get_lead][:result][:lead_record_list][:lead_record])
    end

    def send_request(namespace, message)
      @auth_header.set_time(DateTime.now)

      header_hash = @auth_header.to_hash
      if namespace==:sync_lead && @target_workspace
        header_hash.merge!({ "ns1:MktowsContextHeader"=>{"targetWorkspace"=>@target_workspace}})
      end

      response = request(namespace, message, header_hash)
      response.to_hash
    end

    def request(namespace, message, header)
      @client.call(namespace, message: message, soap_header: header)
    end
  end
end
