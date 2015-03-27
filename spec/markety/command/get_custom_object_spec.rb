require 'spec_helper'

module Markety
  module Command
    describe GetCustomObject do

      let(:client){ double("client", send_request: nil) }

      describe '#get_custom_object_by_keys' do
        context "with multiple keys" do
          it "calls send_request on the client with the correct params" do
            client.extend(GetCustomObject)
            client.get_custom_object_by_keys("Roadshow", {"MKTOID" => 1090177, "rid" => 123456})
            expect(client).to have_received(:send_request).with(:get_custom_objects, {"objTypeName"=>"Roadshow", "customObjKeyList"=>{"attribute"=>[{"attrName" => "MKTOID", "attrValue" => 1090177}, {"attrName" => "rid", "attrValue" => 123456}]}})
          end
        end

        context "with a single key" do
          it "calls send_request on the client with the correct params" do
            client.extend(GetCustomObject)
            client.get_custom_object_by_keys("Roadshow", {"MKTOID" => 12341234})
            expect(client).to have_received(:send_request).with(:get_custom_objects, {"objTypeName"=>"Roadshow", "customObjKeyList"=>{"attribute"=>[{"attrName" => "MKTOID", "attrValue" => 12341234}]}})
          end
        end
      end

    end
  end
end
