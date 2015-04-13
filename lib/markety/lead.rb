module Markety
  # Represents a record of the data known about a lead within Marketo
  class Lead
    attr_reader :types, :idnum, :attributes
    attr_accessor :foreign_sys_person_id, :email

    def initialize(email:nil, idnum:nil, foreign_sys_person_id:nil)
      @idnum      = idnum
      @foreign_sys_person_id = foreign_sys_person_id
      @email = email
      @attributes = {}
      @types      = {}
    end

    def ==(other)
      other.is_a?(Lead) &&
      @attributes==other.send(:attributes) &&
      @idnum==other.idnum &&
      @email==other.email &&
      @foreign_sys_person_id==other.foreign_sys_person_id
    end

    # hydrates an instance from a savon hash returned from the marketo API
    def self.from_hash(savon_hash)
      lead = Lead.new(email: savon_hash[:email], idnum:savon_hash[:id].to_i)

      unless savon_hash[:lead_attribute_list].nil?
        if savon_hash[:lead_attribute_list][:attribute].kind_of? Hash
          attributes = [savon_hash[:lead_attribute_list][:attribute]]
        else
          attributes = savon_hash[:lead_attribute_list][:attribute]
        end

        attributes.each do |attribute|
          lead.set_attribute(attribute[:attr_name], attribute[:attr_value], attribute[:attr_type])
        end
      end

      lead
    end


    # update the value of the named attribute
    def set_attribute(name, value, type = "string")
      @attributes[name] = value
      @types[name] = type
    end

    # get the value for the named attribute
    def get_attribute(name)
      @attributes[name]
    end

    # get the type of the named attribute
    def get_attribute_type(name)
      @types[name]
    end

    def synchronisation_hash
      keys_hash.merge({"leadAttributeList" => {"attribute" => attributes_soap_array}})
    end

  private

    def keys_hash
      keys_hash = {}
      keys_hash.merge!({"id" => idnum}) unless idnum.nil?
      keys_hash.merge!({"foreignSysPersonId" => foreign_sys_person_id}) unless foreign_sys_person_id.nil?
      keys_hash.merge!({"Email" => email}) unless email.nil?
      keys_hash
    end

    def attributes_soap_array
      arr = []
      @attributes.each_pair do |name,value|
        arr << {attr_name: name, attr_type: self.get_attribute_type(name), attr_value: value }
      end
      arr
    end

  end
end
