# -*- encoding: utf-8 -*-
# stub: warbler 2.0.5 ruby lib

Gem::Specification.new do |s|
  s.name = "warbler".freeze
  s.version = "2.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Nick Sieger".freeze]
  s.date = "2018-05-03"
  s.description = "Warbler is a gem to make a Java jar or war file out of any Ruby,\nRails, or Rack application. Warbler provides a minimal, flexible, Ruby-like way to\nbundle up all of your application files for deployment to a Java environment.".freeze
  s.email = "nick@nicksieger.com".freeze
  s.executables = ["warble".freeze]
  s.files = ["bin/warble".freeze]
  s.homepage = "https://github.com/jruby/warbler".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--main".freeze, "README.rdoc".freeze, "-H".freeze, "-f".freeze, "darkfish".freeze]
  s.rubygems_version = "2.7.10".freeze
  s.summary = "Warbler chirpily constructs .war files of your Rails applications.".freeze

  s.installed_by_version = "2.7.10" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rake>.freeze, [">= 10.1.0"])
      s.add_runtime_dependency(%q<jruby-jars>.freeze, [">= 9.0.0.0"])
      s.add_runtime_dependency(%q<jruby-rack>.freeze, [">= 1.1.1", "< 1.3"])
      s.add_runtime_dependency(%q<rubyzip>.freeze, ["~> 1.0", "< 1.4"])
      s.add_development_dependency(%q<jbundler>.freeze, ["~> 0.9"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 2.10"])
    else
      s.add_dependency(%q<rake>.freeze, [">= 10.1.0"])
      s.add_dependency(%q<jruby-jars>.freeze, [">= 9.0.0.0"])
      s.add_dependency(%q<jruby-rack>.freeze, [">= 1.1.1", "< 1.3"])
      s.add_dependency(%q<rubyzip>.freeze, ["~> 1.0", "< 1.4"])
      s.add_dependency(%q<jbundler>.freeze, ["~> 0.9"])
      s.add_dependency(%q<rspec>.freeze, ["~> 2.10"])
    end
  else
    s.add_dependency(%q<rake>.freeze, [">= 10.1.0"])
    s.add_dependency(%q<jruby-jars>.freeze, [">= 9.0.0.0"])
    s.add_dependency(%q<jruby-rack>.freeze, [">= 1.1.1", "< 1.3"])
    s.add_dependency(%q<rubyzip>.freeze, ["~> 1.0", "< 1.4"])
    s.add_dependency(%q<jbundler>.freeze, ["~> 0.9"])
    s.add_dependency(%q<rspec>.freeze, ["~> 2.10"])
  end
end
