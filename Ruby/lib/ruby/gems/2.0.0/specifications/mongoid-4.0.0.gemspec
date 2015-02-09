# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "mongoid"
  s.version = "4.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["Durran Jordan"]
  s.date = "2014-06-23"
  s.description = "Mongoid is an ODM (Object Document Mapper) Framework for MongoDB, written in Ruby."
  s.email = ["durran@gmail.com"]
  s.homepage = "http://mongoid.org"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9")
  s.rubyforge_project = "mongoid"
  s.rubygems_version = "2.0.14"
  s.summary = "Elegant Persistance in Ruby for MongoDB."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activemodel>, ["~> 4.0"])
      s.add_runtime_dependency(%q<tzinfo>, [">= 0.3.37"])
      s.add_runtime_dependency(%q<moped>, ["~> 2.0.0"])
      s.add_runtime_dependency(%q<origin>, ["~> 2.1"])
    else
      s.add_dependency(%q<activemodel>, ["~> 4.0"])
      s.add_dependency(%q<tzinfo>, [">= 0.3.37"])
      s.add_dependency(%q<moped>, ["~> 2.0.0"])
      s.add_dependency(%q<origin>, ["~> 2.1"])
    end
  else
    s.add_dependency(%q<activemodel>, ["~> 4.0"])
    s.add_dependency(%q<tzinfo>, [">= 0.3.37"])
    s.add_dependency(%q<moped>, ["~> 2.0.0"])
    s.add_dependency(%q<origin>, ["~> 2.1"])
  end
end
