require 'spec_helper'

module Markety
  module Response
    describe SyncCustomObjectResponse do
      let (:successful_response) {SavonHelper.create_response(File.read(File.expand_path("../../../fixtures/custom_objects/sync_custom_objects/successful_sync.xml", __FILE__)))}
      let (:successful_multiple_sync_response) {SavonHelper.create_response(File.read(File.expand_path("../../../fixtures/custom_objects/sync_custom_objects/multiple_syncs.xml", __FILE__)))}
      let (:failed_response) {SavonHelper.create_response(File.read(File.expand_path("../../../fixtures/custom_objects/sync_custom_objects/invalid_object_name.xml", __FILE__)))}

      describe "#success?" do
        context "with a successful response with a single sync" do
          it "returns true" do
            response = SyncCustomObjectResponse.new(successful_response)
            expect(response.success?).to eq true
          end
        end
        context "with a successful response with multiple syncs" do
          it "returns true" do
            response = SyncCustomObjectResponse.new(successful_multiple_sync_response)
            expect(response.success?).to eq true
          end
        end
        context "with a failed response" do
          it "returns false" do
            response = SyncCustomObjectResponse.new(failed_response)
            expect(response.success?).to eq false
          end
        end
      end

      describe "#custom_objects" do
        context "with a successful response with a single sync" do
          it "returns the custom object" do
            response = SyncCustomObjectResponse.new(successful_response)
            custom_objects = response.custom_objects
            expect(custom_objects.size).to eq 1
            expect(custom_objects.first.object_type_name).to eq "Roadshow"
            expect(custom_objects.first.keys).to eq({"MKTOID" => "1090177", "rid" => "rid1"})
          end
        end
        context "with a successful response with multiple syncs" do
          it "returns multiple custom objects" do
            response = SyncCustomObjectResponse.new(successful_multiple_sync_response)
            custom_objects = response.custom_objects
            expect(custom_objects.size).to eq 2
            expect(custom_objects[1].object_type_name).to eq "Roadshow"
            expect(custom_objects[1].keys).to eq({"MKTOID" => "1090178", "rid" => "rid2"})
          end
        end
        context "with a failed response" do
          it "returns nil" do
            response = SyncCustomObjectResponse.new(failed_response)
            expect(response.custom_objects).to eq []
          end
        end
      end

    end
  end
end
