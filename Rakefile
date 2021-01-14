require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

task :default => :test

# Adds the Auxilium semver task
spec = Gem::Specification.find_by_name 'auxilium'
load "#{spec.gem_dir}/lib/tasks/semver.rake"

