require 'spec_helper'

module Markety
  module Response
    describe GetLeadResponse do

      let(:success_xml) { <<END
<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns1="http://www.marketo.com/mktows/">
  <SOAP-ENV:Body>
    <ns1:successGetLead>
      <result>
        <count>1</count>
        <leadRecordList>
          <leadRecord>
            <Id>1001081</Id>
            <Email>foo@example.com</Email>
            <ForeignSysPersonId xsi:nil="true"/>
            <ForeignSysType xsi:nil="true"/>
            <leadAttributeList>
              <attribute>
                <attrName>FirstName</attrName>
                <attrType>string</attrType>
                <attrValue>Burt</attrValue>
              </attribute>
              <attribute>
                <attrName>LastName</attrName>
                <attrType>string</attrType>
                <attrValue>Reynolds</attrValue>
              </attribute>
            </leadAttributeList>
          </leadRecord>
        </leadRecordList>
      </result>
    </ns1:successGetLead>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
END
      }

      let(:success_xml_two_leads) { <<END
<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns1="http://www.marketo.com/mktows/">
  <SOAP-ENV:Body>
    <ns1:successGetLead>
      <result>
        <count>2</count>
        <leadRecordList>
          <leadRecord>
            <Id>1001084</Id>
            <Email>foo@example.com</Email>
            <ForeignSysPersonId xsi:nil="true"/>
            <ForeignSysType xsi:nil="true"/>
            <leadAttributeList>
              <attribute>
                <attrName>Company</attrName>
                <attrType>string</attrType>
                <attrValue>The Price is Right</attrValue>
              </attribute>
              <attribute>
                <attrName>FirstName</attrName>
                <attrType>string</attrType>
                <attrValue>Bob</attrValue>
              </attribute>
              <attribute>
                <attrName>LastName</attrName>
                <attrType>string</attrType>
                <attrValue>Barker</attrValue>
              </attribute>
            </leadAttributeList>
          </leadRecord>
          <leadRecord>
            <Id>1001081</Id>
            <Email>foo@example.com</Email>
            <ForeignSysPersonId xsi:nil="true"/>
            <ForeignSysType xsi:nil="true"/>
            <leadAttributeList>
              <attribute>
                <attrName>Company</attrName>
                <attrType>string</attrType>
                <attrValue>foo</attrValue>
              </attribute>
              <attribute>
                <attrName>FirstName</attrName>
                <attrType>string</attrType>
                <attrValue>foo</attrValue>
              </attribute>
              <attribute>
                <attrName>LastName</attrName>
                <attrType>string</attrType>
                <attrValue>foo</attrValue>
              </attribute>
              <attribute>
                <attrName>LeadStatus</attrName>
                <attrType>string</attrType>
                <attrValue>Inactive</attrValue>
              </attribute>
            </leadAttributeList>
          </leadRecord>
        </leadRecordList>
      </result>
    </ns1:successGetLead>
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
      <faultstring>20103 - Lead not found</faultstring>
      <detail>
        <ns1:serviceException xmlns:ns1="http://www.marketo.com/mktows/">
          <name>mktServiceException</name>
          <message>No lead found with EMAIL = pants@example.com (20103)</message>
          <code>20103</code>
        </ns1:serviceException>
      </detail>
    </SOAP-ENV:Fault>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
END
      }


      it 'can construct from a success - one lead' do
        savon_resp = SavonHelper.create_response(success_xml)
        r = GetLeadResponse.new(savon_resp)

        # GenericResponse fields
        r.success?.should == true
        r.error_message.should be_nil

        # SyncLeadResponse fields
        r.leads.length.should == 1
	r.leads.first.get_attribute("FirstName").should == "Burt"
      end

      it 'can construct from a success - two leads' do
        savon_resp = SavonHelper.create_response(success_xml_two_leads)
        r = GetLeadResponse.new(savon_resp)

        # GenericResponse fields
        r.success?.should == true
        r.error_message.should be_nil

        # SyncLeadResponse fields
        r.leads.length.should == 2
	r.leads[0].get_attribute("Company").should == "The Price is Right"
	r.leads[1].get_attribute("Company").should == "foo"
      end


      it 'can construct from a failure' do
        savon_resp = SavonHelper.create_response(failure_xml)
        r = GetLeadResponse.new(savon_resp)

        # GenericResponse fields
        r.success?.should == false
        r.error_message.should == "No lead found with EMAIL = pants@example.com (20103)"

        # SyncLeadResponse fields
        r.leads.empty?.should be true
      end
    end
  end
end
