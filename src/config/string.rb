# frozen_string_literal: true
# typed: strict

require 'sorbet-runtime'

# Ruby standard object with custom methods
class String
  extend T::Sig

  sig { returns(String) }
  def pascalize
    split(/ |_|-/).map(&:capitalize).join('')
  end

  sig { returns(String) }
  def green
    "\e[32m#{self}\e[0m"
  end

  sig { returns(String) }
  def highlight_red
    "\e[41m#{self}\e[0m"
  end
end
