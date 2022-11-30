# frozen_string_literal: true
# typed: strict

require 'sorbet-runtime'
require_relative 'list'

module Commands
  # Checks if the inputted command matches a Scribe command
  class Evaluate
    extend T::Sig

    sig { params(item: String).returns(T.nilable(Symbol)) }
    def self.run(item)
      Commands::List.keys.find do |operation|
        Regexp.escape(item) =~ Commands::List.public_send(operation)
      end
    end
  end
end
