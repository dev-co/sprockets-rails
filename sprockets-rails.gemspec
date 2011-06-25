Gem::Specification.new do |s|
  s.name    = 'sprockets-rails'
  s.version = '0.1.0'

  s.homepage    = "https://github.com/rails/sprockets-rails"
  s.summary     = "Sprockets Rails integration"
  s.description = <<-EOS
    Plugin for Sprockets Rails integration
  EOS

  s.files = [
    'LICENSE'
  ]

  s.add_dependency 'sprockets', '~> 2.0.0.beta10'

  s.authors = ["David Heinemeier Hansson", "Ryan Bigg"]
  s.email   = ["david@loudthinking.com", "me@ryanbigg.com"]
end
