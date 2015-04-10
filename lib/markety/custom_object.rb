module Markety
  class CustomObject

    attr_accessor :object_type_name, :keys, :attributes

    def initialize(object_type_name: "", keys: {}, attributes: {})
      @object_type_name = object_type_name
      @keys = keys
      @attributes = attributes
    end

    def get_key(key_name)
      @keys[key_name]
    end

    def to_sync_custom_object_hash
      {
        "customObjKeyList" => key_list,
        "customObjAttributeList" => attribute_list
      }
    end

    def self.from_marketo_hash(object_type_name, marketo_hash)
      keys = {}
      attributes = {}
      marketo_hash[:custom_obj_key_list][:attribute].each{|attribute| keys[attribute[:attr_name]] = attribute[:attr_value]}
      marketo_hash[:custom_obj_attribute_list][:attribute].each{|attribute| attributes[attribute[:attr_name]] = attribute[:attr_value]} if marketo_hash[:custom_obj_attribute_list]
      new(object_type_name: object_type_name, keys: keys, attributes: attributes)
    end

    private

    def key_list
      attributes_hash(keys)
    end

    def attribute_list
      attributes_hash(attributes)
    end

    def attributes_hash(attributes)
      {"attribute" => attributes.map{|key, value| {"attrName" => key, "attrValue" => value}}}
    end

  end
end
