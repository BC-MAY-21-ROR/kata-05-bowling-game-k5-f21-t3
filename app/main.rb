#Chuza: 10 puntos mas siguientes 2 tiros
#Spare: 10 puntos mas siguiente tiro

class Frame
    attr_reader :tiros
    attr_accessor :puntaje

    def initialize
        @bolos = 10
        @puntaje = 0
        @tiros = []
    end

    def tirar
        puts "Dale a enter para tirar"
        gets
        # bolos_tirados = rand(@bolos+1)
        bolos_tirados = 10
        puts "Tiraste: #{bolos_tirados}"
        @bolos -= bolos_tirados
        @tiros.push(bolos_tirados)
    end

    def obtener_puntaje(prox_tiros)
        if(@tiros[0] == 10) # chuza!
            @puntaje += 10 + prox_tiros.sum
        elsif(@tiros.sum == 10) # spare
            @puntaje += 10 + prox_tiros[0]
        else
            @puntaje += @tiros.sum
        end
    end
end

class Game
    def initialize
        @frames = {
            1=> Frame.new, 
            2=> Frame.new, 
            3=> Frame.new, 
            4=> Frame.new, 
            5=> Frame.new, 
            6=> Frame.new, 
            7=> Frame.new, 
            8=> Frame.new, 
            9=> Frame.new, 
            10=> Frame.new, 
        }
    end

    #[10]
    #[10]

    def start
        @frames.each do |key, frame|
            puts "--- Frame #{key}"
            frame.tirar
            frame.tirar if frame.tiros[0] != 10 or key == 10

            next if key == 1
            
            anterior = @frames[key-1]

            if key > 2
                if anterior.tiros[0] == 10 and @frames[key-2].tiros[0] == 10 
                    @frames[key-2].obtener_puntaje([10, frame.tiros[0]])
                end
            end

            anterior.obtener_puntaje(frame.tiros)

            if key == 10
                frame.tirar if frame.tiros.sum > 9
                frame.obtener_puntaje(frame.tiros)
            end

            frame.puntaje += anterior.puntaje
            
            print_board
        end
    end

    def print_board
        @frames.each do |key, frame|
            print "[#{frame.tiros[0]==10? "X".center(7) : frame.tiros.join(" | ").center(7)}]" 
        end
        puts
        @frames.each do |key, frame|
            print "[#{frame.puntaje.to_s.center(7)}]"
        end
        puts
    end
end

game1 = Game.new
game1.start