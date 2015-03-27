require 'markety/command/get_lead'
require 'markety/command/sync_lead'
require 'markety/command/get_custom_object'
require 'markety/command/sync_custom_object'
require 'markety/command/list_operation'

module Markety
  # All Command submodules are included in the Markety::Client class.
  # They are implemented in separate modules only for maintainability
  # (specifically, to keep Markety::Client from becoming huge).
  module Command
  end
end
