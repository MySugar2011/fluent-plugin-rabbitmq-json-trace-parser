require 'base64'

module Fluent
  class TextParser
    class RabbitMQJSONTraceParser < JSONParser
      Plugin.register_parser('rabbitmq_json_trace', self)

      config_param :time_key, :string, default: 'timestamp'
      config_param :time_format, :string, default: '%Y-%m-%d %H:%M:%S:%L'
      config_param :payload_type, :enum, default: :base64, list: [:json, :base64]

      def parse(text)
        time, record = process(text)

        if block_given?
          yield time, record
        else
          return time, record
        end
      rescue Yajl::ParseError
        if block_given?
          yield nil, nil
        else
          return nil, nil
        end
      end

      private

      def process(text)
        record = Yajl.load(text)

        record['payload'] = ::Base64.decode64(record['payload'])

        if @payload_type == :json
          record['payload'] = Yajl.load(record['payload'])
        end

        [get_time(record), record]
      end

      def get_time(record)
        value = @keep_time_key ? record[@time_key] : record.delete(@time_key)

        if value
          if @time_format
            @mutex.synchronize { @time_parser.parse(value) }
          else
            begin
              value.to_i
            rescue => e
              raise ParserError, "invalid time value: value = #{value},"\
                                 "error_class = #{e.class.name},"\
                                 "error = #{e.message}"
            end
          end
        elsif @estimate_current_event
          Engine.now
        end
      end
    end
  end
end
