# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rcs-common"
  s.version = "9.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["alor", "daniele"]
  s.date = "2014-11-24"
  s.description = "Common components for the RCS Backend"
  s.email = ["alor@hackingteam.it", "daniele@hackingteam.it"]
  s.homepage = ""
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.14"
  s.summary = "rcs-common"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<log4r>, [">= 1.1.9"])
      s.add_runtime_dependency(%q<mime-types>, [">= 0"])
      s.add_runtime_dependency(%q<sys-filesystem>, [">= 0"])
      s.add_runtime_dependency(%q<sys-cpu>, [">= 0"])
      s.add_runtime_dependency(%q<ffi>, [">= 0"])
      s.add_runtime_dependency(%q<mail>, [">= 0"])
      s.add_runtime_dependency(%q<sbdb>, [">= 0"])
      s.add_runtime_dependency(%q<mongoid>, ["~> 4.0.0"])
      s.add_development_dependency(%q<bundler>, ["> 1.0.0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<test-unit>, [">= 0"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<pry>, [">= 0"])
    else
      s.add_dependency(%q<log4r>, [">= 1.1.9"])
      s.add_dependency(%q<mime-types>, [">= 0"])
      s.add_dependency(%q<sys-filesystem>, [">= 0"])
      s.add_dependency(%q<sys-cpu>, [">= 0"])
      s.add_dependency(%q<ffi>, [">= 0"])
      s.add_dependency(%q<mail>, [">= 0"])
      s.add_dependency(%q<sbdb>, [">= 0"])
      s.add_dependency(%q<mongoid>, ["~> 4.0.0"])
      s.add_dependency(%q<bundler>, ["> 1.0.0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<test-unit>, [">= 0"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<pry>, [">= 0"])
    end
  else
    s.add_dependency(%q<log4r>, [">= 1.1.9"])
    s.add_dependency(%q<mime-types>, [">= 0"])
    s.add_dependency(%q<sys-filesystem>, [">= 0"])
    s.add_dependency(%q<sys-cpu>, [">= 0"])
    s.add_dependency(%q<ffi>, [">= 0"])
    s.add_dependency(%q<mail>, [">= 0"])
    s.add_dependency(%q<sbdb>, [">= 0"])
    s.add_dependency(%q<mongoid>, ["~> 4.0.0"])
    s.add_dependency(%q<bundler>, ["> 1.0.0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<test-unit>, [">= 0"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<pry>, [">= 0"])
  end
end
