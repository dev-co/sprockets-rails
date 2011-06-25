ENV["RAILS_ENV"] = "test"

require 'test/unit'
require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require 'sprockets-rails'
require 'mocha'