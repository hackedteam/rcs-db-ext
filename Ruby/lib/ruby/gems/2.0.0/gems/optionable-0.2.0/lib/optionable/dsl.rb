# encoding: utf-8
module Optionable

  # Provides the entry point to the optionable DSL.
  #
  # @since 0.0.0
  module DSL

    # Defines an option to be validated.
    #
    # @example Define the option.
    #   option(:read).allow(:primary, :secondary)
    #
    # @param [ Symbol ] key The name of the option.
    #
    # @return [ Optionable::Validator ] The associated validator for the option.
    #
    # @since 0.0.0
    def option(key)
      optionable_validators[key] ||= Validator.new(key)
    end

    # Get all the validators for all options.
    #
    # @example Get all the validators.
    #   dsl.optionable_validators
    #
    # @return [ Hash<Symbol, Optionable::Validator> ] The validators.
    #
    # @since 0.0.0
    def optionable_validators
      @optionable_validators ||= {}
    end
  end
end
