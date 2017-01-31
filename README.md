# Sample Rails App For ES 

                                          
                                                                                 ,,        ,,    ,,          
                                                                                *MM        db  `7MM          
                                                                                 MM              MM          
    `7M'   `MF'.gP"Ya `7Mb,od8 `7M'   `MF'.gP"Ya      `7MMpMMMb.pMMMb.  ,pW"Wq.  MM,dMMb.`7MM    MM  .gP"Ya  
      VA   ,V ,M'   Yb  MM' "'   VA   ,V ,M'   Yb       MM    MM    MM 6W'   `Wb MM    `Mb MM    MM ,M'   Yb 
       VA ,V  8M""""""  MM        VA ,V  8M""""""       MM    MM    MM 8M     M8 MM     M8 MM    MM 8M"""""" 
        VVV   YM.    ,  MM         VVV   YM.    ,       MM    MM    MM YA.   ,A9 MM.   ,M9 MM    MM YM.    , 
         W     `Mbmmd'.JMML.        W     `Mbmmd'     .JMML  JMML  JMML.`Ybmd9'  P^YbmdP'.JMML..JMML.`Mbmmd' 
                                                                               





## Getting Started

Thanks for checking out the repo, heres some guidelines to get you going!  I'm working off of the assumption that you will have a working installation of Ruby in order to utilize the tools here.  

##  Dependencies & Tools
  - brew
    - `brew install rvm`
    - `brew install mysql`
      - Create Launch Agent
        - `brew services start mysql`
    - `brew install elasticsearch`
      - Pre-Requisites (Java 1.7+)
        - `brew install Caskroom/cask/java`
      - Create Launch Agent
        - `To have launchd start elasticsearch at login:
            ln -sfv /usr/local/opt/elasticsearch/*.plist ~/Library/LaunchAgents
          Then to load elasticsearch now:
            launchctl load ~/Library/LaunchAgents/homebrew.mxcl.elasticsearch.plist
          Or, if you don't want/need launchctl, you can just run:
            elasticsearch`
  - gem
    - `gem install bundler`
  - rvm
    - `rvm install ruby-2.3.1`

## Usage

## Queries
