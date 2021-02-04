# frozen_string_literal: true
require_relative 'turkish_numeric/version'
module TurkishNumeric
  class TrNum
    MAPPINGS = [
      %w[_ bir iki üç dört beş altı yedi sekiz dokuz].freeze,
      %w[_ on yirmi otuz kırk elli altmış yetmiş seksen doksan].freeze
    ].freeze
    SUBFIX = %w[yüz bin milyon milyar trilyon katrilyon kentilyon sekstilyon septilyon oktilyon
                nonilyon desilyon undesilyon dodesilyon trodesilyon katordesilyon kendesilyon seksdesilyon
                septendesilyon oktodesilyon novemdesilyon vigintilyon].freeze

    def initialize(number)
      parse_sign(number)
      parse_number_parts(number)
    end

    def to_text
      @current_processing_part = @decimal
      decimal_part = @sign + @decimal.digits.each_slice(3).map.with_index do |triplet, tri_idx|
        translate_triplet(triplet, tri_idx)
      end.reverse.join
      return decimal_part if @fraction.zero?

      @current_processing_part = @fraction
      fractional_part = @fraction.digits.each_slice(3).map.with_index do |triplet, tri_idx|
        translate_triplet(triplet, tri_idx)
      end.reverse.join

      "#{decimal_part} tam #{fractional_prefix} #{fractional_part}"
    end

    private

    def fractional_prefix
      prefix = self.class.new(10**@fraction_size).to_text
      "#{prefix}#{prefix.end_with?('yüz', 'bin') ? 'de' : 'da'}".gsub('bir', '')
    end

    def parse_sign(number)
      @sign = number.negative? ? 'eksi ' : ''
    end

    def translate_triplet(triplet, tri_idx)
      triplet.map.with_index do |num, idx|
        digit = translate_digit(num, idx, triplet)
        "#{digit}#{subfix(num, tri_idx * 3 + idx) unless triplet.all?(&:zero?)}"
      end.reverse
    end

    def parse_number_parts(number)
      @decimal = Integer(number.abs)
      @fraction_size = (number.to_s.split('.')[1] || 0).size
      @fraction = Integer(number.to_s.split('.')[1] || 0)
    end

    def translate_digit(digit, pos, triplet)
      case digit
      when 0 then translate_zero
      when 1 then translate_one(digit, pos, triplet)
      else MAPPINGS[pos % 2][digit]
      end
    end

    def translate_zero
      @current_processing_part.to_s.size == 1 ? 'sıfır' : ''
    end

    def translate_one(digit, pos, triplet)
      return '' if triplet.size == 1 && @current_processing_part.to_s.size == 4

      (0.step(66, 3).to_a - [3]).include?(pos) || pos % 3 == 1 ? MAPPINGS[pos % 2][digit] : ''
    end

    def subfix(digit, pos)
      return SUBFIX[0] if pos % 3 == 2 && digit != 0

      pos >= 3 && (pos % 3).zero? ? SUBFIX[pos / 3] : ''
    end
  end
end
