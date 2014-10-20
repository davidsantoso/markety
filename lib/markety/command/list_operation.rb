module Markety
  module Command
    # ListOperation commands return Response::ListOperationResponse objects.
    #
    # In all these functions:
    # * An exception will be thrown if you pass in a Lead and it doesn't have an idnum
    # * Allowed options:
    #   [strict]  From {Marketo's docs}[http://developers.marketo.com/documentation/soap/listoperation/]: <em>Strict mode will fail for the entire operation if any subset of the call fails.  Non-strict mode will complete everything it can and return errors for anything that failed.</em>
    #
    # All ListOp failures look similar, and all successes look similar.
    module ListOperation

      # note: If you add something that's already in the list, ListOperationResponse::list_operation_success? will be +true+
      def add_to_list(list_name, lead_or_idnum, options={})
        list_operation(list_name, "ADDTOLIST", lead_or_idnum, options)
      end

      # note: If you remove something that's not in the list, ListOperationResponse::list_operation_success? will be +false+
      def remove_from_list(list_name, lead_or_idnum, options={})
        list_operation(list_name, "REMOVEFROMLIST", lead_or_idnum, options)
      end

      # ListOperationResponse::list_operation_success? is the result of this query
      def is_member_of_list(list_name, lead_or_idnum, options={})
        list_operation(list_name, "ISMEMBEROFLIST", lead_or_idnum, options)
      end

    private

      ADD_TO       = 'ADDTOLIST'        # :nodoc:
      REMOVE_FROM  = 'REMOVEFROMLIST'   # :nodoc:
      IS_MEMBER_OF = 'ISMEMBEROFLIST'   # :nodoc:
      private_constant :ADD_TO
      private_constant :REMOVE_FROM
      private_constant :IS_MEMBER_OF

      ALLOWED_OPS = [ADD_TO,REMOVE_FROM,IS_MEMBER_OF]   # :nodoc:
      private_constant :ALLOWED_OPS

      def list_operation(list_name, list_operation_type, lead_or_idnum, options)
        raise "Unknown list operation type" unless ALLOWED_OPS.include?(list_operation_type)
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
