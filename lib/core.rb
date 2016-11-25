# DEBUG : rubocop tool

require 'score'
require 'show'

# The game core
class Core
  # Declare constants
  SPC = 50
  MAXNUM = 1_00 # 100

  def initialize
    # Generate the secret number and the tries number
    @secret = 1 + rand(MAXNUM)
    @tries = 0

    Show.title
    Show.teaser

    @name = 'Guest'
    your_name
  end

  def your_name
    Show.name

    # Get your name
    try_a_name = gets.chomp.capitalize
    @name = try_a_name unless try_a_name == 'Quit' || try_a_name.empty?
    byebye if try_a_name == 'Quit'

    Show.play
  end

  def show_time
    puts "\nTime left : #{(Time.now - @start_time).round} seconds\n"
  end

  def winner
    show_time
    Show.winner
    puts "#{@tries} tries, good job !\n\n"
    byebye
  end

  def big_winner
    show_time
    Show.big_winner
    byebye
  end

  def byebye
    puts "\nGoodbye #{@name}.\n\n"
    exit
  end

  def a_number?(turn)
    turn.to_s == turn.to_i.to_s
  end

  def ask
    Show.try
    turn = gets.chomp

    byebye if turn == 'quit'

    turn
  end

  def check(turn)
    @tries += 1

    Show.smaller if turn.to_i < @secret
    Show.bigger if turn.to_i > @secret

    a_winner?(turn)
  end

  def a_winner?(turn)
    return false unless turn.to_i == @secret
    @tries == 1 ? big_winner : winner
  end

  def play
    turn = nil
    @start_time = Time.now

    while turn != @secret
      turn = ask

      (Show.warn_number; redo) unless a_number?(turn)

      check(turn)
    end
  end
end
