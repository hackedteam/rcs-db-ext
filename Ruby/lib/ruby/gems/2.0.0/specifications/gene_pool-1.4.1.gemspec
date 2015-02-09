# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "gene_pool"
  s.version = "1.4.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brad Pardee"]
  s.date = "2014-04-30"
  s.description = "Generic pooling library for creating a connection pool"
  s.email = ["bradpardee@gmail.com"]
  s.homepage = "http://github.com/bpardee/gene_pool"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.14"
  s.summary = "Generic pooling library for creating a connection pool"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<thread_safe>, [">= 0"])
    else
      s.add_dependency(%q<thread_safe>, [">= 0"])
    end
  else
    s.add_dependency(%q<thread_safe>, [">= 0"])
  end
end
