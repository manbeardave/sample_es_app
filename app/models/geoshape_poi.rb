class GeoshapePoi < ApplicationRecord
    
    class << self

      def index_name
        "#{Rails.env}-geoshape-poi"
      end

      def template
        {
          'template' => "#{index_name}*",
          'mappings' => {
            'geoshape-poi' => {
              'properties' => {
                'name' => {
                  'type' => 'string'
                },
                'location' => {
                  'type' => 'geo_shape'
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
      def search_within_polygon(id)
        body     = Query.geoshape_polygon_within_body(id)
        response = Es.client.search(index: GeoshapePoi.index_name, type: 'geoshape-poi', body: body)
      end
    end
  
end
