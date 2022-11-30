# frozen_string_literal: true
# typed: strict

require 'sorbet-runtime'

require_relative '../data'

module Operations
  # Base class for all operation classes
  class Base
    extend T::Sig

    sig { params(data: Data, input: String).void }
    def initialize(data:, input:)
      @data = data
      @input = input
    end
  end
end
