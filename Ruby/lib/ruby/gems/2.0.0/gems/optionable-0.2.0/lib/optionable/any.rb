# encoding: utf-8
module Optionable

  # Represents an option that can be of any value of a certain type.
  #
  # @since 0.0.0
  class Any

    # @!attribute type
    #   @return [ Class ] The class type.
    attr_reader :type

    # Check equality of the value for this type.
    #
    # @example Check if the value equals this type.
    #   any == 10
    #
    # @param [ Object ] other The object to check against.
    #
    # @since 0.0.0
    def ==(other)
      other.is_a?(type)
    end

    # Initialize the new any value object.
    #
    # @example Initialize the any value object.
    #   Optionable::Any.new(Integer)
    #
    # @param [ Class ] type The class type.
    #
    # @since 0.0.0
    def initialize(type)
      @type = type
    end

    # Return the pretty inspected type.
    #
    # @example Get the any as an inspection.
    #   any.inspect
    #
    # @return [ String ] any + the class type.
    #
    # @since 0.0.0
    def inspect
      "any #{type}"
    end
  end
end
