require_relative 'turkish_numeric/version'
module TurkishNumeric
  class Error < StandardError; end

  # Your code goes here...
  class TrNum
    MAPPINGS = [
      %w[sıfır bir iki üç dört beş altı yedi sekiz dokuz].freeze,
      ['', 'on', 'yirmi', 'otuz', 'kırk', 'elli', 'altmış', 'yetmiş', 'seksen', 'doksan'].freeze
    ].freeze

    HUNDRED  = 'yüz'.freeze
    THOUSAND = 'bin'.freeze
    MILLION  = 'milyon'.freeze
    BILLION  = 'milyar'.freeze

    def initialize(number)
      parse(number)
    end

    def to_text
      decimal_text = ''
      @decimal.digits.each_with_index { decimal_text.prepend translate_digit(_1, _2) }
      decimal_text
    end

    private

    def parse(number)
      parts    = number.to_s.split('.')
      @decimal = parts[0].to_i
      @float   = parts[1].to_i || 0
    end

    def translate_digit(digit, pos)
      return '' if digit.zero? && @decimal >= 10

      str = ''
      if pos % 3 == 2
        str += MAPPINGS[pos % 2][digit] unless digit == 1
        str += (pos % 3 == 2 ? HUNDRED : '')
      else
        str += MAPPINGS[pos % 2][digit]
      end
      str
    end
  end
end
