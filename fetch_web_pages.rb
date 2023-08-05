require_relative 'web_page_fetcher'

if ARGV.empty?
  puts "Usage: ruby fetch_web_page.rb [--metadata] <URL1> <URL2> ..."
else
  base_dir = 'saved_web_pages'
  fetcher = WebPageFetcher.new(base_dir)

  if ARGV.first == '--metadata'
    urls = ARGV[1..-1]
    urls.each do |url|
      puts "Fetching #{url}..."
      fetcher.print_metadata(url)
      puts ""
    end
  else
    urls = ARGV
    urls.each do |url|
      puts "Fetching #{url}..."
      fetcher.fetch_and_save(url)
      puts ""
    end
  end
end
