# frozen_string_literal: true
# typed: strict

require 'sorbet-runtime'

require_relative '../config/string'

module Output
  # Handles the standard output in the terminal
  class Standard
    extend T::Sig

    sig { void }
    def self.clear
      system('clear') || system('cls')
    end

    sig { void }
    def self.cursor
      print "#{'>>'.highlight_red} "
    end

    sig { params(text: String).void }
    def self.success(text)
      puts text.green
    end
  end
end
