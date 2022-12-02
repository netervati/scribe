# frozen_string_literal: true
# typed: strict

require 'sorbet-runtime'

module Validations
  # Validation layer for the check item class
  class CheckItem
    extend T::Sig

    sig { params(subject: String).void }
    def initialize(subject)
      @subject = T.let(subject.dup, String)
    end

    sig { returns(T.nilable(String)) }
    def validate
      return 'Please add a description on your to-do item.' if @subject.split.length == 2

      return 'Please don\'t use spaces on your item number.' if @subject.split.length > 3

      return 'Please input a valid number.' unless number?
    end

    private

    sig { returns(T::Boolean) }
    def number?
      return true if T.must(@subject.split[2]).to_i > 0

      false
    rescue StandardError
      false
    end
  end
end
