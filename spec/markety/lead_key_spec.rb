require 'spec_helper'

module Markety
  describe LeadKeyType do
    it "should define the correct types" do
      LeadKeyType::IDNUM.should == 'IDNUM'
      LeadKeyType::COOKIE.should == 'COOKIE'
      LeadKeyType::EMAIL.should == 'EMAIL'
      LeadKeyType::LEADOWNEREMAIL.should == 'LEADOWNEREMAIL'
      LeadKeyType::SFDCACCOUNTID.should == 'SFDCACCOUNTID'
      LeadKeyType::SFDCCONTACTID.should == 'SFDCCONTACTID'
      LeadKeyType::SFDCLEADID.should == 'SFDCLEADID'
      LeadKeyType::SFDCLEADOWNERID.should == 'SFDCLEADOWNERID'
      LeadKeyType::SFDCOPPTYID.should == 'SFDCOPPTYID'
    end
  end

  describe LeadKey do
    KEY_VALUE = 'a value'
    KEY_TYPE = LeadKeyType::IDNUM

    it "should store type and value on construction" do
      lead_key = LeadKey.new(KEY_TYPE, KEY_VALUE)
      lead_key.key_type.should == KEY_TYPE
      lead_key.key_value.should == KEY_VALUE
    end

    it "should to_hash correctly" do
      lead_key = LeadKey.new(KEY_TYPE, KEY_VALUE)

      lead_key.to_hash.should == {
          "keyType" => KEY_TYPE,
          "keyValue" => KEY_VALUE
      }
    end
  end
end
