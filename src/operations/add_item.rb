# frozen_string_literal: true
# typed: strict

require 'sorbet-runtime'

require_relative './base'
require_relative '../helpers/file_handler'
require_relative '../validation/add_item'

module Operations
  # Adds a to-do item on the project
  class AddItem < Operations::Base
    extend T::Sig

    sig { returns(NilClass) }
    def run
      error = validate

      return add_item if error.nil?

      puts error
    end

    private

    sig { returns(T.nilable(String)) }
    def validate
      return 'Please create a project first.' unless @data.with_project?

      Validation::AddItem.new(@input).validate
    end

    sig { returns(NilClass) }
    def add_item
      contents = project_contents

      contents[:list] << { completed: false, description: raw_string }

      Helpers::FileHandler.update_project_contents(@data.project_cursor, contents)
    end

    sig { returns(T::Hash[T.untyped, T.untyped]) }
    def project_contents
      Helpers::FileHandler.read_project_contents(@data.project_cursor)
    end

    sig { returns(String) }
    def raw_string
      T.must(T.must(@input.split.drop(2).join(' ')[1..]).chop!)
    end
  end
end
