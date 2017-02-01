class GeopointPoi < ApplicationRecord
    
    class << self

      def index_name
        "#{Rails.env}-geopoint-poi"
      end

      def template
        {
          'template' => "#{index_name}*",
          'mappings' => {
            'geopoint-poi' => {
              'properties' => {
                'name' => {
                  'type' => 'string'
                },
                'location' => {
                  'type' => 'geo_point'
                }
              }
            }
          }
        }
      end

      def put_template
        Es.client.indices.put_template name: "#{index_name}", body: template
      end

      def delete_template
        Es.client.indices.delete_template name: "#{index_name}"
      end

      # Not to be used in production
      def delete_index
        Es.client.indices.delete index: index_name
      end

      # Not to be used in production
      def bulk body
        Es.client.bulk index: index_name, body: body
      end
      
      def search_within_boundingbox
        body     = Query.geopoint_bounding_box
        response = Es.client.search(index: GeopointPoi.index_name, type: 'geopoint-poi', body: body)
      end
      
      def search_within_two_miles_of_carlsbad
        body     = Query.geopoint_distance_from_carlsbad
        response = Es.client.search(index: GeopointPoi.index_name, type: 'geopoint-poi', body: body)
      end
      
    end
  
end
