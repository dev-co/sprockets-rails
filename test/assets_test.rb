require File.expand_path(File.dirname(__FILE__) + "/test_helper")
require 'active_support/core_ext/kernel/reporting'
require 'active_support/testing/isolation'
require 'rack/test'

module ApplicationTests
  class AssetsTest < Test::Unit::TestCase
    include ActiveSupport::Testing::Isolation
    include Rack::Test::Methods
    include Sprockets::Rails::TestHelpers

    def app
      @app ||= Rails.application
    end

    def test_assets_routes_have_higher_priority
      filename = Rails.root + "app/assets/javascripts/demo.js.erb"
      File.open(filename, "w+") { |f| f.write "<%= :alert %>();" }

      Rails.application.routes.append do
        match '*path', :to => lambda { |env| [200, { "Content-Type" => "text/html" }, "Not an asset"] }
      end

      get "/assets/demo.js"
      assert_match "alert()", last_response.body
      FileUtils.rm_r(filename)
    end

    def test_assets_are_compiled_properly
      asset_file "javascripts/application.js", "alert();"
       
      capture(:stdout) do
        Dir.chdir(Rails.root) do
          `bundle exec rake assets:clean`
          `bundle exec rake assets:precompile`
        end
      end

      file = Dir["#{Rails.root}/public/assets/application-*.js"][0]
      assert_equal "alert();\n", File.read(file)
    end

    def test_does_not_stream_session_cookies_back
      asset_file "javascripts/demo.js.erb", "<%= :alert %>();"

      get "/omg"
      assert_equal 'ok', last_response.body

      get "/assets/demo.js"
      assert_match "alert()", last_response.body
      assert_equal nil, last_response.headers["Set-Cookie"]
    end
  end
end
