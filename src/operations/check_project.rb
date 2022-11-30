# frozen_string_literal: true
# typed: strict

require 'sorbet-runtime'

require_relative './base'
require_relative '../output/standard'

module Operations
  # Identifies the current opened project
  class CheckProject < Operations::Base
    extend T::Sig

    sig { returns(NilClass) }
    def run
      return display_project if @data.with_project?

      puts 'No opened project yet.'
    end

    private

    sig { returns(NilClass) }
    def display_project
      puts @data.project_cursor
    end
  end
end
