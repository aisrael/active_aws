# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts 'Run `bundle install` to install missing gems'
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = 'active_aws'
  gem.homepage = 'http://github.com/aisrael/active_aws'
  gem.license = 'MIT'
  gem.summary = 'Provides utility classes, helpers and decorators to the AWS Ruby SDK v2'
  gem.description = 'Provides utility classes, helpers and decorators to the AWS Ruby SDK v2'
  gem.email = 'aisrael@gmail.com'
  gem.authors = ['Alistair A. Israel']
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'cucumber'
require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = '--format pretty'
end

desc 'Code coverage detail'
task :simplecov do
  ENV['COVERAGE'] = 'true'
  Rake::Task['features'].execute
end

task :default => :features

require 'yard'
YARD::Rake::YardocTask.new do |t|
end
