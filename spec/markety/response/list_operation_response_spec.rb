require 'spec_helper'

module Markety
  module Response
    describe ListOperationResponse do

      let(:success_xml) {<<END
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://www.marketo.com/mktows/">
  <SOAP-ENV:Body>
    <ns1:successListOperation>
      <result>
        <success>true</success>
        <statusList>
          <leadStatus>
            <leadKey>
              <keyType>IDNUM</keyType>
              <keyValue>1001088</keyValue>
            </leadKey>
            <status>true</status>
          </leadStatus>
        </statusList>
      </result>
    </ns1:successListOperation>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
END
      }

      let(:failure_xml) {<<END
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://www.marketo.com/mktows/">
  <SOAP-ENV:Body>
    <ns1:successListOperation>
      <result>
        <success>false</success>
        <statusList>
          <leadStatus>
            <leadKey>
              <keyType>IDNUM</keyType>
              <keyValue>1001086</keyValue>
            </leadKey>
            <status>false</status>
          </leadStatus>
        </statusList>
      </result>
    </ns1:successListOperation>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
END
      }


      it 'can construct from a success' do
        savon_resp = SavonHelper.create_response(success_xml)
        r = ListOperationResponse.new(savon_resp)

        # GenericResponse fields
        r.success?.should == true
        r.error_message.should be_nil

        r.list_operation_status?.should == true
      end

      it 'can construct from a failure' do
        savon_resp = SavonHelper.create_response(failure_xml)
        r = ListOperationResponse.new(savon_resp)

        # GenericResponse fields
        r.success?.should == true
        r.error_message.should be_nil

        r.list_operation_status?.should == false
      end

    end
  end
end
