# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "win32console"
  s.version = "1.3.2"
  s.platform = "x86-mingw32"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Gonzalo Garramuno", "Justin Bailey", "Luis Lavena"]
  s.date = "2012-05-14"
  s.description = "Win32::Console allows controling the windows command line terminal\nthru an OO-interface. This allows you to query the terminal (find\nits size, characters, attributes, etc). The interface and functionality\nshould be identical to Perl's counterpart.\n\nA port of Perl's Win32::Console and Win32::Console::ANSI modules.\n\nThis gem packages Gonzalo Garramuno's Win32::Console project, and includes\na compiled binary for speed. The Win32::Console project's home can be\nfound at:\n\n  http://rubyforge.org/projects/win32console"
  s.email = ["ggarra@advancedsl.com.ar", "jgbailey@gmail.com", "luislavena@gmail.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt", "extra/Console.rdoc", "extra/Console_ANSI.rdoc"]
  s.files = ["History.txt", "Manifest.txt", "README.txt", "extra/Console.rdoc", "extra/Console_ANSI.rdoc"]
  s.homepage = "http://rubyforge.org/projects/winconsole"
  s.rdoc_options = ["--main", "README.txt", "--exclude", "ext"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.6")
  s.rubyforge_project = "winconsole"
  s.rubygems_version = "2.0.14"
  s.summary = "Win32::Console allows controling the windows command line terminal thru an OO-interface"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rdoc>, ["~> 3.10"])
      s.add_development_dependency(%q<rake-compiler>, ["~> 0.7.0"])
      s.add_development_dependency(%q<mocha>, [">= 0.10.5"])
      s.add_development_dependency(%q<rspec>, [">= 2.9.0"])
      s.add_development_dependency(%q<rspec-core>, [">= 2.9.0"])
      s.add_development_dependency(%q<hoe>, ["~> 3.0"])
    else
      s.add_dependency(%q<rdoc>, ["~> 3.10"])
      s.add_dependency(%q<rake-compiler>, ["~> 0.7.0"])
      s.add_dependency(%q<mocha>, [">= 0.10.5"])
      s.add_dependency(%q<rspec>, [">= 2.9.0"])
      s.add_dependency(%q<rspec-core>, [">= 2.9.0"])
      s.add_dependency(%q<hoe>, ["~> 3.0"])
    end
  else
    s.add_dependency(%q<rdoc>, ["~> 3.10"])
    s.add_dependency(%q<rake-compiler>, ["~> 0.7.0"])
    s.add_dependency(%q<mocha>, [">= 0.10.5"])
    s.add_dependency(%q<rspec>, [">= 2.9.0"])
    s.add_dependency(%q<rspec-core>, [">= 2.9.0"])
    s.add_dependency(%q<hoe>, ["~> 3.0"])
  end
end
