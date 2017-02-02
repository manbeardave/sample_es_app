# Sample Rails App For ES                                           
                                                                                                       
                                                                            
                                       `7M'   `MF'.gP"Ya `7Mb,od8 `7M'   `MF'.gP"Ya     
                                         VA   ,V ,M'   Yb  MM' "'   VA   ,V ,M'   Yb    
                                          VA ,V  8M""""""  MM        VA ,V  8M""""""    
                                           VVV   YM.    ,  MM         VVV   YM.    ,    
                                            W     `Mbmmd'.JMML.        W     `Mbmmd'
                                  
                                                                                                                     

## Getting Started

Thanks for checking out the repo, heres some guidelines to get you going!  

##  Dependencies 
  - If you haven't installed Ruby, I'd recommend using RVM - in fact, I'd also recommend using their command to install rails with your version of Ruby.  Find their [install guide here](https://rvm.io/rvm/install)
  - Additionally if is your first time installing rails, you'll need to install the bundler gem to work with rails - use your CLI like so: 
  - `gem install bundler` 
  - If you haven't already installed elasticsearch, I'd use brew and follow their instructions: 
    - `brew install elasticsearch`
    - after you install elasticsearch, make sure it is running either in the background or in a terminal window! This will run at localhost:9200 and it is where the app will be posting templates, mapping, and documents! 
    
## Tools 
  - [ElasticSearch Head Plugin](https://github.com/mobz/elasticsearch-head)
    - Not mandatory but super helpful to browse your indexed documents
    - Run in separate terminal window and then access at localhost:9100 within browser
    - Note that in order to do this, with ES5+, you'll have to edit your brew installation of elasticsearch yml file - located here: 
    
    `vim /usr/local/etc/elasticsearch/elasticsearch.yml`
    
    - with this text below:
  
  `http.cors.enabled: true 
   http.cors.allow-origin: "*"`

## Quickstart

  Within your CLI, navigate to the directory of this app, and run: 
  
  `bundle install`
  
  Assuming you have elasticsearch, Ruby, and Rails installed, this should install all the gem dependencies of the rails app.  The only non-rails default gems I added for this project are:
  - rspec, my preferred testing suite
  - elasticsearch, for interfacing with es
  - pry, my preferred debugging tool
  
  after the bundle install is complete, you are ready to run the tests; 
  
  `RAILS_ENV=test rspec`
  
   This command will run a simple test suite which stands up 3 indexes at localhost:9200, runs a single test, and then tears down the instance.  This will happen for every test in each spec file you have marked with elasticsearch:true.  So for example, we have 3 tests - for each test, we are creating a completely clean index.  

## Usage

  In this app, we utilize the Elasticsearch gem to interact between Rails and ES.  Find query structure's in the Query model, and then use the ES to take those query structures and search the models in question.  
  
  There are a number of tasks available to you in the es.rake file - stand up development indexes, tear them down, post mappings, delete them, and upload sample documents for queries.  
  
  Additionally if you check out the fixtures directory, you'll notice the handy-dandy GeoJSON Nielsen DMAs - feel free to utilize these polygons in your queries!