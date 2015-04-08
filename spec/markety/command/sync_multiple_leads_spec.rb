require 'spec_helper'

module Markety
  module Command
    describe SyncMultipleLeads do

      let(:client){ double("client", send_request: nil) }

      describe '#sync_multiple_leads' do
        it "calls send_request on the client with the correct params" do
          lead = double(Lead, synchronisation_hash: {"lead" => "hash1"})
          lead2 = double(Lead, synchronisation_hash: {"lead" => "hash2"})
          client.extend(SyncMultipleLeads)
          client.sync_multiple_leads([lead, lead2])
          expect(client).to have_received(:send_request).with(:sync_multiple_leads, {"leadRecordList" => {"leadRecord" => [{"lead" => "hash1"}, {"lead" => "hash2"}] }, "dedupEnabled" => true})
        end
      end
    end
  end
end
