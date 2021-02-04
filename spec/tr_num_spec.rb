# frozen_string_literal: true

require 'spec_helper'

include TurkishNumeric

RSpec.describe TurkishNumeric do
  it 'parses decimal and float parts correctly' do
    expect(TrNum.new(3).instance_variable_get(:@decimal)).to eq 3
    expect(TrNum.new(3.14).instance_variable_get(:@float)).to eq 14

    expect(TrNum.new(8).instance_variable_get(:@float)).to eq 0
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
  end
end
