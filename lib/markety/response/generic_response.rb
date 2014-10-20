module Markety
  module Response

    # Parent class for all response types.
    #
    # SOAP requests sent by Markety result in either
    # a <tt>Savon::Response</tt> or a <tt>Savon::SOAPFault</tt>.
    # This class hides those boring details from you,
    # unless you want to use its methods to see them.
    class GenericResponse
      #if the response is a <tt>Savon::SOAPFault</tt>, this is its error message
      attr_reader :error_message

      # * +cmd_type+ - a symbol
      # * +response+ - a <tt>Savon::Response</tt> or a <tt>Savon::SOAPFault</tt>
      def initialize(cmd_type,response)
        @response = response
        @success = response.is_a? Savon::Response
        @error_message = @success ? nil : response.to_s
      end

      # True if Marketo's response indicates that the SOAP request
      # was successful.
      #
      # *Note:* This is not the same as the a result from
      # a Marketo command itself!  To see the command's result,
      # consult the command-specific Response class.
      def success?
        @success
      end

      # Return the xml from the underlying <tt>Savon::Response</tt> or
      # <tt>Savon::SOAPFault</tt>
      def to_xml
        @success ? @response.to_xml : @response.http.raw_body
      end

      # The underlying <tt>Savon::Response</tt> or
      # <tt>Savon::SOAPFault</tt>'s content as a hash
      def to_hash
        @response.to_hash
      end
    end
  end
end
