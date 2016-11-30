module MercuryWebParser
  module API
    module Content
      # Parse a webpage and return its main content
      # Returns a MercuryWebParser::Article object
      #
      # @param url [String] The URL of an article to return the content for
      # @return [MercuryWebParser::Article]
      def parse(url)
        response = get('', url: url)

        MercuryWebParser::Article.new(response)
      end
    end # Content
  end # API
end
