require 'spec_helper'

describe MercuryWebParser::Client do
  after do
    MercuryWebParser.reset!
  end

  context 'with module configuration' do
    before do
      MercuryWebParser.configure do |config|
        MercuryWebParser::Configuration::VALID_CONFIG_KEYS.each do |key|
          config.send("#{key}=", key)
        end
      end
    end

    it 'inherits the module configuration' do
      MercuryWebParser::Configuration::VALID_CONFIG_KEYS.each do |key|
        expect(MercuryWebParser.method(:"#{key}")).to be_a_kind_of(Method)
        expect(MercuryWebParser.send(:"#{key}")).to eq(key)
      end
    end
  end

  context 'with class configuration' do
    before do
      @configuration = {
        api_token: '1234'
      }
    end

    it 'overrides the module configuration after initialization' do
      MercuryWebParser.configure do |config|
        @configuration.each do |key, value|
          config.send("#{key}=", value)
        end
      end

      MercuryWebParser::Configuration::VALID_OPTIONS_KEYS.each do |key|
        expect(MercuryWebParser.send(:"#{key}")).to eq(@configuration[key])
      end
    end
  end

  describe '#connection' do
    it 'looks like Faraday connection' do
      expect(subject.send(:connection)).to respond_to(:run_request)
    end
  end

  describe '#request' do
    before do
      MercuryWebParser.api_token = '1234'
    end

    it 'successfully parses a page' do
      VCR.use_cassette('successful') do
        url = 'https://medium.com/@readability/the-readability-bookmarking-service-will-shut-down-on-september-30-2016-1641cc18e02b'
        article = MercuryWebParser.parse(url)
        expect(article.title).to match(/The Readability bookmarking service/)
        expect(article.content).to match(/receive an email/)
        expect(article.author).to eq('Readability')
        expect(article.date_published).to eq('2016-09-02T18:43:59.864Z')
        expect(article.lead_image_url).to be_nil
        expect(article.dek).to be_nil
        expect(article.next_page_url).to be_nil
        expect(article.url).to eq(url)
        expect(article.domain).to eq('medium.com')
        expect(article.excerpt).to match(/more than five years/)
        expect(article.word_count).to eq(151)
        expect(article.direction).to eq('ltr')
        expect(article.total_pages).to eq(1)
        expect(article.rendered_pages).to eq(1)
      end
    end

    it 'catches Faraday connection errors' do
      VCR.use_cassette('connection_errors') do
        expect { MercuryWebParser.parse('http://www.google.com') }.to(
          raise_error(MercuryWebParser::Error::UnauthorizedRequest)
        )
      end
    end

    it 'catches Mercury Web Parser API errors' do
      VCR.use_cassette('parser_errors') do
        expect { MercuryWebParser.parse('http://abc.go.com/robots.txt') }.to(
          raise_error(MercuryWebParser::Error::NotParseable)
        )
      end
    end
  end
end
