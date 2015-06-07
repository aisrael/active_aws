if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start
end

# Add this gem's lib path to the $LOAD_PATH
$: << File.expand_path(File.join('..', '..', '..', 'lib'), __FILE__)

require 'dotenv'

Dotenv.load

require 'active_aws'

require 'aruba/cucumber'
