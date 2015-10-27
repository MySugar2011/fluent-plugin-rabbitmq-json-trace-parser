$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'fluent/test'

require 'fluent/plugin/parser_rabbitmq_json_trace'

require 'minitest/autorun'

class Hash
  def corresponding_proxies
    @corresponding_proxies ||= []
  end
end

def prepare_test_json(data)
  {
    'timestamp' => '2015-10-26 16:45:46:599',
    'type' => 'received',
    'node' => 'test@localhost',
    'connection' => '127.0.0.1:44415 -> 127.0.0.1:5672',
    'vhost' => '/',
    'user' => 'guest',
    'channel' => 1,
    'exchange' => '',
    'queue' => 'exc_partners.event_stat',
    'routing_keys' => ['exc_partners.event_stat'],
    'properties' => {
      'priority' => 0,
      'delivery_mode' => 2,
      'content_type' => 'application/json'
    },
    'payload' => ::Base64.encode64(data.to_s)
  }
end
