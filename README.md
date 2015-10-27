# Fluent::Plugin::RabbitMQJSONTraceParser::Parser

[![Build Status](https://travis-ci.org/kavu/fluent-plugin-rabbitmq-json-trace-parser.svg?branch=master)](https://travis-ci.org/kavu/fluent-plugin-rabbitmq-json-trace-parser)

Fluentd Parser plugin for RabbitMQ Trace log in JSON format.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fluent-plugin-rabbitmq-json-trace-parser'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem fluent-plugin-rabbitmq-json-trace-parser

## Configuration

```
<source>
  @type tail
  path /path/to/log

  tag rabbitmq.trace

  format rabbitmq_json_trace
  payload_type 'json'
</source>
```

You can use two values for `payload_type`:
1. `base64` (default) — to decode payload from Base64 to something meaningful
1. `json` — to decode payload from Base64 and then treat it like a JSON object

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

## Thanks

This gem was made as a part of my regular job in [Excursiopedia](https://www.excursiopedia.com), we successfully debuged some message passing quirks with Fluentd and this small gem.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
