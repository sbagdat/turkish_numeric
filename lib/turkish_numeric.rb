# frozen_string_literal: true
#
require_relative 'turkish_numeric/version'
module TurkishNumeric

  class TrNum
    MAPPINGS = [
      %w[sıfır bir iki üç dört beş altı yedi sekiz dokuz].freeze,
      ['', 'on', 'yirmi', 'otuz', 'kırk', 'elli', 'altmış', 'yetmiş', 'seksen', 'doksan'].freeze
    ].freeze
    SUBFIX = %w[yüz bin milyon milyar trilyon katrilyon kentilyon sekstilyon septilyon oktilyon
                nonilyon desilyon undesilyon dodesilyon trodesilyon katordesilyon kendesilyon seksdesilyon
                septendesilyon oktodesilyon novemdesilyon vigintilyon].freeze

    def initialize(number)
      parse(number)
    end

    def to_text
      decimals = @decimal.digits
      decimals.map.with_index { translate_digit(_1, _2) }.reverse.join
    end

    private

    def parse(number)
      parts    = number.to_s.split('.')
      @decimal = parts[0].to_i
      @float   = parts[1].to_i || 0
    end

    def translate_digit(digit, pos)
      return '' if digit.zero? && @decimal >= 10

      (digit == 1 ? translate_one(digit, pos) : MAPPINGS[pos % 3 % 2][digit]) + subfix(pos)
    end

    def translate_one(digit, pos)
      [0, 6, 9].include?(pos) || pos % 3 == 1 ? MAPPINGS[pos % 3 % 2][digit] : ''
    end

    def subfix(pos)
      return SUBFIX[0] if pos == 2

      pos >= 3 && (pos % 3).zero? ? SUBFIX[pos / 3] : ''
    end
  end
end
