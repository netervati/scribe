# frozen_string_literal: true
# typed: strict

require 'sorbet-runtime'

require_relative './base'
require_relative '../helpers/file_handler'
require_relative '../output/standard'
require_relative '../validation/create_project'

module Operations
  # Responsible for creating the Scribe project
  class CreateProject < Operations::Base
    extend T::Sig

    sig { returns(T.nilable(T::Hash[T.untyped, T.untyped])) }
    def run
      error = validate

      return create_project if error.nil?

      puts error
    end

    private

    sig { returns(T.nilable(String)) }
    def validate
      validation_error = Validations::CreateProject.new(@input).validate

      return validation_error unless validation_error.nil?

      return unless @input.split.length == 3 && Helpers::FileHandler.project_exist?(@input)

      'Project already exists. Please use a different name.'
    end

    sig { returns(T::Hash[T.untyped, T.untyped]) }
    def create_project
      project_name = T.must(@input.split[2])

      Helpers::FileHandler.create_project_file(project_name)

      Output::Standard.success("#{project_name} was created.")

      { project_cursor: project_name }
    end
  end
end
