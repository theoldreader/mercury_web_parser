require 'mercury_web_parser/configuration'
require 'mercury_web_parser/client'

module MercuryWebParser
  extend Configuration

  class << self
    # Alias for MercuryWebParser::Client.new
    #
    # @return [MercuryWebParser::Client]
    def new(options = {})
      MercuryWebParser::Client.new(options)
    end

    # Delegate to MercuryWebParser::Client
    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end

    def respond_to?(method, include_private = false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end

    def respond_to_missing?(method_name, include_private = false)
      Configuration::VALID_CONFIG_KEYS.include?(method_name) || super
    end
  end
end # MercuryWebParser
