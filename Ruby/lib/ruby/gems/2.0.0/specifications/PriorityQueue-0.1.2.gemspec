# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "PriorityQueue"
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brian Schroeder"]
  s.autorequire = "priority_queue.rb"
  s.date = "2005-10-30"
  s.description = "This is a fibonacci-heap priority-queue implementation. That means  insert: O(1) decrease_priority: Amortized O(1) delete_min:        Amortized O(log n) This project is different from K. Kodamas PQueue in that it allows a decrease key operation.  That makes PriorityQueue usable for algorithms like dijkstras shortest path algorithm, while PQueue is more suitable for Heapsort and the like."
  s.email = "priority_queue@brian-schroeder.de"
  s.extensions = ["ext/priority_queue/extconf.rb"]
  s.files = ["ext/priority_queue/extconf.rb"]
  s.homepage = "http://ruby.brian-schroeder.de/priority_queue"
  s.require_paths = ["lib", "lib", "ext"]
  s.required_ruby_version = Gem::Requirement.new("> 0.0.0")
  s.rubygems_version = "2.0.14"
  s.summary = "This is a fibonacci-heap priority-queue implementation"
end
