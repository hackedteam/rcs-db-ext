# encoding: utf-8
module Optionable

  # This exception is raised whenever invalid options are found during
  # validation.
  #
  # @since 0.0.0
  class Invalid < RuntimeError

    # @!attribute key
    #   @return [ Symbol ] The name of the option.
    # @!attribute value
    #   @return [ Object ] The value provided for the option.
    # @!attribute allowed
    #   @return [ Array<Object> ] The allowed values for the option.
    attr_reader :key, :value, :allowed

    # Initialize the Invalid option exception.
    #
    # @example Initialize the exception.
    #   Optionable::Invalid.new(:test, 10, [ 11, 12 ])
    #
    # @param [ Symbol ] key The name of the option.
    # @param [ Object ] value The value provided for the option.
    # @param [ Array<Object> ] allowed The allowed values for the option.
    #
    # @since 0.0.0
    def initialize(key, value, allowed)
      @key = key
      @value = value
      @allowed = allowed
      super(generate_message)
    end

    private

    # Generate the message that will be used in the exception.
    #
    # @api private
    #
    # @since 0.0.0
    def generate_message
      "#{value.inspect} is not acceptable for option #{key.inspect}. " +
      "Valid values are: #{allowed.map(&:inspect).join(", ")}."
    end
  end
end
