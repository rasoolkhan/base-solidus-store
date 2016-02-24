Bundler.require

require File.expand_path('../config/application', __FILE__)

Solidusio::Application.load_tasks

namespace :start do
  desc "Start app in test mode"
  task :test => [:check_environment, :set_test, :environment] do
    run_unicorn(Rails.env)
  end

  desc "Start app in development mode"
  task :development => [:check_environment, :set_development, :environment] do
    run_unicorn(Rails.env)
  end

  desc "Start app in production mode"
  task :prod => [:check_environment, :set_production, :environment] do
    run_unicorn(Rails.env)
  end

end

namespace :assets do
  desc 'compile assets'
  task :compile => [:compile_js, :compile_css] do
  end

  desc 'compile javascript assets'
  task :compile_js do
    sprockets = Application.settings.sprockets
    asset     = sprockets['application.js']
    outpath   = File.join(Application.settings.assets_path, 'js')
    outfile   = Pathname.new(outpath).join('application.min.js') # may want to use the digest in the future?

    FileUtils.mkdir_p outfile.dirname

    asset.write_to(outfile)
    asset.write_to("#{outfile}.gz")
    puts "successfully compiled js assets"
  end

  desc 'compile css assets'
  task :compile_css do
    sprockets = Application.settings.sprockets
    asset     = sprockets['application.css']
    outpath   = File.join(Application.settings.assets_path, 'css')
    outfile   = Pathname.new(outpath).join('application.min.css') # may want to use the digest in the future?

    FileUtils.mkdir_p outfile.dirname

    asset.write_to(outfile)
    asset.write_to("#{outfile}.gz")
    puts "successfully compiled css assets"
  end
  # todo: add :clean_all, :clean_css, :clean_js tasks, invoke before writing new file(s)
end

desc "Checking that the required credentials are specified"
task :check_environment do
  abort "Error, environment variable MYSQL_DB_PASSWORD is not set" unless ENV['MYSQL_DB_PASSWORD']
  abort "Error, environment variable MYSQL_DB_HOST is not set" unless ENV['MYSQL_DB_HOST']
  abort "Error, environment variable MAILCHIMP_API_KEY is not set" unless ENV['MAILCHIMP_API_KEY']
end

task :set_test do
  Rails.env = 'test'
  puts Rails.env
end

task :set_development do
  Rails.env = 'development'
  puts Rails.env
end

task :set_production do
  Rails.env = 'production'
  puts Rails.env
end

def run_unicorn (rails_env)
    system "RAILS_ENV=#{rails_env} bundle exec unicorn_rails -p 8080 -c config/unicorn.rb"
end
