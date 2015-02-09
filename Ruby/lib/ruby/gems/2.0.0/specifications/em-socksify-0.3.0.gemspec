# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "em-socksify"
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ilya Grigorik"]
  s.date = "2013-06-17"
  s.description = "Transparent proxy support for any EventMachine protocol"
  s.email = ["ilya@igvita.com"]
  s.homepage = "http://github.com/igrigorik/em-socksify"
  s.require_paths = ["lib"]
  s.rubyforge_project = "em-socksify"
  s.rubygems_version = "2.0.14"
  s.summary = "Transparent proxy support for any EventMachine protocol"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<eventmachine>, [">= 1.0.0.beta.4"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<eventmachine>, [">= 1.0.0.beta.4"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<eventmachine>, [">= 1.0.0.beta.4"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
