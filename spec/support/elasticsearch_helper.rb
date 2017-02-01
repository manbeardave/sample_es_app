require 'rake'
load File.join(Rails.root, 'lib', 'tasks', 'es.rake')  


RSpec.configure do |config|
  config.around :each, elasticsearch: true do |example|
    
    [GeoshapePoi, Polygon, GeopointPoi].each do |model|
      model.put_template
      # TODO validate that each response is acknowledged ex {"acknowledged":true}
    end
    
    geoshape_poi_txt  = File.open(File.join( Rails.root, "spec", "fixtures", "geoshape_poi_bulk.txt")).read.split("/n").collect { |row| row }
    geopoint_poi_txt  = File.open(File.join( Rails.root, "spec", "fixtures", "geopoint_poi_bulk.txt")).read.split("/n").collect { |row| row }
    polygon_txt       = File.open(File.join( Rails.root, "spec", "fixtures", "polygons_test_bulk.txt")).read.split("/n").collect { |row| row }
    Polygon.bulk polygon_txt
    GeoshapePoi.bulk geoshape_poi_txt
    GeopointPoi.bulk geopoint_poi_txt
    Es.client.indices.refresh
    
    # TODO validate that each bulk upload is successful ex: {"errors":false
    # If either of these fail we need to fail the test and set a good error message
    example.run

    [GeoshapePoi, Polygon, GeopointPoi].each do |model|
      model.delete_template
      model.delete_index
      # TODO ensure these responses are {"acknowledged":true} otherwise we need to raise an error
    end
  end
end


