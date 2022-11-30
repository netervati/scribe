# frozen_string_literal: true
# typed: strict

require 'sorbet-runtime'

require_relative './commands/evaluate'
require_relative './data'
require_relative './helpers/file_handler'
require_relative './operations/caller'
require_relative './output/standard'

# Main class for the CLI
class Scribe
  extend T::Sig

  sig { void }
  def initialize
    @data = T.let(Data.new, Data)
  end

  sig { void }
  def run
    Helpers::FileHandler.create_project_directory

    Output::Standard.cursor

    observe_input
  end

  private

  sig { params(line: String, operation: Symbol).void }
  def call_operation(line, operation)
    response = Operations::Caller.run(
      data: @data,
      line: line,
      operation: operation
    )

    @data.store(response) unless response.nil?
  end

  sig { void }
  def observe_input
    ARGF.each do |line|
      break if line =~ /exit/

      operation = Commands::Evaluate.run(line)

      if operation.nil?
        puts 'Please input a valid command.'
      else
        call_operation(line, operation)
      end

      Output::Standard.cursor if @data.enabled_cursor
    end
  end
end
