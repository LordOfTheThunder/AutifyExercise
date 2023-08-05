require_relative 'web_page_fetcher'

urls = ARGV.select { |arg| !arg.start_with?('--') }

if urls.empty?
  puts "Usage: ruby fetch_web_pages.rb [--metadata] [--with_assets] <URL1> <URL2> ..."
else
  base_dir = 'saved_web_pages'
  fetcher = WebPageFetcher.new(base_dir)
  metadata = ARGV.include?('--metadata')
  with_assets = ARGV.include?('--with_assets')

  urls.each do |url|
    puts "Fetching #{url}..."
    fetcher.fetch_and_save(url, metadata: metadata, with_assets: with_assets)
    puts ""
  end
end
