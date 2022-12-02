# frozen_string_literal: true
# typed: strict

require 'sorbet-runtime'

require_relative '../config/string'
require_relative '../data'
require_relative './add_item'
require_relative './check_item'
require_relative './check_project'
require_relative './create_project'
require_relative './list_items'
require_relative './open_project'
require_relative './remove_item'
require_relative './uncheck_item'

module Operations
  # Calls the operation based on the command
  class Caller
    extend T::Sig

    sig do
      params(
        data: Data,
        line: String,
        operation: Symbol
      ).returns(T.nilable(T::Hash[T.untyped, T.untyped]))
    end
    def self.run(data:, line:, operation:)
      Operations.const_get(operation.to_s.pascalize).new(
        data: data,
        input: line
      ).run
    end
  end
end
