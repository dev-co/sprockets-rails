ENV["RAILS_ENV"] = "test"

require 'test/unit'
require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require 'sprockets-rails'
require 'mocha'

module Sprockets
  module Rails
    module TestHelpers
      def asset_file(filename, content=nil)
        # Load the content from fixtures if possible
        content ||= begin
          File.read(File.dirname(__FILE__) + "/fixtures/#{filename}")
        rescue Errno::ENOENT
          nil
        end

        filename = ::Rails.root + "app/assets" + filename

        FileUtils.mkdir_p(File.dirname(filename))
        if content
          File.open(filename, "w+") { |f| f.write(content) }
        else
          FileUtils.touch(filename)
        end
      end

      def teardown
        # FileUtils.rm_r(::Rails.root + "app/assets/*")
        super
      end
    end
  end
end
