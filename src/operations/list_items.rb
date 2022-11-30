# frozen_string_literal: true
# typed: true

require 'sorbet-runtime'

require_relative './base'
require_relative '../helpers/file_handler'
require_relative '../output/standard'

module Operations
  # Lists the to-do items in the project
  class ListItems < Operations::Base
    extend T::Sig

    sig { returns(NilClass) }
    def run
      return list_items if @data.with_project?

      puts 'No opened project yet.'
    end

    private

    sig { returns(NilClass) }
    def list_items
      puts
      puts "  #{retrieve_project[:name].highlight_magenta}"
      retrieve_project[:list].each do |item|
        puts "  [ ] #{item['description']}"
      end
      puts
    end

    sig { returns(T::Hash[T.untyped, T.untyped]) }
    def retrieve_project
      @retrieve_project ||= Helpers::FileHandler.read_project_contents(@data.project_cursor)
    end
  end
end
