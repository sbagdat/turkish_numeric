# frozen_string_literal: true

module TurkishNumeric
  MAPPINGS = [
    %w[_ bir iki üç dört beş altı yedi sekiz dokuz].freeze,
    %w[_ on yirmi otuz kırk elli altmış yetmiş seksen doksan].freeze
  ].freeze

  SUBFIX = %w[yüz bin milyon milyar trilyon katrilyon kentilyon sekstilyon septilyon oktilyon
              nonilyon desilyon undesilyon dodesilyon trodesilyon katordesilyon kendesilyon seksdesilyon
              septendesilyon oktodesilyon novemdesilyon vigintilyon].freeze

  class TrNum
    def initialize(number)
      parse_sign(number)
      parse_number_parts(number)
    end

    def to_text(spaces: true)
      text = translate_decimal_part
      text += [fractional_prefix] + translate_fractional_part unless fraction.zero?
      clean_text(text, spaces)
    end

    private

    attr_accessor :sign, :decimal, :fraction, :fraction_size, :current_processing_part

    def clean_text(text, spaces)
      text = text.flatten.delete_if(&:empty?).join(' ').strip
      spaces ? text.gsub(/\s+/, ' ') : text.gsub(' ', '').gsub('eksi', 'eksi ')
      # TODO: Add test for non-spaced representation
    end

    def translate_fractional_part
      translate_partition(fraction)
    end

    def translate_decimal_part
      [sign] + translate_partition(decimal)
    end

    def translate_partition(partition)
      self.current_processing_part = partition
      partition.digits.each_slice(3).map.with_index do |triplet, tri_idx|
        translate_triplet(triplet, tri_idx)
      end.reverse
    end

    def fractional_prefix
      prefix = self.class.new(10**fraction_size).to_text
      "tam #{prefix}#{prefix.end_with?('yüz', 'bin') ? 'de' : 'da'}".gsub('bir', '')
    end

    def parse_sign(number)
      self.sign = number.negative? ? 'eksi' : ''
    end

    def translate_triplet(triplet, tri_idx)
      triplet.map.with_index do |num, idx|
        digit = translate_digit(num, idx, triplet)
        "#{digit}#{subfix(num, tri_idx * 3 + idx) unless triplet.all?(&:zero?)}"
      end.reverse
    end

    def parse_number_parts(number)
      self.decimal = Integer(number.abs)
      fraction_str = number.to_s.split('.')[1] || '0'
      self.fraction_size = fraction_str.size
      self.fraction = Integer(fraction_str)
    end

    def translate_digit(digit, pos, triplet)
      case digit
      when 0 then translate_zero
      when 1 then translate_one(digit, pos, triplet)
      else MAPPINGS[pos % 2][digit]
      end
    end

    def translate_zero
      current_processing_part.to_s.size == 1 ? 'sıfır' : ''
    end

    def translate_one(digit, pos, triplet)
      return '' if triplet.size == 1 && current_processing_part.to_s.size == 4

      0.step(66, 3).include?(pos) || pos % 3 == 1 ? MAPPINGS[pos % 2][digit] : ''
    end

    def subfix(digit, pos)
      sub_pos = pos % 3
      return " #{SUBFIX[0]}" if sub_pos == 2 && !digit.zero?

      pos >= 3 && sub_pos.zero? ? " #{SUBFIX[pos / 3]}" : ''
    end
  end
end
