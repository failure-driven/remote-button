# rails fetch_quotes[https://source.of.quotes.url]
desc "fetch quotes"
task :fetch_quotes, %i[quote_url] => :environment do |_, args|
  quote_url = args[:quote_url]
  doc = Nokogiri::HTML(open(quote_url).read)
  quotes = doc.search("ol").map do |ol|
    ol.search("li span")
    .map(&:text)
    .map(&:strip)
  end.flatten.filter{|quote| quote[0] == "“" }
  quotes.each do |quote|
    puts quote
  end

  # next find the subject (noun)
  # next replace subject with text "button"
end
