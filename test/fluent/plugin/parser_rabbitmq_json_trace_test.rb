require 'test_helper'

class RabbitMQJSONTraceParserTest < ::Test::Unit::TestCase
  def setup
    @parser = Fluent::TextParser::RabbitMQJSONTraceParser.new
    @parser.configure({})

    @data = '{"name":"Max"}'

    raw_log_item = prepare_test_json(@data)

    @log_item = Yajl.dump(raw_log_item)

    @log_item_decoded = raw_log_item.clone
    @log_item_decoded['payload'] = @data
    @log_item_decoded.delete('timestamp')
  end

  def test_raw_payload_as_method_call
    _, record = @parser.parse(@log_item)
    assert_equal(@log_item_decoded, record)
    assert_equal(@data, record['payload'])
  end

  def test_raw_payload_with_callback
    @parser.parse(@log_item) do |_, record|
      assert_equal(@log_item_decoded, record)
      assert_equal(@data, record['payload'])
    end
  end

  def test_json_payload_as_method_call
    @parser.configure(:payload_type => :json)

    _, record = @parser.parse(@log_item)
    assert_equal(@log_item_decoded, record)
    assert_equal(@data, record['payload'])
    assert_equal(@data['name'], record['payload']['name'])
  end

  def test_json_payload_with_callback
    @parser.configure(:payload_type => :json)

    @parser.parse(@log_item) do |_, record|
      assert_equal(@log_item_decoded, record)
      assert_equal(@data, record['payload'])
      assert_equal(@data['name'], record['payload']['name'])
    end
  end
end
