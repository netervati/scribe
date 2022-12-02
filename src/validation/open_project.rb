# frozen_string_literal: true
# typed: strict

require 'sorbet-runtime'

module Validations
  # Validation layer for the open project class
  class OpenProject
    extend T::Sig

    sig { params(subject: String).void }
    def initialize(subject)
      @subject = T.let(subject.dup, String)
    end

    sig { returns(T.nilable(String)) }
    def validate
      return 'Please don\'t use spaces for the project name.' if @subject.split.length > 3

      if @subject.split.length == 2
        'Please input a project name.'
      elsif T.must(@subject.split[2]).match?(%r{[\x00/\\:*?"<>|]})
        'Please don\'t use invalid file name characters.'
      end
    end
  end
end
