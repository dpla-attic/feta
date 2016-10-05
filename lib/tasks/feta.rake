feta_dir = Gem::Specification.find_by_name('feta').gem_dir

# require "#{feta_dir}/app/models/feta/original_record"

namespace :feta do

  desc 'Run CDL mappings'

  task :cdl => :environment do
    #run cdl mapping
  end

end