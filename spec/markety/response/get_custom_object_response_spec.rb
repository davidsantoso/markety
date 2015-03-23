require 'spec_helper'

module Markety
  module Response
    describe GetCustomObjectResponse do

      context "when there is one custom object found" do

        let (:savon_resp) {SavonHelper.create_response(File.read(File.expand_path("../../../fixtures/custom_objects/get_custom_objects/one_custom_object_found.xml", __FILE__)))}

        describe "#success" do
          it "returns true" do
            response = GetCustomObjectResponse.new(savon_resp)
            expect(response.success?).to eq true
          end
        end

        describe "#custom_objects" do
          it "contains one custom object" do
            response = GetCustomObjectResponse.new(savon_resp)
            expect(response.custom_objects.size).to eq 1
          end
        end

        describe "#custom_object" do
          it "returns the custom object" do
            response = GetCustomObjectResponse.new(savon_resp)
            expect(response.custom_object.object_type_name).to eq "Roadshow"
            expect(response.custom_object.keys).to eq({"MKTOID" => "1090177", "rid" => "123456"})
          end
        end

      end

      context "when there are multiple custom objects found" do
        let (:savon_resp) {SavonHelper.create_response(File.read(File.expand_path("../../../fixtures/custom_objects/get_custom_objects/multiple_custom_objects_found.xml", __FILE__)))}

        it "is a successful response" do
          response = GetCustomObjectResponse.new(savon_resp)
          expect(response.success?).to eq true
        end

        describe "#custom_objects" do
          it "contains multiple custom objects" do
            response = GetCustomObjectResponse.new(savon_resp)
            expect(response.custom_objects.size).to eq 6
          end
        end

        describe "#custom_object" do
          it "returns the custom object" do
            response = GetCustomObjectResponse.new(savon_resp)
            expect(response.custom_object.object_type_name).to eq "Roadshow"
            expect(response.custom_object.attributes).to eq({"city" => "city4", "state" => "state4", "zip" => "zip4"})
          end
        end

      end

      context "when there are no custom object found" do
        let (:savon_resp) {SavonHelper.create_response(File.read(File.expand_path("../../../fixtures/custom_objects/get_custom_objects/no_custom_objects_found.xml", __FILE__)))}
        let (:response) {GetCustomObjectResponse.new(savon_resp)}

        it "is a successful response" do
          expect(response.success?).to eq true
        end

        it "has no custom objects" do
          expect(response.custom_objects).to be_empty
        end
      end

    end
  end
end
