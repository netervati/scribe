# frozen_string_literal: true
# typed: true

require 'sorbet-runtime'

require_relative './base'
require_relative '../validations/toggle_item'

module Operations
  # Completes the to-do item
  class CheckItem < Operations::Base
    extend T::Sig

    sig { returns(T.nilable(String)) }
    def run
      error = validate

      return check_item if error.nil?

      puts error
    end

    private

    sig { returns(T.nilable(String)) }
    def validate
      return 'Please create a project first.' unless @data.with_project?

      return 'The project has no item yet.' unless contents[:list].length.positive?

      validation_error = Validations::ToggleItem.new(@input).validate

      return validation_error unless validation_error.nil?

      'Please input a number that exists on the list.' if out_of_bounds?
    end

    sig { returns(NilClass) }
    def check_item
      contents[:list][item_number - 1]['completed'] = true

      Helpers::FileHandler.update_project_contents(@data.project_cursor, contents)
    end

    sig { returns(T::Hash[T.untyped, T.untyped]) }
    def contents
      @contents ||= Helpers::FileHandler.read_project_contents(@data.project_cursor)
    end

    sig { returns(Integer) }
    def item_number
      @item_number ||= T.must(@input.split[2]).to_i
    end

    sig { returns(T::Boolean) }
    def out_of_bounds?
      item_number.zero? || item_number > contents[:list].length
    end
  end
end
