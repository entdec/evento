require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

task :default => :test

namespace :evento do
  desc 'Release a new version'
  task :release do
    version_file = './lib/evento/version.rb'
    File.open(version_file, 'w') do |file|
      file.puts <<~EOVERSION
        # frozen_string_literal: true

        module Evento
          VERSION = '#{Evento::VERSION.split('.').map(&:to_i).tap { |parts| parts[2] += 1 }.join('.')}'
        end
      EOVERSION
    end
    module Evento
      remove_const :VERSION
    end
    load version_file
    puts "Updated version to #{Evento::VERSION}"

    `git commit lib/evento/version.rb -m "Version #{Evento::VERSION}"`
    `git push`
    `git tag #{Evento::VERSION}`
    `git push --tags`
  end
end

