# encoding: utf-8
module Optionable

  # This is responsible for the actual validation of the options.
  #
  # @since 0.0.0
  class Validator

    # @!attribute key
    #   @return [ Symbol ] The name of the option.
    attr_reader :key

    # Tells the validator what values are acceptable for the option.
    #
    # @example Specify allowed values.
    #   validator.allow(:test, :testing)
    #
    # @param [ Array<Object> ] values The allowed values.
    #
    # @return [ Array<Object> ] The full list of allowed values.
    #
    # @since 0.0.0
    def allow(*values)
      allowed_values.concat(values)
    end

    # Initialize the new validator.
    #
    # @example Initialize the validator.
    #   Optionable::Validator.new(:test)
    #
    # @param [ Symbol ] key The name of the option.
    #
    # @since 0.0.0
    def initialize(key)
      @key = key
    end

    # Validate the provided value against the acceptable values.
    #
    # @example Validate the provided value.
    #   validator.validate!("test")
    #
    # @param [ Object ] value The value for the option.
    #
    # @raise [ Optionable::Invalid ] If the value is invalid.
    #
    # @since 0.0.0
    def validate!(value)
      raise Invalid.new(key, value, allowed_values) unless match?(value)
    end

    private

    # Get the allowed values for the option.
    #
    # @api private
    #
    # @since 0.0.0
    def allowed_values
      @allowed_values ||= []
    end

    # Does the value match an allowed value?
    #
    # @api private
    #
    # @since 0.0.0
    def match?(value)
      allowed_values.any? do |allowed|
        allowed == value
      end
    end
  end
end
