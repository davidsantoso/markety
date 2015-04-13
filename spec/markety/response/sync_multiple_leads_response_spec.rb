require 'spec_helper'

module Markety
  module Response
    describe SyncMultipleLeadsResponse do
      let (:successful_response) {SavonHelper.create_response(File.read(File.expand_path("../../../fixtures/leads/sync_multiple_leads/successful_response.xml", __FILE__)))}
      let (:single_response) {SavonHelper.create_response(File.read(File.expand_path("../../../fixtures/leads/sync_multiple_leads/single_response.xml", __FILE__)))}

      describe "#lead_responses" do
        context "with multiple updates" do
          it "returns an array of hashes containing the lead responses" do
            response = SyncMultipleLeadsResponse.new(successful_response)
            first_lead_response, second_lead_response = response.lead_responses[0], response.lead_responses[1]
            expect(first_lead_response.success?).to eq true
            expect(first_lead_response.lead_id).to eq "1090240"
            expect(second_lead_response.success?).to eq true
            expect(second_lead_response.lead_id).to eq "1090239"
          end
        end
        context "with a single update" do
          it "returns an array of hashes containing the lead response" do
            response = SyncMultipleLeadsResponse.new(single_response)
            lead_response = response.lead_responses.first
            expect(response.lead_responses.size).to eq 1
            expect(lead_response.lead_id).to eq "1090240"
            expect(lead_response.success?).to eq true
          end
        end
      end

    end
  end
end
