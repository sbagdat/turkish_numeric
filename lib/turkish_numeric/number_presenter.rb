# frozen_string_literal: true

module TurkishNumeric
  # Responsible for providing helper methods to present numbers as text
  module NumberPresenter
    # Create thousand seperated representaion of numeric value
    #
    # @param [Integer] numeric
    # @param [String] sep
    # @return [String]
    def thousands_separated(numeric, sep: '.')
      numeric.digits.each_slice(3).map(&:join).join(sep).reverse
    end

    # Creates single spaced string representation of the argument
    #
    # @param [Array] parts
    # @return [String]
    def text_spaced(*parts)
      parts.flatten.compact.join(' ')
    end

    # Creates non-spaced string representation of the argument
    #
    # @param [Array] parts
    # @return [String]
    def text_non_spaced(*parts)
      parts.join
    end

    # Extracts pennies from the argument
    #
    # @param [Integer] numeric
    # @return [Integer]
    def to_pennies(numeric)
      return numeric if numeric < 100

      numeric.to_s[0, 2].to_i
    end
  end
end
