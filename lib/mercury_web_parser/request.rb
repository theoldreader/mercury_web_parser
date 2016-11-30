require 'mercury_web_parser/error'

module MercuryWebParser
  module Request
    # Performs a HTTP Get request
    def get(path, params = {})
      request(:get, path, params)
    end

    private

    # Returns a Faraday::Response object
    #
    # @return [Faraday::Response]
    def request(method, path, params = {})
      if api_token.nil?
        raise MercuryWebParser::Error::ConfigurationError,
              'Please configure MercuryWebParser.api_token first'
      end

      make_request(method, path, params)
    end

    def make_request(method, path, params)
      response = connection.send(method) do |request|
        request.url(path, params)
      end
      response.body
    rescue Faraday::ParsingError
      raise MercuryWebParser::Error::NotParseable, 'Unparseable response'
    rescue Faraday::Error::ClientError => error
      raise MercuryWebParser::Error::ClientError, error
    rescue => error
      raise MercuryWebParser::Error::RequestError, error
    end
  end # Request
end
