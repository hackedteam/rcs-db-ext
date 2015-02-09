# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "moped"
  s.version = "2.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Durran Jordan", "Bernerd Schaefer"]
  s.date = "2014-10-16"
  s.description = "A MongoDB driver for Ruby."
  s.email = ["durran@gmail.com"]
  s.homepage = "http://mongoid.org/en/moped"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.14"
  s.summary = "A MongoDB driver for Ruby."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<bson>, ["~> 2.2"])
      s.add_runtime_dependency(%q<connection_pool>, ["~> 2.0"])
      s.add_runtime_dependency(%q<optionable>, ["~> 0.2.0"])
    else
      s.add_dependency(%q<bson>, ["~> 2.2"])
      s.add_dependency(%q<connection_pool>, ["~> 2.0"])
      s.add_dependency(%q<optionable>, ["~> 0.2.0"])
    end
  else
    s.add_dependency(%q<bson>, ["~> 2.2"])
    s.add_dependency(%q<connection_pool>, ["~> 2.0"])
    s.add_dependency(%q<optionable>, ["~> 0.2.0"])
  end
end
