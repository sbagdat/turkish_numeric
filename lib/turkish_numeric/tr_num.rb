# frozen_string_literal: true

module TurkishNumeric
  MAPPINGS = [
    %w[_ bir iki üç dört beş altı yedi sekiz dokuz].freeze,
    %w[_ on yirmi otuz kırk elli altmış yetmiş seksen doksan].freeze
  ].freeze
  SUBFIX = %w[yüz bin milyon milyar trilyon katrilyon kentilyon sekstilyon septilyon oktilyon
              nonilyon desilyon undesilyon dodesilyon trodesilyon katordesilyon kendesilyon
              seksdesilyon septendesilyon oktodesilyon novemdesilyon vigintilyon].freeze

  # Represents a number in Turkish language
  class TrNum
    include NumberPresenter

    # A new instance of TrNum
    #
    # @param [Integer, Float] number
    # @return [TurkishNumeric::TrNum]
    def initialize(number)
      @sign = 'eksi' if number.negative?
      @decimal = Integer(number.abs)
      fraction_str = number.to_s.split('.')[1] || '0'
      @fraction_size = fraction_str.size
      @fraction = Integer(fraction_str, 10)
    end

    # Translate numeric value into Turkish text
    #
    # @return [String]
    def to_text
      decimal_part = translate_partition(decimal)
      fractional_part = fraction.zero? ? nil : [fractional_prefix, translate_partition(fraction)]
      text_spaced(sign, decimal_part, fractional_part)
    end

    # Translate numeric value into currency notation
    #
    # @param [String] symbol
    # @param [String] thousand_sep
    # @param [String] penny_sep
    # @return [String]
    def to_money(symbol: '₺', thousand_sep: '.', penny_sep: ',')
      [symbol,
       thousands_separated(decimal, sep: thousand_sep),
       penny_sep,
       to_pennies(fraction)].join
    end

    # Translate numeric value into text representaion of money
    #
    # @param [String] currency
    # @param [String] sub_currency
    # @return [String]
    def to_money_text(currency: 'TL', sub_currency: 'kr')
      pennies = to_pennies(fraction)
      decimal_part = decimal.zero? ? nil : [translate_partition(decimal), currency, ',']
      fractional_part = pennies&.zero? ? nil : [translate_partition(pennies), sub_currency]
      text_non_spaced(sign, decimal_part, fractional_part)
    end

    private

    attr_reader :sign, :decimal, :fraction_size, :fraction
    attr_accessor :current_processing_part

    def translate_partition(partition)
      self.current_processing_part = partition
      partition.digits.each_slice(3).map.with_index do |triplet, tri_idx|
        translate_triplet(triplet, tri_idx)
      end.reverse
    end

    def translate_triplet(triplet, tri_idx)
      triplet.map.with_index do |num, idx|
        digit = translate_digit(num, idx, triplet)
        subfix = triplet.all?(&:zero?) ? nil : subfix(num, tri_idx * 3 + idx)
        [digit, subfix]
      end.reverse
    end

    def translate_digit(digit, pos, triplet)
      case digit
      when 0 then translate_zero
      when 1 then translate_one(digit, pos, triplet)
      else MAPPINGS[pos % 2][digit]
      end
    end

    def fractional_prefix
      prefix = self.class.new(10**fraction_size).to_text.gsub('bir', '').lstrip
      "tam #{prefix}#{prefix.end_with?('yüz', 'bin') ? 'de' : 'da'}"
    end

    def translate_zero
      current_processing_part.to_s.size == 1 ? 'sıfır' : nil
    end

    def translate_one(digit, pos, triplet)
      return nil if triplet.size == 1 && current_processing_part.to_s.size == 4

      0.step(66, 3).include?(pos) || pos % 3 == 1 ? MAPPINGS[pos % 2][digit] : nil
    end

    def subfix(digit, pos)
      sub_pos = pos % 3
      return SUBFIX[0] if sub_pos == 2 && !digit.zero?

      pos >= 3 && sub_pos.zero? ? SUBFIX[pos / 3] : nil
    end
  end
end
