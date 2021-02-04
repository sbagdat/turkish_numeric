# frozen_string_literal: true

require 'spec_helper'
include TurkishNumeric

RSpec.describe TurkishNumeric do
  it 'parses decimal and float parts correctly' do
    expect(TrNum.new(3).instance_variable_get(:@decimal)).to eq 3
    expect(TrNum.new(3.14).instance_variable_get(:@fraction)).to eq 14

    expect(TrNum.new(8).instance_variable_get(:@fraction)).to eq 0
  end

  context 'translates integer values correctly' do
    it 'works for single digit numbers' do
      nums = [*0..9]
      translations = %w[sıfır bir iki üç dört beş altı yedi sekiz dokuz]

      expect(nums.map{TrNum.new(_1).to_text}).to eq translations
    end

    it 'works for two digits numbers' do
      expect(TrNum.new(30).to_text).to eq 'otuz'
      expect(TrNum.new(15).to_text).to eq 'onbeş'
    end

    it 'works for three digits numbers' do
      expect(TrNum.new(300).to_text).to eq 'üçyüz'
      expect(TrNum.new(153).to_text).to eq 'yüzelliüç'
      expect(TrNum.new(134).to_text).to eq 'yüzotuzdört'
    end

    it 'works for numbers bigger than 999' do
      expect(TrNum.new(1_000).to_text).to eq 'bin'
      expect(TrNum.new(1_001).to_text).to eq 'binbir'
      expect(TrNum.new(1_111).to_text).to eq 'binyüzonbir'
      expect(TrNum.new(1_000_000).to_text).to eq 'birmilyon'
      expect(TrNum.new(2_000_000).to_text).to eq 'ikimilyon'
      expect(TrNum.new(301_000).to_text).to eq 'üçyüzbirbin'
      expect(TrNum.new(34_430_002).to_text).to eq 'otuzdörtmilyondörtyüzotuzbiniki'
    end

    it 'works for negative numbers' do
      expect(TrNum.new(-1_000).to_text).to eq 'eksi bin'
    end
  end


end
