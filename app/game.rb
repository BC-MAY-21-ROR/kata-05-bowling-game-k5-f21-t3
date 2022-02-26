# frozen_string_literal: true

require_relative 'frame'
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
  
    def last_frame(frame, anterior)
      frame.chuza || frame.spare ? frame.tirar : frame.obtener_puntaje(frame.tiros)
      frame.obtener_puntaje([frame.tiro_dos, frame.tiro_tres]) if frame.chuza
      frame.obtener_puntaje([frame.tiro_tres]) if frame.spare
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