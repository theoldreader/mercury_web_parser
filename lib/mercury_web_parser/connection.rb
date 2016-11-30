require 'faraday'
require 'faraday_middleware'

module MercuryWebParser
  module Connection
    # Instantiate a Faraday::Connection
    # @private
    private

    # Returns a Faraday::Connection object
    #
    # @return [Faraday::Connection]
    def connection(options = {})
      options = {
        url: MercuryWebParser.api_endpoint
      }.merge(options)

      get_connection(options)
    end

    def get_connection(options)
      conn = Faraday.new(options) do |c|
        # encode request params as "www-form-urlencoded"
        c.use Faraday::Request::UrlEncoded

        c.use FaradayMiddleware::FollowRedirects, limit: 3

        # raise exceptions on 40x, 50x responses
        c.use Faraday::Response::RaiseError

        c.response :json, content_type: /\bjson$/

        c.adapter Faraday.default_adapter
      end

      conn.headers[:user_agent] = MercuryWebParser.user_agent
      conn.headers[:"x-api-key"] = MercuryWebParser.api_token

      conn
    end
  end # Connection
end
