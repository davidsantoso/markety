require 'savon'
require 'logger'
require 'markety/authentication_header'
require 'markety/client'
require 'markety/command'
require 'markety/custom_object'
require 'markety/enums'
require 'markety/lead'
require 'markety/lead_key'
require 'markety/response'
require 'markety/version'


# To use Markety, the first thing you need to do is call
#   Markety.new_client(...)
# to create a Markety::Client object.  It is through methods
# on this object that you will send requests to Marketo.
#
# The request methods are defined and documented in the
# Markety::Command modules, which are all <tt>include</tt>d
# and accessible from Markety::Client.
#
# Every Markety request method returns a Markety::Response of some sort.
# All responses derive from Markety::Response::GenericResponse, which exposes
# basic information about the request's success or failure.
# The information you really want is in the appropriate subclass, e.g.
#
# *  Markety::Command::GetLead returns Markety::Response::GetLeadResponse
# *  Markety::Command::ListOperation returns Markety::Response::ListOperationResponse
# ... and so on
module Markety
end
