# frozen_string_literal: true

require_relative '../app/frame'

describe Frame do
  describe 'obtener puntaje' do
    it 'no chuza ni spare' do
      frame = Frame.new
      frame.tiros = [4, 3]
      expect { frame.obtener_puntaje([7, 1]) }.to change { frame.puntaje }.from(0).to(7)
    end
  end

  describe 'probar si tiene Spare' do
    it 'hizo spare' do
      frame = Frame.new
      frame.tiros = [8, 2]
      expect(frame.spare).to be true
    end

    it 'no hizo spare' do
      frame = Frame.new
      frame.tiros = [8, 1]
      expect(frame.spare).to be false
    end
  end

  describe 'probar si tiene Chuza' do
    it 'hizo chuza' do
      frame = Frame.new
      frame.tiros = [10]
      expect(frame.chuza).to be true
    end

    it 'no hizo chuza' do
      frame = Frame.new
      frame.tiros = [1]
      expect(frame.chuza).to be false
    end
  end
end
