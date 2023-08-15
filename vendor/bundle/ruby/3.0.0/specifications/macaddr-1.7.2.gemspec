# -*- encoding: utf-8 -*-
# stub: macaddr 1.7.2 ruby lib

Gem::Specification.new do |s|
  s.name = "macaddr".freeze
  s.version = "1.7.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Ara T. Howard".freeze]
  s.date = "2019-06-05"
  s.description = "cross platform mac address determination for ruby".freeze
  s.email = "ara.t.howard@gmail.com".freeze
  s.homepage = "https://github.com/ahoward/macaddr".freeze
  s.licenses = ["Ruby".freeze]
  s.rubygems_version = "3.4.17".freeze
  s.summary = "macaddr".freeze

  s.installed_by_version = "3.4.17" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<systemu>.freeze, ["~> 2.6.5"])
end
