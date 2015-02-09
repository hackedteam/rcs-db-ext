# encoding: utf-8
require "optionable/any"
require "optionable/dsl"
require "optionable/invalid"
require "optionable/unknown"
require "optionable/validator"
require "optionable/version"

# This module is to be included in objects that require some nifty options
# validation.
#
# @since 0.0.0
module Optionable

  # Validate the provided options against the defined acceptable values.
  #
  # @example Validate the options.
  #   optionable.validate_strict(read: "test")
  #
  # @param [ Hash ] options The options to validate.
  #
  # @raise [ Optionable::Invalid ] If the options are wack.
  # @raise [ Optionable::Unknown ] If an unknown option is passed.
  #
  # @since 0.0.0
  def validate_strict(options)
    (options || {}).each_pair do |key, value|
      validator = optionable_validators[key]
      if validator
        validator.validate!(value)
      else
        raise Unknown.new(key, optionable_validators.keys)
      end
    end
  end

  private

  # Get the optionable validators from the class.
  #
  # @api private
  #
  # @since 0.0.0
  def optionable_validators
    self.class.optionable_validators
  end

  class << self

    # Provides a convenience method for creating a new option acceptance for
    # values of a certain type.
    #
    # @example Create the any type.
    #   Optionable.any(Integer)
    #
    # @param [ Class ] type The type of supported value.
    #
    # @since 0.0.0
    def any(type)
      Any.new(type)
    end

    private

    # Extend the DSL methods when the module is included.
    #
    # @api private
    #
    # @since 0.0.0
    def included(klass)
      klass.extend(DSL)
    end
  end
end
