require_relative 'web_page_fetcher'

if ARGV.empty?
  puts "Usage: ruby fetch_web_pages.rb [--metadata] <URL1> <URL2> ..."
else
  base_dir = 'saved_web_pages'
  fetcher = WebPageFetcher.new(base_dir)
  metadata = ARGV.include?('--metadata')
  with_assets = ARGV.include?('--with_assets')

  urls = ARGV.select { |arg| !arg.start_with?('--') }
  urls.each do |url|
    puts "Fetching #{url}..."
    fetcher.fetch_and_save(url, metadata: metadata, with_assets: with_assets)
    puts ""
  end
end
