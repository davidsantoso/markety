require 'markety/response/response_factory'

require 'markety/response/generic_response'
require 'markety/response/get_lead_response'
require 'markety/response/sync_lead_response'
require 'markety/response/list_operation_response'


module Markety
  # Each Command returns a corresponding Response.
  # All Response classes are derived from GenericResponse,
  # which contains some common accessor methods.
  module Response
  end
end
