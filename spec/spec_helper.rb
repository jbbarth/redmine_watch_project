ENV['RAILS_ENV'] ||= 'test'

#load rails/redmine
require File.expand_path('../../../../config/environment', __FILE__)

#test gems
require 'rspec/rails'
require 'rspec/autorun'
require 'rspec/mocks'
require 'rspec/mocks/standalone'
require 'pry'

#load paths
$:.<< File.expand_path('../../app/models', __FILE__)
$:.<< File.expand_path('../../lib', __FILE__)

#rspec base config
RSpec.configure do |config|
  config.mock_with :rspec
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
  config.fixture_path = "#{::Rails.root}/test/fixtures"
  config.use_transactional_fixtures = true
end
