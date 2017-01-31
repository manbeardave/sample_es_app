ELASTIC_SEARCH_CONFIG = YAML.load(ERB.new(Rails.root.join('config', 'es.yml').read).result)[Rails.env].symbolize_keys!
module Es
  class << self
    #
    # Moving this client code breaks development puma reloading
    # Let's leave it here until we figure out the best way to clean this up
    #
    def client
      @client ||= Elasticsearch::Client.new log: ELASTIC_SEARCH_CONFIG[:log], host: ELASTIC_SEARCH_CONFIG[:host], request_timeout: ELASTIC_SEARCH_CONFIG[:request_timeout], http: { cors: {enabled: true } }
    end
  end
end
