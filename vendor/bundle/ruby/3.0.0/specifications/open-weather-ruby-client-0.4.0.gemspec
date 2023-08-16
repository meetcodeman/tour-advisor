# -*- encoding: utf-8 -*-
# stub: open-weather-ruby-client 0.4.0 ruby lib

Gem::Specification.new do |s|
  s.name = "open-weather-ruby-client".freeze
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Daniel Doubrovkine".freeze]
  s.date = "2023-08-13"
  s.email = "dblock@dblock.org".freeze
  s.homepage = "http://github.com/dblock/open-weather-ruby-client".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.4.17".freeze
  s.summary = "OpenWeather API Ruby client.".freeze

  s.installed_by_version = "3.4.17" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<activesupport>.freeze, [">= 0"])
  s.add_runtime_dependency(%q<faraday>.freeze, [">= 2.0.1"])
  s.add_runtime_dependency(%q<faraday-multipart>.freeze, [">= 0"])
  s.add_runtime_dependency(%q<hashie>.freeze, [">= 0"])
  s.add_development_dependency(%q<danger-changelog>.freeze, ["~> 0.4.2"])
  s.add_development_dependency(%q<danger-toc>.freeze, ["~> 0.1.3"])
  s.add_development_dependency(%q<dotenv>.freeze, [">= 0"])
  s.add_development_dependency(%q<pry>.freeze, [">= 0"])
  s.add_development_dependency(%q<rake>.freeze, [">= 0"])
  s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
  s.add_development_dependency(%q<rubocop>.freeze, ["~> 1.48.1"])
  s.add_development_dependency(%q<vcr>.freeze, [">= 0"])
  s.add_development_dependency(%q<webmock>.freeze, [">= 0"])
end
