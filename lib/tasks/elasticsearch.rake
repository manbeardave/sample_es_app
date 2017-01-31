require 'json'
namespace :elasticsearch do

  desc 'deletes indexes and templates'
  task :down => :environment do
    Rake::Task["elasticsearch:delete_indexes"].invoke
    Rake::Task["elasticsearch:delete_templates"].invoke
  end

  desc 'init templates and load data'
  task :up => :environment do
    Rake::Task["elasticsearch:put_templates"].invoke
    Rake::Task["elasticsearch:load_test_data"].invoke
  end

  desc 'list templates'
  task :templates => :environment do
    result =  Es.client.indices.get_template
    puts JSON.pretty_unparse result
  end

  desc 'put templates'
  task :put_templates => :environment do
    # TODO check to see if it exists
    # Es::Place.put_template
    # Es::Device.put_template
    # Es::Audience.put_template
    Poi.put_template
    Polygon.put_template
    result = Es.client.indices.get_template
    puts JSON.pretty_unparse result
  end

  desc 'delete templates'
  task :delete_templates => :environment do
    response = Es.client.indices.get_template
    response.keys.each do |k|
      STDOUT.puts "\nAre you sure you want to delete template #{ELASTIC_SEARCH_CONFIG[:host]}/#{k}? (y/n)"
      input = STDIN.gets.strip
      Es.client.indices.delete_template name: k if input == 'y'
    end
  end

  desc 'create snapshot repository'
  task :create_snapshots => :environment do
    Es.client.snapshot.create_repository(
      repository: 'backup',
      body: {
       type: 'fs',
       settings: {
         location: 'data/es/backup',
         compress: true
       }
     }
    )
  end

  desc 'delete indexes'
  task :delete_indexes => :environment do
    return "NO" if :environment == 'production'
    [Polygon, Poi].each do |k|
      STDOUT.puts "\nAre you sure you want to delete index #{ELASTIC_SEARCH_CONFIG[:host]}/#{k.index_name}? (y/n)"
      input = STDIN.gets.strip
      if input == 'y'
        puts k.delete_index rescue "ERROR"
      end
    end
  end
  
  desc 'create bulk data for nielsen polygons'
  task :gen_es_data => :environment do 
    data  = JSON.parse(File.read(File.join( Rails.root, "spec", "fixtures", "geojson_nielsen_dmas.json")))
    data['features'].each_with_index do |x,i|
      points = x['geometry']['coordinates']
      name   = x['properties']['dma1']
      type   = x['geometry']['type']
      open(File.join( Rails.root, "spec", "fixtures", "polygons_FINAL_bulk.txt"), 'a') do |f|
        f.puts "{\"index\": { \"_type\": \"polygon\", \"_id\": #{i} } }"
        f.puts "{\"name\": \"#{name}\", \"location\": { \"type\": \"#{type.downcase}\", \"coordinates\": #{points}}}"
      end
    end
  end


  desc 'load test data'
  task :load_test_data => :environment do
    # bulk upload place documents
    places_txt  = File.open(File.join( Rails.root, "spec", "fixtures", "places_bulk.txt")).read.split("/n").collect { |row| row }
    polygon_txt = File.open(File.join( Rails.root, "spec", "fixtures", "polygons_FINAL_bulk.txt")).read.split("/n").collect { |row| row }
    Polygon.bulk polygon_txt
    Poi.bulk places_txt
  end

end
