# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "bitcoin-ruby"
  s.version = "0.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["lian"]
  s.date = "2014-09-11"
  s.description = "This is a ruby library for interacting with the bitcoin protocol/network"
  s.email = ["meta.rb@gmail.com"]
  s.executables = ["bitcoin_dns_seed", "bitcoin_gui", "bitcoin_node", "bitcoin_node_cli", "bitcoin_shell", "bitcoin_wallet"]
  s.files = ["bin/bitcoin_dns_seed", "bin/bitcoin_gui", "bin/bitcoin_node", "bin/bitcoin_node_cli", "bin/bitcoin_shell", "bin/bitcoin_wallet"]
  s.homepage = "https://github.com/lian/bitcoin-ruby"
  s.require_paths = ["lib"]
  s.rubyforge_project = "bitcoin-ruby"
  s.rubygems_version = "2.0.14"
  s.summary = "bitcoin utils and protocol in ruby"
end
