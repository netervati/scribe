# frozen_string_literal: true
# typed: true

require 'sorbet-runtime'

# Holds the session data
class Data
  attr_reader :enabled_cursor, :project_cursor

  extend T::Sig

  sig { void }
  def initialize
    @enabled_cursor = T.let(true, T::Boolean)
    @project_cursor = T.let('', String)
  end

  sig { params(hash: T::Hash[T.untyped, T.untyped]).void }
  def store(hash)
    hash.each do |key, val|
      instance_variable_set("@#{key}", val)
    end
  end
end
