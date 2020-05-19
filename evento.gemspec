require_relative 'lib/evento/version'

Gem::Specification.new do |spec|
  spec.name          = 'evento'
  spec.version       = Evento::VERSION
  spec.authors       = ['Mark Cornelissen']
  spec.email         = ['mark@boxture.com']

  spec.summary       = 'Event helpers'
  spec.description   = 'Event helpers'
  spec.homepage      = 'https://code.entropydecelerator.com/components/evento'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.6.5')

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added
  # into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.add_development_dependency 'aasm', '~> 5.0'
  spec.add_development_dependency 'i18n', '~> 1.8'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'pry', '~> 0.13'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rubocop', '~> 0.83'
end
