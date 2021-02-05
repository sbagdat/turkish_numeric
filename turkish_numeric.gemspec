# frozen_string_literal: true

require_relative 'lib/turkish_numeric/version'

Gem::Specification.new do |spec|
  spec.name          = 'turkish_numeric'
  spec.version       = TurkishNumeric::VERSION
  spec.authors       = ['Sıtkı Bağdat']
  spec.email         = ['sbagdat@gmail.com']

  spec.summary       = 'Translate any numeric value into Turkish text.'
  spec.description   = 'Translate any numeric value into Turkish text, ' \
                       'currency notation, or text representation of money.'
  spec.homepage      = 'https://github.com/sbagdat/turkish_numeric'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = Gem::Requirement.new('>= 2.7.0')
end
