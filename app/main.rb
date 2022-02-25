# frozen_string_literal: true

# Class frame
class Frame
    attr_reader :tiros
    attr_accessor :puntaje
  
    def initialize
      @bolos = 10
      @puntaje = 0
      @tiros = []
    end
  
    def chuza
      @tiros[0] == 10
    end
  
    def tiro_uno
      @tiros[0]
    end
  
    def spare
      @tiros[0] + @tiros[1] == 10
    end
  
    def tiro_dos
      @tiros[1]
    end
  
    def tirar
      puts 'Dale a enter para tirar'
      gets
      bolos_tirados = rand(@bolos + 1)
      puts "Tiraste: #{bolos_tirados}"
      @bolos -= bolos_tirados
      @tiros.push(bolos_tirados)
      @bolos = 10 if @bolos.zero?
    end
  
    def obtener_puntaje(prox_tiros)
      @puntaje += if chuza # chuza!
                    10 + prox_tiros.sum
                  elsif spare # spare
                    10 + prox_tiros[0]
                  else
                    @tiros.sum
                  end
    end
  end
  
  # class Game
  class Game
    def initialize
      @frames = { 1 => Frame.new, 2 => Frame.new, 3 => Frame.new, 4 => Frame.new, 5 => Frame.new,
                  6 => Frame.new, 7 => Frame.new, 8 => Frame.new, 9 => Frame.new, 10 => Frame.new }
    end
  
    def start
      @frames.each do |key, frame|
        puts "--- Frame #{key}"
        frame.tirar
        frame.tirar if !frame.chuza || (key == 10)
  
        next if key == 1
  
        anterior = @frames[key - 1]
        anteanterior = @frames[key - 2]
  
        if key > 2 && (anterior.chuza && anteanterior.chuza)
          anteanterior.obtener_puntaje([10, frame.tiro_uno])
          anteanterior.puntaje += @frames[key - 3].puntaje if @frames[key - 3]
        end
  
        if !frame.chuza || (key == 10)
          anterior.obtener_puntaje(frame.tiros)
          anterior.puntaje += anteanterior.puntaje if anteanterior
        end
  
        if frame.chuza && !anterior.chuza && (key < 10)
          anterior.obtener_puntaje(frame.tiros)
          anterior.puntaje += anteanterior.puntaje if anteanterior
        end
  
        last_frame(frame, anterior) if key == 10
  
        print_board
      end
    end
  
    def sumar_anterior(frame, ant)
      frame.puntaje += ant.puntaje if ant
    end
  
    def last_frame(frame, anterior)
      frame.chuza || frame.spare ? frame.tirar : frame.obtener_puntaje(frame.tiros)
      frame.obtener_puntaje([frame.tiros[1], frame.tiros[2]]) if frame.chuza
      frame.obtener_puntaje([frame.tiros[2]]) if frame.spare
      frame.puntaje += anterior.puntaje
    end
  
    def print_board
      @frames.each do |_key, frame|
        tiros = frame.tiros.map { |n| n == 10 ? 'X' : n }
        print "[#{tiros.join(' | ').center(7)}]"
      end
      puts
      @frames.each { |_key, frame| print "[#{frame.puntaje.to_s.center(7)}]" }
      puts
    end
  end
  
  game1 = Game.new
  game1.start
  