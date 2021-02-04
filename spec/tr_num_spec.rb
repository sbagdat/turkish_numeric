# frozen_string_literal: true

require 'spec_helper'
include TurkishNumeric

RSpec.describe TurkishNumeric do
  it 'parses decimal and float parts correctly' do
    expect(TrNum.new(3).instance_variable_get(:@decimal)).to eq 3
    expect(TrNum.new(3.14).instance_variable_get(:@fraction)).to eq 14

    expect(TrNum.new(8).instance_variable_get(:@fraction)).to eq 0
  end

  context 'integer numbers' do
    it 'works for single digit numbers' do
      nums = [*0..9]
      translations = %w[sıfır bir iki üç dört beş altı yedi sekiz dokuz]

      expect(nums.map{TrNum.new(_1).to_text}).to eq translations
    end

    it 'works for two digits numbers' do
      expect(TrNum.new(30).to_text).to eq 'otuz'
      expect(TrNum.new(15).to_text).to eq 'on beş'
    end

    it 'works for three digits numbers' do
      expect(TrNum.new(300).to_text).to eq 'üç yüz'
      expect(TrNum.new(153).to_text).to eq 'yüz elli üç'
      expect(TrNum.new(134).to_text).to eq 'yüz otuz dört'
    end

    it 'works for numbers bigger than 999' do
      expect(TrNum.new(1_000).to_text).to eq 'bin'
      expect(TrNum.new(1_001).to_text).to eq 'bin bir'
      expect(TrNum.new(1_111).to_text).to eq 'bin yüz on bir'
      expect(TrNum.new(1_000_000).to_text).to eq 'bir milyon'
      expect(TrNum.new(2_000_000).to_text).to eq 'iki milyon'
      expect(TrNum.new(301_000).to_text).to eq 'üç yüz bir bin'
      expect(TrNum.new(34_430_002).to_text).to eq 'otuz dört milyon dört yüz otuz bin iki'
    end

    it 'works for negative numbers' do
      expect(TrNum.new(-1_000).to_text).to eq 'eksi bin'
    end
  end

  context 'floationg point numbers' do
    it 'works' do
      expect(TrNum.new(213_321_323.321232).to_text).to eq 'iki yüz on üç milyon üç yüz yirmi bir bin üç yüz yirmi üç tam milyonda üç yüz yirmi bir bin iki yüz otuz iki'
      expect(TrNum.new(3.14).to_text).to eq 'üç tam yüzde on dört'
      expect(TrNum.new(3.00001).to_text).to eq 'üç tam yüz binde bir'
    end
  end
end
