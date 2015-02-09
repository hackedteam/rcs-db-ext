# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "bdb"
  s.version = "0.2.6.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Justin Balthrop", "Denis Knauf", "Ash Moran"]
  s.date = "2013-12-19"
  s.description = "Advanced Ruby Berkeley DB library."
  s.email = ["code@justinbalthrop.com", "Denis.Knauf@gmail.com", "ash.moran@patchspace.co.uk"]
  s.extensions = ["ext/extconf.rb"]
  s.extra_rdoc_files = ["LICENSE", "README.md"]
  s.files = ["LICENSE", "README.md", "ext/extconf.rb"]
  s.homepage = "http://github.com/ruby-bdb/bdb"
  s.require_paths = ["ext", "lib"]
  s.rubygems_version = "2.0.14"
  s.summary = "Ruby Berkeley DB"
end
