ENV['ELASTICSEARCH_URL'] = ENV['BONSAI_URL']

if ENV['BONSAI_INDEX_URL']
  bonsai_uri = URI.parse(ENV['BONSAI_INDEX_URL'])
  Tire.configure do
    url "http://index.bonsai.io"
  end
  BONSAI_INDEX_NAME = bonsai_uri.path[1..-1]
else
  BONSAI_INDEX_NAME = "rubyclopedia"
end