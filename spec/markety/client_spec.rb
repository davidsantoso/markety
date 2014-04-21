require File.expand_path('../spec_helper', File.dirname(__FILE__))

module Markety
  describe Client do
    it 'should instantiate with a Savon client and authentication header' do
      client = Client.new(double('savon_client'), double('authentication_header'))
      client.class.should == Markety::Client
    end
  end
end
