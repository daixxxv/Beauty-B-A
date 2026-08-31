require "simplecov"
SimpleCov.start "rails" do
  skip "/test/"
  merge_timeout 3600
end

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    include FactoryBot::Syntax::Methods
    include Devise::Test::IntegrationHelpers

    def sign_in_as(user, password: "password")
      post user_session_path, params: {
        user: {
          email: user.email,
          password: password
        }
      }
    end
  end
end
