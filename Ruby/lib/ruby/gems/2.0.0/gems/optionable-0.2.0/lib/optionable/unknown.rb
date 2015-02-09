# encoding: utf-8
module Optionable

  # This exception is raised whenever unknown options are found during
  # validation.
  #
  # @since 0.0.0
  class Unknown < RuntimeError

    # @!attribute key
    #   @return [ Symbol ] The name of the option.
    # @!attribute names
    #   @return [ Array<Symbol> ] The list of valid option names.
    attr_reader :key, :names

    # Initialize the unknown option exception.
    #
    # @example Initialize the exception.
    #   Optionable::Unknown.new(:test, [ :read, :write ])
    #
    # @param [ Symbol ] key The name of the option.
    # @param [ Array<Symbol> ] names The valid option names.
    #
    # @since 0.0.0
    def initialize(key, names)
      @key = key
      @names = names
      super(generate_message)
    end

    private

    # Generate the message that will be used in the exception.
    #
    # @api private
    #
    # @since 0.0.0
    def generate_message
      "#{key.inspect} is an unknown option. Valid options are: #{names.map(&:inspect).join(", ")}."
    end
  end
end
