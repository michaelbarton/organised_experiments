require 'rake'
require 'active_record'
require 'yaml'

#load 'analysis/001_protein_length/analysis.rake'


Dir['analysis/*/*.rake'].each {|file| load File.join(File.dirname(__FILE__) ,'/',file) }

desc "Migrate the database through scripts in db/migrate. Target specific version with VERSION=x"  
task :migrate => :environment do  
  ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil )  
end 

task :environment do
    ActiveRecord::Base.establish_connection(YAML::load(File.open('db/database.yml')))  
    ActiveRecord::Base.logger = Logger.new $stderr

    Dir['models/*.rb'].each {|file| require file }
    
end
