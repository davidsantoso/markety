require 'markety/response/generic_response'

module Markety
  module Response
    # Response class for Command::ListOperation calls
    class ListOperationResponse < GenericResponse

      def initialize(response)
        super(:list_operation_response,response)
        @list_operation_success = false

        if self.success?
          h = self.to_hash
          @list_operation_success = h[:success_list_operation][:result][:success]
        end
      end

      # Whether the operation was successful.
      #
      # *Note:* this is not the same as parent's success? method.
      # For list operations, success? almost always true
      # (because Marketo accepted the request and gave you a response).
      def list_operation_success?
        @list_operation_success
      end
      alias list_op_success? list_operation_success?
      alias lop_success? list_operation_success?
    end
  end
end
