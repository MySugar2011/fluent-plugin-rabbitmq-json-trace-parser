# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'fluent-plugin-rabbitmq-json-trace-parser'
  spec.version       = '0.1.0'
  spec.authors       = ['Max Riveiro']
  spec.email         = %w(kavu13@gmail.com)

  spec.summary       = 'Fluentd Parser plugin for RabbitMQ Trace log in JSON format.'
  spec.description   = 'Fluentd Parser plugin for RabbitMQ Trace log in JSON format.'
  spec.homepage      = 'https://github.com/kavu/fluent-plugin-rabbitmq-json-trace-parser'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^test/}) }
  spec.require_paths = %w(lib)

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_runtime_dependency 'fluentd', '>= 0.10.58'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'test-unit', '~> 3.1.4'
end
