# frozen_string_literal: true
# typed: strict

require 'sorbet-runtime'

require_relative './base'
require_relative '../helpers/file_handler'
require_relative '../output/standard'
require_relative '../validation/open_project'

module Operations
  # Opens a project based on the inputted project name
  class OpenProject < Operations::Base
    extend T::Sig

    sig { returns(T.nilable(T::Hash[T.untyped, T.untyped])) }
    def run
      error = validate

      return open_project if error.nil?

      puts error
    end

    private

    sig { returns(T.nilable(String)) }
    def validate
      validation_error = Validation::OpenProject.new(@input).validate

      return validation_error unless validation_error.nil?

      return 'Project does not exist.' unless Helpers::FileHandler.project_exist?(@input)
    end

    sig { returns(T::Hash[T.untyped, T.untyped]) }
    def open_project
      project_name = T.must(@input.split[2])

      puts "Opened #{project_name}."

      { project_cursor: project_name }
    end
  end
end
