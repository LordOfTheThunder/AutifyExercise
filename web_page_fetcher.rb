require 'uri'
require 'net/http'
require 'fileutils'

class WebPageFetcher
  def initialize(base_dir)
    @base_dir = base_dir
  end

  def fetch_and_save(url, metadata: false, with_assets: false)
    response = fetch_page(url)
    host = URI(url).host

    save_path = File.join(@base_dir, "#{host}.html")
    
    create_dir_if_missing

    File.write(save_path, response.body)

    save_assets(response.body, host) if with_assets
    print_metadata(url, response) if metadata
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

  def save_assets(html_content, host)
    html_content.scan(/(src|href)=["'](.*?)["']/i).each do |match|
      asset_url = match[1]
      next if asset_url.start_with?('data:') || asset_url.start_with?('#')

      begin
        asset_uri = URI.join("http://#{host}", asset_url)
      rescue URI::InvalidURIError
        puts "Invalid URI: #{asset_url}"
        next
      end

      asset_response = Net::HTTP.get_response(asset_uri)
      asset_filename = "#{File.basename(asset_url)}"
      asset_save_path = File.join(@base_dir, asset_filename)

      puts "writing asset: #{asset_filename}"
      
      begin
        File.write(asset_save_path, asset_response.body)
      rescue Errno::EISDIR
        puts "Trying to write to a dir instead of a file. Skip..."
        next
      end 
    end
  end
end
