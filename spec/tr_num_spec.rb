# frozen_string_literal: true

require 'spec_helper'
include TurkishNumeric
RSpec.describe TurkishNumeric do
  let(:sample_integers) do
    { 0 => 'sıfır',
      1 => 'bir',
      2 => 'iki',
      3 => 'üç',
      4 => 'dört',
      5 => 'beş',
      6 => 'altı',
      7 => 'yedi',
      8 => 'sekiz',
      9 => 'dokuz',
      10 => 'on',
      11 => 'on bir',
      20 => 'yirmi',
      21 => 'yirmi bir',
      30 => 'otuz',
      40 => 'kırk',
      50 => 'elli',
      60 => 'altmış',
      70 => 'yetmiş',
      80 => 'seksen',
      90 => 'doksan',
      100 => 'yüz',
      101 => 'yüz bir',
      111 => 'yüz on bir',
      200 => 'iki yüz',
      1_000 => 'bin',
      1_001 => 'bin bir',
      1_011 => 'bin on bir',
      1_111 => 'bin yüz on bir',
      2_000 => 'iki bin',
      301_000 => 'üç yüz bir bin',
      1_000_000 => 'bir milyon',
      2_000_000 => 'iki milyon',
      34_430_002 => 'otuz dört milyon dört yüz otuz bin iki',
      1_000_000_000 => 'bir milyar',
      603_862_955_583 => 'altı yüz üç milyar sekiz yüz altmış iki milyon dokuz yüz elli beş bin beş yüz seksen üç',
      999_999_999_999 => 'dokuz yüz doksan dokuz milyar dokuz yüz doksan dokuz milyon dokuz yüz doksan dokuz bin dokuz yüz doksan dokuz',
      -1000 => 'eksi bin',
      -999_999 => 'eksi dokuz yüz doksan dokuz bin dokuz yüz doksan dokuz',
      -1_938_881 => 'eksi bir milyon dokuz yüz otuz sekiz bin sekiz yüz seksen bir' }.freeze
  end
  let(:sample_floats) do
    { 0.5 => 'sıfır tam onda beş',
      0.555 => 'sıfır tam binde beş yüz elli beş',
      3.14 => 'üç tam yüzde on dört',
      1234.00001 => 'bin iki yüz otuz dört tam yüz binde bir',
      213_321_323.321232 => 'iki yüz on üç milyon üç yüz yirmi bir bin üç yüz yirmi üç tam milyonda üç yüz yirmi bir bin iki yüz otuz iki' }.freeze
  end

  context 'parsing parts' do
    it 'works for decimal part' do
      expect(TrNum.new(3).instance_variable_get(:@decimal)).to eq 3
      expect(TrNum.new(-3456).instance_variable_get(:@decimal)).to eq 3456
    end

    it 'works for fractional part' do
      expect(TrNum.new(3).instance_variable_get(:@fraction)).to eq 0
      num = TrNum.new(3.54)
      expect(num.instance_variable_get(:@fraction)).to eq 54
      expect(num.instance_variable_get(:@fraction_size)).to eq 2
      num = TrNum.new(3.00001)
      expect(num.instance_variable_get(:@fraction)).to eq 1
      expect(num.instance_variable_get(:@fraction_size)).to eq 5
    end
  end

  context 'translates integer numbers into text' do
    it 'works for samples' do
      sample_integers.each do |num, text|
        expect(TrNum.new(num).to_text).to eq text
      end
    end
  end

  context 'translates floating point numbers into text' do
    it 'works for samples' do
      sample_floats.each do |num, text|
        expect(TrNum.new(num).to_text).to eq text
      end
    end
  end
end
