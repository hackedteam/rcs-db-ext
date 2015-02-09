require "bundler"
Bundler.setup

require "rake"
require "rspec/core/rake_task"

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "optionable/version"

task :gem => :build
task :build do
  system "gem build optionable.gemspec"
end

task :install => :build do
  system "sudo gem install optionable-#{Optionable::VERSION}.gem"
end

task :release => :build do
  system "git tag -a v#{Optionable::VERSION} -m 'Tagging #{Optionable::VERSION}'"
  system "git push --tags"
  system "gem push optionable-#{Optionable::VERSION}.gem"
  system "rm optionable-#{Optionable::VERSION}.gem"
end

RSpec::Core::RakeTask.new("spec") do |spec|
  spec.pattern = "spec/**/*_spec.rb"
end

task :default => :spec
