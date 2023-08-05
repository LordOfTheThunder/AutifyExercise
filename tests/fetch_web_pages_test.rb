require 'minitest/autorun'
require 'webmock/minitest'
require_relative '../web_page_fetcher'

class TestWebPageFetcher < Minitest::Test
  def test_fetch_and_save_success
    fetcher = WebPageFetcher.new('test_data')
    url = 'https://www.example.com'

    stub_request(:any, url).to_return(status: 200, body: 'Mocked HTML')  # Stub the HTTP request

    fetcher.fetch_and_save(url)

    assert File.exist?('test_data/www.example.com.html')
  end

  def test_fetch_and_save_failure
    fetcher = WebPageFetcher.new('test_data')
    url = 'https://www.invalidurl.com'

    stub_request(:any, url).to_return(status: 404)  # Stub the HTTP request

    fetcher.fetch_and_save(url)

    assert !File.exist?('test_data/www.invalidurl_com.html')
  end
end
