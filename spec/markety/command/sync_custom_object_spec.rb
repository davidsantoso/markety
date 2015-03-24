require 'spec_helper'

module Markety
  module Command
    describe SyncCustomObject do

      let(:client){ double("client", send_request: nil) }

      describe '#sync_custom_object' do
        context "without an operation" do
          it "calls send_request on the client with the correct params" do
            custom_object = instance_double(CustomObject, object_type_name: "type", to_sync_custom_object_hash: {"custom_object" => "hash"})
            client.extend(SyncCustomObject)
            client.sync_custom_object(custom_object)
            expect(client).to have_received(:send_request).with(:sync_custom_objects, {"objTypeName" => "type", "operation" => "UPSERT", "customObjList" => {"custom_object" => "hash"}})
          end
        end
        context "without an operation" do
          it "calls send_request on the client with the correct params" do
            custom_object = instance_double(CustomObject, object_type_name: "type", to_sync_custom_object_hash: {"custom_object" => "hash"})
            client.extend(SyncCustomObject)
            client.sync_custom_object(custom_object, "INSERT")
            expect(client).to have_received(:send_request).with(:sync_custom_objects, {"objTypeName" => "type", "operation" => "INSERT", "customObjList" => {"custom_object" => "hash"}})
          end
        end
      end

    end
  end
end
