namespace :db do
  namespace :seed do
    Dir[Rails.root.join('db', 'seeds', '*.rb')].each do |filename|
      task_name = File.basename(filename, '.rb')
      desc "Seed #{task_name}, based on the file with the same name in `db/seeds/*.rb`"
      task task_name.to_sym => :environment do
        load(filename) if File.exist?(filename)
      end
    end

    namespace :faker do
      Dir[Rails.root.join('db', 'seeds', 'faker', '*.rb')].each do |filename|
        task_name = File.basename(filename, '.rb')
        desc "Seed #{task_name}, based on the file with the same name in `db/seeds/faker/*.rb`"
        task task_name.to_sym => :environment do
          load(filename) if File.exist?(filename)
        end
      end
    end

    desc 'Seed only neccessary data'
    task setup: :environment do
      %w[admin_users].each do |x|
        Rake::Task["db:seed:#{x}"].invoke
      end
    end

    desc 'Seed fake data'
    task faker: :environment do
      %w[].each do |x|
        Rake::Task["db:seed:faker:#{x}"].invoke
      end
    end
  end
end
