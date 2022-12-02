# frozen_string_literal: true
# typed: strict

require 'sorbet-runtime'

require_relative './base'
require_relative '../helpers/file_handler'
require_relative '../output/standard'
require_relative '../validations/check_project_name'

module Operations
  # Responsible for deleting the Scribe project
  class DeleteProject < Operations::Base
    extend T::Sig

    sig { returns(T.nilable(T::Hash[T.untyped, T.untyped])) }
    def run
      error = validate

      return delete_project if error.nil?

      puts error
    end

    private

    sig { returns(T.nilable(String)) }
    def validate
      validation_error = Validations::CheckProjectName.new(@input).validate

      return validation_error unless validation_error.nil?
    end

    sig { returns(T.nilable(T::Hash[T.untyped, T.untyped])) }
    def delete_project
      project_name = T.must(@input.split[2])

      Helpers::FileHandler.delete_project_file(project_name)

      Output::Standard.success("#{project_name} was deleted.")

      { project_cursor: '' } if project_name == @data.project_cursor
    end
  end
end
