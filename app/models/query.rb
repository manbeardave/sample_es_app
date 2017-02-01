class Query < ApplicationRecord
  class << self 
    
    
    ##
    ## use this query body to search for geoshape poi documents within the nielsen dma polygon you supply, 52 = Des Moines
    ##
    def geoshape_polygon_within_body(polygon_es_id_for_query)
      {
        "query": {
          "geo_shape": {
            "location": {
              "relation": "within",
              "indexed_shape": { 
                "index": "test-polygon",
                "type":  "polygon",
                "id": "#{polygon_es_id_for_query}",
                "path":  "location"
              }
          }
        }
      }
    }
    end
    
    def geopoint_bounding_box
      {
          "query": {
              "bool": {
                  "must": {
                      "match_all": {}
                  },
                  "filter": {
                      "geo_bounding_box": {
                          "location": {
                              "top_left": {
                                  "lat": 34.2355338,
                                  "lon": -120.4623123
                              },
                              "bottom_right": {
                                  "lat": 32.1503148,
                                  "lon": -116.3327756
                              }
                          }
                      }
                  }
              }
          }
      }
    end
    
    def geopoint_distance_from_carlsbad
      {
          "query": {
              "bool": {
                  "must": {
                      "match_all": {}
                  },
                  "filter": {
                      "geo_distance": {
                          "distance": "1km",
                          "location": {
                            "lat":  33.12557521039472,
                            "lon": -117.31115965836284
                          }
                      }
                  }
              }
          }
      }
    end
    
    
  end
end
