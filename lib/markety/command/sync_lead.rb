module Markety
  module Command
    module SyncLead

      def sync_lead(lead, sync_method)
        request_hash = create_sync_lead_request_hash(lead,sync_method)
        send_request(:sync_lead, request_hash)
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
  
        # note from gbirchmeier:
        #   A Marketo support guy told me the fields must come in a very particular order, thus why this flow is a little janky.
        #   I've since come to doubt this advice, but I'm not going to fix something that's working.

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
  
        request_hash
      end

    end
  end
end
