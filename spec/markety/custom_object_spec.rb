require 'spec_helper'

module Markety
  describe CustomObject do

    describe '#object_type_name' do
      it "returns the name of the type of custom object" do
        custom_object = CustomObject.new(object_type_name: "Roadshow")
        expect(custom_object.object_type_name).to eq "Roadshow"
      end
    end

    describe '#get_key' do
      it "gets the key" do
        custom_object = CustomObject.new(object_type_name: "Roadshow", keys: {"MKTOID" => 123})
        expect(custom_object.get_key("MKTOID")).to eq 123
      end
    end

    describe '#keys' do
      it "returns all the keys" do
        custom_object = CustomObject.new(object_type_name: "Roadshow", keys: {"MKTOID" => 123, "rid" => 345})
        expect(custom_object.keys).to eq({"MKTOID" => 123, "rid" => 345})
      end
    end

    describe "#attributes" do
      it "returns the attributes" do
        custom_object = CustomObject.new(attributes: {"someAttribute" => "Value1", "anotherAttribute" => "Coconuts"})
        expect(custom_object.attributes).to eq({"someAttribute" => "Value1", "anotherAttribute" => "Coconuts"})
      end
    end

    describe "#to_sync_custom_object_hash" do
      it "returns a hash formatted for the sync_custom_object" do
        custom_object = CustomObject.new(
          object_type_name: "Roadshow",
          keys: {"MKTOID" => 123, "rid" => 345},
          attributes: {"name" => "Some Roadshow", "anotherAttribute" => "Bananas"})

        expect(custom_object.to_sync_custom_object_hash).to eq({
          "customObjKeyList" => {
            "attribute" => [
              {"attrName" => "MKTOID", "attrValue" => 123},
              {"attrName" => "rid", "attrValue" => 345}
            ]
          },
          "customObjAttributeList" => {
            "attribute" => [
              {"attrName" => "name", "attrValue" => "Some Roadshow"},
              {"attrName" => "anotherAttribute", "attrValue" => "Bananas"},
            ]
          }
        })
      end
    end

    describe ".from_marketo_hash" do
      let(:marketo_hash) {{:custom_obj_key_list=>{:attribute=>[{:attr_name=>"MKTOID", :attr_type=>nil, :attr_value=>"1090177"}, {:attr_name=>"rid", :attr_type=>nil, :attr_value=>"123456"}]}, :custom_obj_attribute_list=>{:attribute=>[{:attr_name=>"city", :attr_type=>nil, :attr_value=>"city4"}, {:attr_name=>"state", :attr_type=>nil, :attr_value=>"state4"}, {:attr_name=>"zip", :attr_type=>nil, :attr_value=>"zip4"}]}}}

      it 'returns a custom object and populates the keys' do
        custom_object = CustomObject.from_marketo_hash("Roadshow", marketo_hash)
        expect(custom_object.keys).to eq({"MKTOID" => "1090177", "rid" => "123456"})
      end

      it 'returns a custom object of the specified type' do
        custom_object = CustomObject.from_marketo_hash("Roadshow", marketo_hash)
        expect(custom_object.object_type_name).to eq "Roadshow"
      end

      it 'returns a custom object and populates the attributes' do
        custom_object = CustomObject.from_marketo_hash("Roadshow", marketo_hash)
        expect(custom_object.attributes).to eq({"city" => "city4", "state" => "state4", "zip" => "zip4"})
      end
    end

  end
end
