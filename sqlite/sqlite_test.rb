# http://www.themomorohoax.com/2009/03/15/activerecord-sqlite-in-memory-db-without-rails

require 'yaml'
require 'active_record'
dbconf = YAML::load(File.open('./database.yml'))  
ActiveRecord::Base.establish_connection(dbconf) 

ActiveRecord::Migrator.up('migrate')