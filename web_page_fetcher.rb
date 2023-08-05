require 'uri'
require 'net/http'
require 'fileutils'

class WebPageFetcher
  def initialize(base_dir)
    @base_dir = base_dir
  end

  def fetch_and_save(url, metadata: false)
    response = fetch_page(url)
    host = URI(url).host

    save_path = File.join(@base_dir, "#{host}.html")
    
    create_dir_if_missing

    File.write(save_path, response.body)

    if metadata
      print_metadata(url, response)
    end
  end

  private

  def fetch_page(url)
    uri = URI(url)
    Net::HTTP.get_response(uri)
  end

  def create_dir_if_missing
    unless File.directory?(@base_dir)
      FileUtils.mkdir_p(@base_dir)
    end
  end

  def print_metadata(url, fetched_page)
    metadata = {
      'site' => URI(url).host,
      'num_links' => fetched_page.body.scan(/<a /i).count,
      'images' => fetched_page.body.scan(/<img /i).count,
      'last_fetch' => Time.now.utc.strftime('%a %b %d %Y %H:%M %Z')
    }

    puts "site: #{metadata['site']}"
    puts "num_links: #{metadata['num_links']}"
    puts "images: #{metadata['images']}"
    puts "last_fetch: #{metadata['last_fetch']}"
  end
end
