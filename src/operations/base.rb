# frozen_string_literal: true
# typed: strict

require 'sorbet-runtime'

require_relative '../data'

module Operations
  # Base class for all operation classes
  class Base
    extend T::Sig

    sig { params(input: String, params: Data).void }
    def initialize(input:, params:)
      @input = input
      @params = params
    end
  end
end
