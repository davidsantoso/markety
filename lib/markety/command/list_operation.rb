module Markety
  module Command
    module ListOperation

      # In all these functions:
      #   * The only expected option is "strict", a boolean.  Default: true
      #   * If you pass in a Lead and it doesn't have an idnum, an exception will be thrown

      # All ListOp failures are look similar, and all successes look similar.
      # It doesn't matter which op, or why it succeeds or fails.

      # note: If you add something already in the list, it's a success.
      def add_to_list(list_name, lead_or_idnum, options={})
        list_operation(list_name, ListOperationType::ADD_TO, lead_or_idnum, options)
      end

      # note: If you remove something that's not in the list, it's a failure.
      def remove_from_list(list_name, lead_or_idnum, options={})
        list_operation(list_name, ListOperationType::REMOVE_FROM, lead_or_idnum, options)
      end

      def is_member_of_list(list_name, lead_or_idnum, options={})
        list_operation(list_name, ListOperationType::IS_MEMBER_OF, lead_or_idnum, options)
      end

    private

      def list_operation(list_name, list_operation_type, lead_or_idnum, options)
        idnum = lead_or_idnum
        if lead_or_idnum.is_a? Markety::Lead
          raise "Lead has no idnum, which this command needs" unless lead_or_idnum.idnum
          idnum = lead_or_idnum.idnum
        end

        strict = options.has_key?(:strict) ? !!options[:strict] : true

        strict = !!options[:strict]
        send_request(:list_operation, {
          list_operation: list_operation_type,
          strict: strict,
          list_key: {
            key_type: 'MKTOLISTNAME',
            key_value: list_name
          },
          list_member_list: {
            lead_key: [{
              key_type: 'IDNUM',
              key_value: idnum
            }]
          }
        })
      end
    end
  end
end
