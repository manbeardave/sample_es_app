require 'json'
namespace :query do
  
  desc 'query for points inside the Nielsen DMA'
  task :geoshape => :environment do
    ## 52 is hardcoded right now, move this method to a class and make it dynamic.
    ## 52 = Des Moines Polygon, bulk loaded into es from spec/fixtures/  
    body     = Query.geoshape_polygon_within_body(52)
    response = Es.client.search(index: GeoshapePoi.index_name, type: 'geoshape-poi', body: body)
    puts response
  end
end
