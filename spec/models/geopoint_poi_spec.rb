require 'rails_helper'


RSpec.describe GeopointPoi, type: :model, elasticsearch: true do

  describe 'search for pois within bounding box', :elasticsearch => true do
    subject { GeopointPoi.search_within_boundingbox }
    it 'should return 2 hits inside the box' do
      expect(subject['hits']['total']).to eq(2)
      ##expect this super tall bounding box described in the query body to return the two arbitrary geopoint_poi documents inside the box
    end
  end
  
  describe 'search for pois within 1km of carlsbad', :elasticsearch => true do
    subject { GeopointPoi.search_within_two_miles_of_carlsbad }
    it 'should return 2 hits inside the radius with Haversine math' do
      expect(subject['hits']['total']).to eq(1)
      ##expect this super tall bounding box described in the query body to return the two arbitrary geopoint_poi documents inside the box
    end
  end
  
  
end
