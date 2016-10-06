# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be
# available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

task :default => [:cdl]

# There is still an issue with autoloading in ./config/application.rb so I'm
# coercing the loading of the parser and json_parser classes
desc 'Load parser.rb'
require './lib/feta/parser.rb'

desc 'Load json_parser.rb'
require './lib/feta/parsers/json_parser.rb'

desc 'Run CDL mappings'

task :cdl => :environment do  
  desc 'Load cdl mapping'
  require './lib/feta/metadata_mappings/cdl.rb'
  require './config/initializers/rails_config.rb'
  
  file = open('./original_records/b9c006084b95dc7e1e0288c95d2607be.json', 'rb').read
  orig = Feta::OriginalRecord.build('fake', file, 'json')
  mapped_records = Feta::Mapper.map(:cdl, [orig])
  puts mapped_records.first
  # agg = mapped_records.first
  # puts agg.dump(:ttl)
end
