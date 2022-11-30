# frozen_string_literal: true
# typed: true

require 'json'
require 'sorbet-runtime'

require_relative '../output/standard'

module Validation
  # Validation layer for the add item class
  class AddItem
    extend T::Sig

    sig { params(subject: String).void }
    def initialize(subject)
      @subject = T.let(subject.dup, String)
    end

    sig { returns(T.nilable(String)) }
    def validate
      return 'Please add a description on your to-do item.' if @subject.split.length == 2

      return 'Please wrap your description in double quotation marks.' if unwrapped_text
    end

    sig { returns(T::Boolean) }
    def unwrapped_text
      description.split('').first != '"' || description.split('').last != '"'
    end

    sig { returns(String) }
    def description
      @description ||= @subject.split.drop(2).join(' ')
    end
  end
end
