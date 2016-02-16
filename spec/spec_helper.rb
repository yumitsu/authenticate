$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))


ENV["RAILS_ENV"] ||= 'test'

MY_ORM = :active_record

# require 'simplecov'
# SimpleCov.root File.join(File.dirname(__FILE__), '..', 'lib')
# SimpleCov.start


require 'rails/all'
require 'rspec/rails'
require 'factory_girl_rails'
# require 'timecop'
require 'shoulda-matchers'

require 'authenticate'
require 'controller_helpers'

ENGINE_RAILS_ROOT=File.join(File.dirname(__FILE__), '../')
Dir[File.join(ENGINE_RAILS_ROOT, "spec/factories/**/*.rb")].each {|f| require f }

def setup_orm; end
def teardown_orm; end

require "orm/#{MY_ORM}"

# require "rails_app/config/environment"
require "dummy/config/environment"

# class TestMailer < ActionMailer::Base;end

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/factories"

  config.include Authenticate::Testing::ControllerHelpers, type: :controller

  config.include RSpec::Rails::ControllerExampleGroup, :file_path => /controller(.)*_spec.rb$/
  config.mock_with :rspec
  config.include FactoryGirl::Syntax::Methods

  config.use_transactional_fixtures = true

  config.before(:suite) { setup_orm }
  config.after(:suite) { teardown_orm }
  config.before(:each) { ActionMailer::Base.deliveries.clear }
end


def restore_default_configuration
  Authenticate.configuration = nil
  Authenticate.configure {}
end

def mock_request(params = {})
  req = double("request")
  allow(req).to receive(:params).and_return(params)
  allow(req).to receive(:remote_ip).and_return('111.111.111.111')
  req
end



# # This file was generated by the `rails generate rspec:install` command. Conventionally, all
# # specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# # The generated `.rspec` file contains `--require spec_helper` which will cause
# # this file to always be loaded, without a need to explicitly require it in any
# # files.
# #
# # Given that it is always loaded, you are encouraged to keep this file as
# # light-weight as possible. Requiring heavyweight dependencies from this file
# # will add to the boot time of your test suite on EVERY test run, even for an
# # individual file that may not need all of that loaded. Instead, consider making
# # a separate helper file that requires the additional dependencies and performs
# # the additional setup, and require it from the spec files that actually need
# # it.
# #
# # The `.rspec` file also contains a few flags that are not defaults but that
# # users commonly want.
# #
# # See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
# RSpec.configure do |config|
#   # rspec-expectations config goes here. You can use an alternate
#   # assertion/expectation library such as wrong or the stdlib/minitest
#   # assertions if you prefer.
#   config.expect_with :rspec do |expectations|
#     # This option will default to `true` in RSpec 4. It makes the `description`
#     # and `failure_message` of custom matchers include text for helper methods
#     # defined using `chain`, e.g.:
#     #     be_bigger_than(2).and_smaller_than(4).description
#     #     # => "be bigger than 2 and smaller than 4"
#     # ...rather than:
#     #     # => "be bigger than 2"
#     expectations.include_chain_clauses_in_custom_matcher_descriptions = true
#   end
#
#   # rspec-mocks config goes here. You can use an alternate test double
#   # library (such as bogus or mocha) by changing the `mock_with` option here.
#   config.mock_with :rspec do |mocks|
#     # Prevents you from mocking or stubbing a method that does not exist on
#     # a real object. This is generally recommended, and will default to
#     # `true` in RSpec 4.
#     mocks.verify_partial_doubles = true
#   end
#
# # The settings below are suggested to provide a good initial experience
# # with RSpec, but feel free to customize to your heart's content.
# =begin
#   # These two settings work together to allow you to limit a spec run
#   # to individual examples or groups you care about by tagging them with
#   # `:focus` metadata. When nothing is tagged with `:focus`, all examples
#   # get run.
#   config.filter_run :focus
#   config.run_all_when_everything_filtered = true
#
#   # Allows RSpec to persist some state between runs in order to support
#   # the `--only-failures` and `--next-failure` CLI options. We recommend
#   # you configure your source control system to ignore this file.
#   config.example_status_persistence_file_path = "spec/examples.txt"
#
#   # Limits the available syntax to the non-monkey patched syntax that is
#   # recommended. For more details, see:
#   #   - http://rspec.info/blog/2012/06/rspecs-new-expectation-syntax/
#   #   - http://www.teaisaweso.me/blog/2013/05/27/rspecs-new-message-expectation-syntax/
#   #   - http://rspec.info/blog/2014/05/notable-changes-in-rspec-3/#zero-monkey-patching-mode
#   config.disable_monkey_patching!
#
#   # Many RSpec users commonly either run the entire suite or an individual
#   # file, and it's useful to allow more verbose output when running an
#   # individual spec file.
#   if config.files_to_run.one?
#     # Use the documentation formatter for detailed output,
#     # unless a formatter has already been configured
#     # (e.g. via a command-line flag).
#     config.default_formatter = 'doc'
#   end
#
#   # Print the 10 slowest examples and example groups at the
#   # end of the spec run, to help surface which specs are running
#   # particularly slow.
#   config.profile_examples = 10
#
#   # Run specs in random order to surface order dependencies. If you find an
#   # order dependency and want to debug it, you can fix the order by providing
#   # the seed, which is printed after each run.
#   #     --seed 1234
#   config.order = :random
#
#   # Seed global randomization in this process using the `--seed` CLI option.
#   # Setting this allows you to use `--seed` to deterministically reproduce
#   # test failures related to randomization by passing the same `--seed` value
#   # as the one that triggered the failure.
#   Kernel.srand config.seed
# =end
# end
