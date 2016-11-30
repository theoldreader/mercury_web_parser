module MercuryWebParser
  class Error < StandardError
    # Raised when Mercury returns a 4xx or 500 HTTP status code
    class ClientError < Error
      # Creates a new error from an HTTP environement
      #
      # @param response [Hash]
      # @return [MercuryWebParser::Error::ClientError]
      def initialize(error = nil)
        http_error = error.response[:status].to_i

        if ERROR_MAP.key?(http_error)
          raise ERROR_MAP[http_error], error.response[:body]['message']
        end

        super
      end
    end # ClientError

    class ConfigurationError < MercuryWebParser::Error; end

    # Raised when there's an error in Faraday
    class RequestError < MercuryWebParser::Error; end

    # Raised when MercuryWebParser returns a 400 HTTP status code
    class BadRequest < MercuryWebParser::Error; end

    # Raised when the response from the parser is null
    class NotParseable < MercuryWebParser::Error; end

    # Raised when MercuryWebParser returns a 401 HTTP status code
    class UnauthorizedRequest < MercuryWebParser::Error; end

    # Raised when MercuryWebParser returns a 403 HTTP status code
    class Forbidden < MercuryWebParser::Error; end

    # Raised when MercuryWebParser returns a 404 HTTP status code
    class NotFound < MercuryWebParser::Error; end

    # Raised when MercuryWebParser returns a 500 HTTP status code
    class InternalServerError < MercuryWebParser::Error; end

    ERROR_MAP = {
      400 => MercuryWebParser::Error::BadRequest,
      401 => MercuryWebParser::Error::UnauthorizedRequest,
      403 => MercuryWebParser::Error::Forbidden,
      404 => MercuryWebParser::Error::NotFound,
      500 => MercuryWebParser::Error::InternalServerError
    }.freeze
  end # Error
end
