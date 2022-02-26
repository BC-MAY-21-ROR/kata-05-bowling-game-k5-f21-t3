# frozen_string_literal: true

# Class frame
class Frame
  attr_reader :tiros
  attr_accessor :puntaje, :tiros

  def initialize
    @bolos = 10
    @puntaje = 0
    @tiros = []
  end

  def chuza
    tiro_uno == 10
  end

  def tiro_uno
    @tiros[0]
  end

  def spare
    tiro_uno + tiro_dos == 10
  end

  def tiro_dos
    @tiros[1]
  end

  def tiro_tres
    @tiros[2]
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
    return @puntaje += (10 + prox_tiros.sum) if chuza # chuza!
    return @puntaje += (10 + prox_tiros[0]) if spare
    return @puntaje += @tiros.sum
  end
end
