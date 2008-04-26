require 'rake'
require 'active_record'
require 'yaml'

ActiveRecord::Base.establish_connection(YAML::load(File.open('db/database.yml')))  

Dir['analysis/*/*.rake'].each {|file| load File.join(File.dirname(__FILE__) ,'/',file) }
Dir['models/*.rb'].each {|file| require file }


desc "Migrate the database through scripts in db/migrate. Target specific version with VERSION=x"  
task :migrate do  
  ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil )  
end 
