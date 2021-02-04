# frozen_string_literal: true
require_relative 'turkish_numeric/version'
module TurkishNumeric
  class TrNum
    MAPPINGS = [
      %w[sıfır bir iki üç dört beş altı yedi sekiz dokuz].freeze,
      %w[_ on yirmi otuz kırk elli altmış yetmiş seksen doksan].freeze
    ].freeze
    SUBFIX = %w[yüz bin milyon milyar trilyon katrilyon kentilyon sekstilyon septilyon oktilyon
                nonilyon desilyon undesilyon dodesilyon trodesilyon katordesilyon kendesilyon seksdesilyon
                septendesilyon oktodesilyon novemdesilyon vigintilyon].freeze

    def initialize(number)
      parse(number)
    end

    def to_text
      @decimal.digits.each_slice(3).map.with_index do |triplet, index|
        translate_triplet(triplet, index)
      end.reverse.join
    end

    private

    def translate_triplet(triplet, index)
      triplet.map.with_index do
        digit = translate_digit(_1, _2, triplet)
        digit += subfix(_1, index * 3 + _2) unless triplet.all?(&:zero?)
        digit
      end.reverse
    end

    def parse(number)
      # TODO: Add number validation check
      # TODO: Refactor this
      @decimal, @fraction = number.to_s.split('.').map(&:to_i) << 0
    end

    def translate_digit(digit, pos, triplet)
      case digit
      when 0 then translate_zero
      when 1 then translate_one(digit, pos, triplet)
      else MAPPINGS[pos % 3 % 2][digit]
      end
    end

    def translate_zero
      @decimal.to_s.size == 1 ? 'sıfır' : ''
    end

    def translate_one(digit, pos, triplet)
      return '' if triplet.size == 1 && @decimal.to_s.size == 4

      (0.step(66, 3).to_a - [3]).include?(pos) || pos % 3 == 1 ? MAPPINGS[pos % 3 % 2][digit] : ''
    end

    def subfix(digit, pos)
      return SUBFIX[0] if pos % 3 == 2 && digit != 0

      pos >= 3 && (pos % 3).zero? ? SUBFIX[pos / 3] : ''
    end
  end
end

p TurkishNumeric::TrNum.new(1000).to_text
