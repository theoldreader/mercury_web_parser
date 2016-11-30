# Mercury Web Parser

A simple Ruby wrapper for the [Mercury Web Parser API][mercury-url]

[![Build Status][travis-badge]][travis] [![Code Climate][code-climate-badge]][code-climate]

[travis-badge]: https://travis-ci.org/theoldreader/mercury_web_parser.png
[travis]: http://travis-ci.org/theoldreader/mercury_web_parser
[code-climate-badge]: https://codeclimate.com/github/theoldreader/mercury_web_parser.png
[code-climate]: https://codeclimate.com/github/theoldreader/mercury_web_parser

## Installation
Add this line to your application's Gemfile:

    gem 'mercury_web_parser'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mercury_web_parser

## Configuration
You must first obtain an API token from the fine folks at [Mercury][mercury-url]
in order to make requests to their Web Parser API.

Single token usage

    MercuryWebParser.api_token = API_TOKEN

or set multiple options with a block:
```ruby
MercuryWebParser.configure do |parser|
  parser.api_token = API_TOKEN
end
```


Multiple tokens or multithreaded usage:

```ruby
client = MercuryWebParser::Client.new(api_token: API_TOKEN)
```

## Usage

### Parse

Parse a webpage and return its main content:

```ruby
article = MercuryWebParser.parse("http://sethgodin.typepad.com/seths_blog/2016/11/all-we-have-is-each-other.html")
=> #<MercuryWebParser::Article title="Seth's Blog", author=nil, date_published=nil, dek=nil, lead_image_url="http://www.sethgodin.com/sg/images/og.jpg", content="<div id=\"alpha-inner\" class=\"pkg\"> <div class=\"module-typelist module\">...", next_page_url="http://sethgodin.typepad.com/seths_blog/2016/11/choose-better.html", url="http://sethgodin.typepad.com/seths_blog/2016/11/all-we-have-is-each-other.html", domain="sethgodin.typepad.com", excerpt="", word_count=462, direction="ltr", total_pages=4, pages_rendered=4>

article.title
article.content
article.author
article.date_published
article.lead_image_url
article.dek
article.next_page_url
article.url
article.domain
article.excerpt
article.word_count
article.direction
article.total_pages
article.rendered_pages
```

## Inspiration
Clone of [readability_parser](https://github.com/phildionne/readability_parser) gem

[mercury-url]: https://mercury.postlight.com/web-parser/
