require 'spec_helper'

module Markety
  module Response
    describe SyncLeadResponse do

      let(:success_xml) { <<END
<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns1="http://www.marketo.com/mktows/">
  <SOAP-ENV:Body>
    <ns1:successSyncLead>
      <result>
        <leadId>1001064</leadId>
        <syncStatus>
          <leadId>1001064</leadId>
          <status>CREATED</status>
          <error xsi:nil="true"/>
        </syncStatus>
        <leadRecord>
          <Id>1001064</Id>
          <Email>spiderman@example.com</Email>
          <ForeignSysPersonId xsi:nil="true"/>
          <ForeignSysType xsi:nil="true"/>
          <leadAttributeList>
            <attribute>
              <attrName>FirstName</attrName>
              <attrType>string</attrType>
              <attrValue>Peter</attrValue>
            </attribute>
            <attribute>
              <attrName>LastName</attrName>
              <attrType>string</attrType>
              <attrValue>Parker</attrValue>
            </attribute>
            <attribute>
              <attrName>Website</attrName>
              <attrType>url</attrType>
              <attrValue>example.com</attrValue>
            </attribute>
          </leadAttributeList>
        </leadRecord>
      </result>
    </ns1:successSyncLead>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
END
      }

      let(:failure_xml) { <<END
<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
  <SOAP-ENV:Body>
    <SOAP-ENV:Fault>
      <faultcode>SOAP-ENV:Client</faultcode>
      <faultstring>20105 - Unknown lead field</faultstring>
      <detail>
        <ns1:serviceException xmlns:ns1="http://www.marketo.com/mktows/">
          <name>mktServiceException</name>
          <message>syncLead operation failed: unknown fields for import: pants (20105)</message>
          <code>20105</code>
        </ns1:serviceException>
      </detail>
    </SOAP-ENV:Fault>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
END
      }



      it 'can construct from a success' do
        savon_resp = SavonHelper.create_response(success_xml)

        r = SyncLeadResponse.new(savon_resp)

        # GenericResponse fields
        r.success?.should == true
        r.error_message.should be_nil
        # to_xml
        # to_hash

        # SyncLeadResponse fields
        r.lead_id.should == "1001064"
        r.update_type.should == :created
        r.updated_lead.is_a?(::Markety::Lead).should == true
      end

      it 'can construct from a failure' do
        savon_resp = SavonHelper.create_response(failure_xml)

        r = SyncLeadResponse.new(savon_resp)

        # GenericResponse fields
        r.success?.should == false
        r.error_message.should == "syncLead operation failed: unknown fields for import: pants (20105)"
        # to_xml
        # to_hash

        # SyncLeadResponse fields
        r.lead_id.should be_nil
        r.update_type.should be_nil
        r.updated_lead.should be_nil
      end

    end #describe SyncLeadResponse
  end #module Response
end #module Markety
