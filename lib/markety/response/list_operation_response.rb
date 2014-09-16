require 'markety/response/generic_response'

class ListOperationResponse < GenericResponse

  def initialize(response)
    super(:list_operation_response,response)
    @list_operation_success = false

    if self.success?
      h = self.to_hash
      @list_operation_success = h[:success_list_operation][:result][:success]
    end
  end

  def list_operation_success?
    @list_operation_success
  end

end
