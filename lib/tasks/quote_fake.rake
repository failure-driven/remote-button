desc "fetch quotes"
task :fetch_quotes, [:environment, :quote_url] do |task, args|
  quote_url = args[:quote_url]
  puts quote_url
  doc = Nokogiri::HTML(open(quote_url).read)
  doc.search("ol").map { |ol| ol.search("li span").map(&:text).map(&:strip) }.flatten.filter {|quote| quote[0] == "“" }
end
