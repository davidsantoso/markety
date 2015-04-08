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
            expect(response.lead_responses).to eq [{:lead_id => "1090240", :status => "UPDATED", :error => nil}, {:lead_id => "1090239", :status => "UPDATED", :error => nil}]
          end
        end
        context "with a single update" do
          it "returns an array of hashes containing the lead response" do
            response = SyncMultipleLeadsResponse.new(single_response)
            expect(response.lead_responses).to eq [{:lead_id => "1090240", :status => "UPDATED", :error => nil}]
          end
        end
      end

    end
  end
end
