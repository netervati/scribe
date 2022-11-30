# frozen_string_literal: true
# typed: strict

require 'sorbet-runtime'

module Commands
  # Contains the list of Scribe commands and their operation
  class List
    extend T::Sig

    EXPRESSIONS = T.let({
                          add_item: /\Ascribe\\ add\b/,
                          check_project: /\Ascribe\\ \\-\\-project\b/,
                          create_project: /\Ascribe\\ init\b/
                        }, T::Hash[T.untyped, T.untyped])

    sig { returns(T::Array[Symbol]) }
    def self.keys
      EXPRESSIONS.keys
    end

    EXPRESSIONS.each do |key, value|
      singleton_class.class_eval do
        define_method(key) { value }
      end
    end
  end
end
