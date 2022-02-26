#game test
require_relative '../app/game'

describe Game do
    it "ultimo frame" do
        game = Game.new

        anterior = Frame.new
        anterior.puntaje = 270

        frame = Frame.new
        frame.tiros = [10, 10]

        expect{ game.last_frame(frame,anterior) }.to change {frame.puntaje}
    end
end