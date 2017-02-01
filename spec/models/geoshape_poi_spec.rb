require 'rails_helper'


RSpec.describe GeoshapePoi, type: :model, elasticsearch: true do
  describe 'search for geoshape_poi with polygon search of indexed Nielsen DMA', :elasticsearch => true do
    subject { GeoshapePoi.search_within_polygon(52) }
    it 'returns the state capital building of Iowa inside Des Moines Nielsen DMA' do
      expect(subject['hits']['hits'][0]['_source']['name']).to eq('Des Moines State Cap')
    end
  end
  
  
end
