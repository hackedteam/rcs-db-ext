# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "tuple"
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Justin Balthrop", "Ash Moran"]
  s.date = "2011-08-24"
  s.description = "Fast, binary-sortable serialization for arrays of simple Ruby types."
  s.email = "code@justinbalthrop.com"
  s.extensions = ["ext/extconf.rb"]
  s.extra_rdoc_files = ["LICENSE", "README.rdoc"]
  s.files = ["LICENSE", "README.rdoc", "ext/extconf.rb"]
  s.homepage = "http://github.com/ninjudd/tuple"
  s.require_paths = ["ext"]
  s.rubygems_version = "2.0.14"
  s.summary = "Tuple serialization functions."
end
