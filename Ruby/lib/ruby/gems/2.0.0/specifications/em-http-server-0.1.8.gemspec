# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "em-http-server"
  s.version = "0.1.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["alor"]
  s.date = "2014-01-27"
  s.description = "Simple http server for eventmachine"
  s.email = ["alberto.ornaghi@gmail.com"]
  s.homepage = "https://github.com/alor/em-http-server"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.14"
  s.summary = "Simple http server for eventmachine with the same interface as evma_httpserver"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<eventmachine>, [">= 0"])
    else
      s.add_dependency(%q<eventmachine>, [">= 0"])
    end
  else
    s.add_dependency(%q<eventmachine>, [">= 0"])
  end
end
