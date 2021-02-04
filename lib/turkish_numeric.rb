# frozen_string_literal: true

require_relative 'turkish_numeric/version'
require_relative 'turkish_numeric/tr_num'

module TurkishNumeric
  def TrNum(num)
    TrNum.new(num)
  end
end
