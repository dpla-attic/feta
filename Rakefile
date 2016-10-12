# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be
# available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

task default: [:cdl]

# There is still an issue with autoloading in ./config/application.rb so I'm
# coercing the loading of the parser and json_parser classes
desc 'Run CDL mappings'

task :cdl, [:orig_dir, :map_dir] => :environment do |_t, args|
  desc 'Load requirements'
  require './lib/feta/parser.rb'
  require './lib/feta/parsers/json_parser.rb'
  require 'benchmark'
  require './config/initializers/rails_config.rb'
  require './lib/feta/metadata_mappings/cdl.rb'

  # Where to load records from and save mapped records to
  original_record_dir = args[:orig_dir]
  mapped_record_dir = args[:map_dir]

  # Make the destination directory if it doesn't exist
  Dir.mkdir(mapped_record_dir) unless Dir.exist?(mapped_record_dir)

  time = Benchmark.realtime do
    Dir.entries(original_record_dir).select do |f|
      next unless f.end_with? '.json'
      # Read the original record
      file = open(original_record_dir + '/' + f, 'rb').read
      original_record = Feta::OriginalRecord.build('fake', file, 'json')
      # Map the record
      mapped_records = Feta::Mapper.map(:cdl, [original_record])
      # Write out mapping to file system unless there was an error with the
      # mapping
      begin
        mapped_record = mapped_records.first.dump(:ttl)
        out_file = File.new(mapped_record_dir + '/' + \
         f.gsub('.json', '.ttl'), 'w')
        out_file << mapped_record
      rescue
        puts 'Error mapping ' + f
      ensure
        out_file.close unless out_file.nil?
      end
    end
  end

  puts "Total runtime (H:M:S): #{Time.at(time).utc.strftime('%H:%M:%S')}"
  puts "Avg time per record: #{(time * 1000) / \
    Dir.entries(original_record_dir).count} ms"
  puts "Number of records per hour: #{Dir.entries(original_record_dir).count / \
    (time / 60 / 60)}"
end
