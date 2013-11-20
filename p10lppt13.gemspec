# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "p10lppt13/version"

Gem::Specification.new do |s|
  s.name        = "p10lppt13"
  s.version     = P10lppt13::VERSION
  s.authors     = ["José Alexander Delgado Hernández, Sem Ramos Herrera"]
  s.email       = ["alu0100603194@ull.edu.es"]
  s.homepage    = ""
  s.summary     = %q{Gema de matrices densas y dispersas}
  s.description = %q{Implementación de varias clases con matrices densas y dispersas}

  s.rubyforge_project = "p10lppt13"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
