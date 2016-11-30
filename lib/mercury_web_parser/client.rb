require 'mercury_web_parser/connection'
require 'mercury_web_parser/request'
require 'mercury_web_parser/api/content'
require 'mercury_web_parser/article'

module MercuryWebParser
  class Client
    attr_accessor(*Configuration::VALID_CONFIG_KEYS)

    def initialize(options = {})
      options = MercuryWebParser.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    include MercuryWebParser::Connection
    include MercuryWebParser::Request
    include MercuryWebParser::API::Content
  end # Client
end
