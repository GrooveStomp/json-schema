require 'json-schema/attribute'

module JSON
  class Schema
    class DateFormat < FormatAttribute
      REGEXP = /\A\d{4}-\d{2}-\d{2}\z/

      def self.validate(current_schema, data, fragments, processor, validator, options = {})
        if data.is_a?(String)
          error_message = "The property '#{build_fragment(fragments)}' must be a date in the format of YYYY-MM-DD"
          translation_key = 'json_schema_error_date_format'
          if REGEXP.match(data)
            begin
              Date.parse(data)
            rescue Exception
              validation_error(processor, error_message, fragments, current_schema, self, options[:record_errors], translation_key, :property => fragments.last)
            end
          else
            validation_error(processor, error_message, fragments, current_schema, self, options[:record_errors], translation_key, :property => fragments.last)
          end
        end
      end
    end
  end
end
