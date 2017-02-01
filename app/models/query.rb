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
                "index": "development-polygon",
                "type":  "polygon",
                "id": "#{polygon_es_id_for_query}",
                "path":  "location"
              }
          }
        }
      }
    }
    end
    
    
    
  end
end
