# frozen_string_literal: true

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
      @decimal.digits.map.with_index { translate_digit(_1, _2) }.reverse.join
    end

    private

    def parse(number)
      @decimal, @fraction = number.to_s.split('.').map(&:to_i) << 0
    end

    def translate_digit(digit, pos)
      case digit
      when 0 then translate_zero
      when 1 then translate_one(digit, pos)
      else MAPPINGS[pos % 3 % 2][digit]
      end + subfix(digit, pos)
    end

    def translate_zero
      @decimal < 10 ? 'sıfır' : ''
    end

    def translate_one(digit, pos)
      (0.step(66, 3).to_a - [3]).include?(pos) || pos % 3 == 1 ? MAPPINGS[pos % 3 % 2][digit] : ''
    end

    def subfix(digit, pos)
      return SUBFIX[0] if pos % 3 == 2 && digit != 0

      pos >= 3 && (pos % 3).zero? ? SUBFIX[pos / 3] : ''
    end
  end
end
