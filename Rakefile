$:.unshift File.dirname(__FILE__) + 'lib'
require "bundler/gem_tasks"
require 'rspec/core/rake_task'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new
task :default => :spec

desc "Ejecutando las pruebas para el codigo de Matrices"
task :speclocal do
  sh "rspec -I. spec/p10lppt13_spec.rb"
end

desc "Ejecutando las pruebas para el codigo de Matrices con documentacion"
task :run do
  sh "rspec -I. spec/p10lppt13_spec.rb --format documentation"
end

desc "Ejecutando las pruebas para el codigo de Matrices con documentacion"
task :thtml do
  sh "rspec -I. spec/p10lppt13_spec.rb --format html"
end

desc "Ejecutando las pruebas unitarias para el codigo de Matrices"
task :test do
  sh "ruby -Ilib -Itest test/tc_p10lppt13.rb"
end
