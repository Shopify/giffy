require "bundler/gem_tasks"
require 'rake/testtask'

task default: [:test]

Rake::TestTask.new 'test' do |t|
  ENV['test'] = '1'
  t.libs = ['lib', 'test']
  t.ruby_opts << '-rubygems'
  t.verbose = true
  t.test_files = FileList['test/**/*_test.rb']
end
