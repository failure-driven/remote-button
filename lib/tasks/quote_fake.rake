# rails fetch_quotes[https://source.of.quotes.url]
desc "fetch quotes"
task :fetch_quotes, %i[quote_url] => :environment do |_, args|
  quote_url = args[:quote_url]
  doc = Nokogiri::HTML(URI.parse(quote_url).open.read)
  quotes = doc.search("ol").map do |ol|
    ol.search("li span")
      .map(&:text)
      .map(&:strip)
  end
  quotes
    .flatten
    .filter { |quote| quote[0] == "“" }
    .each do |quote|
    # puts quote.gsub("“", "").gsub(/”.*$/, "")
    puts quote
  end

  # next find the subject (noun)
  # next replace subject with text "button"
  # maybe using python TextBlob
  #
  #   pip3 install TextBlob
  #   python3
  #   >>> from textblob import TextBlob
  #   >>> txt = """Natural language processing (NLP) is a field of computer
  #   science, artificial intelligence, and computational linguistics concerned
  #   with the inter actions between computers and human (natural)
  #   languages."""
  #   >>> blob = TextBlob(txt)
  #   >>> print(blob.noun_phrases)
  #
  # OR
  #
  #   pip3 install nltk
  #   python3
  #   import nltk
  #   lines = 'lines is some string of words'
  #   # function to test if something is a noun
  #   is_noun = lambda pos: pos[:2] == 'NN'
  #   # do the nlp stuff
  #   tokenized = nltk.word_tokenize(lines)
  #   nouns = [word for (word, pos) in nltk.pos_tag(tokenized) if is_noun(pos)]
  #   print nouns
  #   ['lines', 'string', 'words']
end
