# -*- encoding: utf-8 -*-
# stub: regexp-examples 1.5.1 ruby lib

Gem::Specification.new do |s|
  s.name = "regexp-examples".freeze
  s.version = "1.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Tom Lord".freeze]
  s.date = "2020-01-09"
  s.description = "Regexp#examples returns a list of \"all\" strings that are matched by the regex. Regexp#random_example returns one, random string that matches.".freeze
  s.email = "lord.thom@gmail.com".freeze
  s.homepage = "http://rubygems.org/gems/regexp-examples".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.4.0".freeze)
  s.rubygems_version = "2.7.10".freeze
  s.summary = "Extends the Regexp class with '#examples' and '#random_example'".freeze

  s.installed_by_version = "2.7.10" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["> 1.7"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 12.0"])
      s.add_development_dependency(%q<pry>.freeze, ["~> 0.12.0"])
      s.add_development_dependency(%q<warning>.freeze, ["~> 0.10.0"])
    else
      s.add_dependency(%q<bundler>.freeze, ["> 1.7"])
      s.add_dependency(%q<rake>.freeze, ["~> 12.0"])
      s.add_dependency(%q<pry>.freeze, ["~> 0.12.0"])
      s.add_dependency(%q<warning>.freeze, ["~> 0.10.0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["> 1.7"])
    s.add_dependency(%q<rake>.freeze, ["~> 12.0"])
    s.add_dependency(%q<pry>.freeze, ["~> 0.12.0"])
    s.add_dependency(%q<warning>.freeze, ["~> 0.10.0"])
  end
end
