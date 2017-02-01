require 'rails_helper'


RSpec.describe GeoshapePoi, type: :model, elasticsearch: true do
  describe 'search for geoshape_poi with polygon search of test-index Nielsen DMA', :elasticsearch => true do
    ##52 is hardcoded, this corresponds to the id of the polygon I upload in the test index
    subject { GeoshapePoi.search_within_polygon(52) }
    it 'should return the state capital building of Iowa inside Des Moines Nielsen DMA' do
      expect(subject['hits']['hits'][0]['_source']['name']).to eq('Des Moines State Cap')
      ##expect geo_shape query to return the document representing the Des Moines 
    end
  end
  
  
end
