# frozen_string_literal: true

require_relative 'turkish_numeric/version'
require_relative 'turkish_numeric/number_presenter'
require_relative 'turkish_numeric/tr_num'

# Responsible for converting numerical values into Turkish texts,
# currency nototaion, or text representation of money.
module TurkishNumeric
  # Helper to create TrNum objects quickly
  #
  # @param [Integer, Float] num
  # @return [TurkishNumeric::TrNum]
  def TrNum(num)  # rubocop:disable Naming/MethodName
    TrNum.new(num)
  end
end
