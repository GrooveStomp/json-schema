require 'json-schema/attribute'

module JSON
  class Schema
    class TimeFormat < FormatAttribute
      REGEXP = /\A(\d{2}):(\d{2}):(\d{2})\z/

      def self.validate(current_schema, data, fragments, processor, validator, options = {})
        if data.is_a?(String)
          error_message = "The property '#{build_fragment(fragments)}' must be a time in the format of hh:mm:ss"
          translation_key = 'json_schema_error_time_format'
          if (m = REGEXP.match(data))
            validation_error(processor, error_message, fragments, current_schema, self, options[:record_errors], translation_key, :property => fragments.last) and return if m[1].to_i > 23
            validation_error(processor, error_message, fragments, current_schema, self, options[:record_errors], translation_key, :property => fragments.last) and return if m[2].to_i > 59
            validation_error(processor, error_message, fragments, current_schema, self, options[:record_errors], translation_key, :property => fragments.last) and return if m[3].to_i > 59
          else
            validation_error(processor, error_message, fragments, current_schema, self, options[:record_errors], translation_key, :property => fragments.last)
          end
        end
      end
    end
  end
end
