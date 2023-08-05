require 'uri'
require 'net/http'
require 'fileutils'

class WebPageFetcher
  def initialize(base_dir)
    @base_dir = base_dir
  end

  def fetch_page(url)
    uri = URI(url)
    Net::HTTP.get_response(uri)
  end

  def fetch_and_save(url)
    response = fetch_page(url)
    host = URI(url).host.gsub(/www\./, '')

    save_path = File.join(@base_dir, "#{host}.html")
    File.write(save_path, response.body)

    puts "Web page saved to #{save_path}"
  end

  def print_metadata(url)
    response = fetch_page(url)

    metadata = {
      'site' => URI(url).host,
      'num_links' => response.body.scan(/<a /i).count,
      'images' => response.body.scan(/<img /i).count,
      'last_fetch' => Time.now.utc.strftime('%a %b %d %Y %H:%M %Z')
    }

    puts "site: #{metadata['site']}"
    puts "num_links: #{metadata['num_links']}"
    puts "images: #{metadata['images']}"
    puts "last_fetch: #{metadata['last_fetch']}"
  end
end
