require 'spec_helper'

module Markety
  module Response
    describe LeadResponse do

      describe "#success?" do
        context "with a successful created status" do
          it "returns true" do
            response = LeadResponse.new({:lead_id=>"30609", :status=>"CREATED", :error=>nil})
            expect(response.success?).to eq true
          end
        end
        context "with a successful updated status" do
          it "returns true" do
            response = LeadResponse.new({:lead_id=>"30660", :status=>"UPDATED", :error=>nil})
            expect(response.success?).to eq true
          end
        end
        context "with a failed response" do
          it "returns false" do
            response = LeadResponse.new({:lead_id=>"60960", :status=>"FAILED", :error=>"some error"})
            expect(response.success?).to eq false
          end
        end
      end

      describe "#error_message" do
        it "returns the error" do
          response = LeadResponse.new({:lead_id=>"60960", :status=>"FAILED", :error=>"Lead Not Found"})
          expect(response.error_message).to eq "Lead Not Found"
        end
      end

      describe "#status" do
        it "returns the status" do
          response = LeadResponse.new({:lead_id=>"60960", :status=>"FAILED", :error=>"Lead Not Found"})
          expect(response.status).to eq "FAILED"
        end
      end

      describe "#lead_id" do
        it "returns the lead_id" do
          response = LeadResponse.new({:lead_id=>"60912360", :status=>"FAILED", :error=>"Lead Not Found"})
          expect(response.lead_id).to eq "60912360"
        end
      end

    end
  end
end
