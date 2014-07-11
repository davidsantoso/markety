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

    Client.new(client, Markety::AuthenticationHeader.new(access_key, secret_key))
  end

  class Client
    def initialize(savon_client, authentication_header)
      @client = savon_client
      @header = authentication_header
    end

    public

    def get_lead_by_idnum(idnum)
      get_lead(LeadKey.new(LeadKeyType::IDNUM, idnum))
    end

    def get_lead_by_email(email)
      get_lead(LeadKey.new(LeadKeyType::EMAIL, email))
    end

    def set_logger(logger)
      @logger = logger
    end

    def sync_lead(lead, sync_method)
      raise "missing sync method" unless sync_method

      request_hash = {
        return_lead: true,
        lead_record: {
          lead_attribute_list: {
            attribute: lead.attributes_soap_array
          }
        }
      }

      begin
        case sync_method
          when SyncMethod::MARKETO_ID
            raise "lead has no idnum" unless lead.idnum
            request_hash[:lead_record][:id] = lead.idnum
            request_hash[:lead_record]["foreignSysPersonId"] = lead.foreign_sys_person_id if lead.foreign_sys_person_id
          when SyncMethod::FOREIGN_ID
            raise "lead has no foreign_sys_person_id" unless lead.foreign_sys_person_id
            request_hash[:lead_record]["foreignSysPersonId"] = lead.foreign_sys_person_id
          when SyncMethod::EMAIL
            raise "lead has no email" unless lead.email
          else
            raise "unrecognized Markety::SyncMethod '#{sync_method}'"
        end
        request_hash[:lead_record]["Email"] = lead.email
        
        response = send_request(:sync_lead, request_hash)
        return Lead.from_hash(response[:success_sync_lead][:result][:lead_record])

      rescue Exception => e
        @logger.log(e) if @logger
        return nil
      end
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
      begin
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
      rescue Exception => e
        @logger.log(e) if @logger
        return nil
      end
    end

    def get_lead(lead_key)
      begin
        response = send_request(:get_lead, {"leadKey" => lead_key.to_hash})
        return Lead.from_hash(response[:success_get_lead][:result][:lead_record_list][:lead_record])
      rescue Exception => e
        @logger.log(e) if @logger
        return nil
      end
    end

    def send_request(namespace, message)
      @header.set_time(DateTime.now)
      response = request(namespace, message, @header.to_hash)
      response.to_hash
    end

    def request(namespace, message, header)
      @client.call(namespace, message: message, soap_header: header)
    end
  end
end
