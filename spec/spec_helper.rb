require 'byebug'
require 'fabrication'
require 'logger'

require './app/application'
require_relative 'helpers'

require_relative 'support/matchers/paginated'
require_relative 'support/matchers/user'

require_relative 'support/definitions/collection_card'
require_relative 'support/definitions/deck_card'
require_relative 'support/definitions/deck'

RSpec.configure do |config|
  config.include Support::Helpers

  config.around(:each) do |example|
    Sequel::Model.db.transaction(rollback: :always, auto_savepoint: true) do
      example.run
    end
  end

  config.expect_with(:rspec) do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with(:rspec) do |mocks|
    mocks.verify_partial_doubles = true
  end

  if config.files_to_run.one?
    config.default_formatter = 'doc'
    #DB.logger = Logger.new(STDERR)
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.disable_monkey_patching!
  config.warnings = false

  config.profile_examples = 10
  config.order = :random

  Kernel.srand(config.seed)
end
