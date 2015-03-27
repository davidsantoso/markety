require 'spec_helper'

module Markety
  module Response
    describe SyncCustomObjectResponse do
      let (:successful_response) {SavonHelper.create_response(File.read(File.expand_path("../../../fixtures/custom_objects/sync_custom_objects/successful_sync.xml", __FILE__)))}
      let (:failed_response) {SavonHelper.create_response(File.read(File.expand_path("../../../fixtures/custom_objects/sync_custom_objects/unknown_attribute.xml", __FILE__)))}

      describe "#success?" do
        context "with a successful response" do
          it "returns true" do
            response = SyncCustomObjectResponse.new(successful_response)
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

      describe "#error_message" do
        context "with a successful response" do
          it "returns nil" do
            response = SyncCustomObjectResponse.new(successful_response)
            expect(response.error_message).to be_nil
          end
        end
        context "with a failed response" do
          it "returns the error" do
            response = SyncCustomObjectResponse.new(failed_response)
            expect(response.error_message).to eq "Unknown name attribute list: nameasdf"
          end
        end
      end

      describe "#status" do
        context "with a successful response" do
          it "returns nil" do
            response = SyncCustomObjectResponse.new(successful_response)
            expect(response.status).to eq "UPDATED"
          end
        end
        context "with a failed response" do
          it "returns the status failed" do
            response = SyncCustomObjectResponse.new(failed_response)
            expect(response.status).to eq "FAILED"
          end
        end
      end

      describe "#updated_custom_object" do
        context "with a successful response" do
          it "returns the custom object" do
            response = SyncCustomObjectResponse.new(successful_response)
            expect(response.updated_custom_object.object_type_name).to eq "Roadshow"
            expect(response.updated_custom_object.keys).to eq({"MKTOID" => "1090177", "rid" => "rid1"})
          end
        end
        context "with a failed response" do
          it "returns nil" do
            response = SyncCustomObjectResponse.new(failed_response)
            expect(response.updated_custom_object).to be_nil
          end
        end
      end

    end
  end
end
