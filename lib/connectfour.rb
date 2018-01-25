#lib/connectfour.rb
require 'colorator'

class Player
  def initialize(name, player_number)
    @name = name
    @player_number = player_number
  end
  
  def name
    @name
  end
  
  def disc
    return "\u2B24".yellow if @player_number == 1
    return "\u2B24".red if @player_number == 2
  end
end

class Board
  
  def initialize(board = nil)
    @board = board || @board = self.create_board
    @p1 = Player.new("Orange", 1)
    @p2 = Player.new("Red", 2)
    @current_player = @p1
  end
  
  def create_board
    Array.new(6) {Array.new(7, "\u25EF".encode('utf-8'))}
  end
  
  def current_board
    @board
  end
  
  def display
    system "clear"
    puts ".1|2|3|4|5|6|7."
    @board.each do |row|
      print "|"
      row.each do |cell|
        print "#{cell}|"
      end
      puts ""
    end
    puts ""
  end
  
  def instructions
    puts "Welcome to Connect Four!"
    puts "The object of the game is to get four discs in a row."
    puts "Good Luck!"
  end
  
  def get_column
    puts "#{@current_player.disc} 's turn!"
    puts "Enter a column number to drop your game piece!"
    column = gets.chomp.to_i
    if @board[0][column - 1] != "\u25EF".encode('utf-8') && (column < 8 && column > 0)
      puts "that column is full! try again!"
      get_column
    elsif column < 8 && column > 0
      return column
    else
      puts "invalid column! try again!"
      get_column
    end
  end
  
  def switch_player
    @current_player == @p1 ? @current_player = @p2 : @current_player = @p1
  end
  
  def drop_disc(column, disc = @current_player.disc)
    for row in 5.downto(0) do
      if @board[row][column - 1] == "\u25EF".encode('utf-8')
        @board[row][column - 1] = @current_player.disc
        break
      end
    end
  end
  
  def check_horizontally
    @board.each do |row|
      row.each_cons(4) do |quartet|
        if quartet.uniq.length == 1 && quartet.first != "\u25EF".encode('utf-8')
          return quartet.first
        end
      end
    end
    return false
  end
  
  def check_vertically
    @board.transpose.each do |column|
      column.each_cons(4) do |quartet|
        if quartet.uniq.length == 1 && quartet.first != "\u25EF".encode('utf-8')
          return quartet.first
        end
      end
    end
    return false
  end
  
  def check_diagonally
    diags = []
    
    @board.each_with_index do |row, index|
      diags << row.rotate(index)
    end
    
    @board.each_with_index do |row, index|
      diags << row.rotate(-index)
    end
    
    diags.transpose.each do |column|
      column.each_cons(4) do |quartet|
        if quartet.uniq.length == 1 && quartet.first != "\u25EF".encode('utf-8')
          return quartet.first
        end
      end
    end
    return false
  end
  
  def check_all
    [check_horizontally, check_vertically, check_diagonally]
  end
  
  def victory?
    if check_all.any? {|check| check != false}
      true
    else
      false
    end
  end
  
  def draw?
    if @board.flatten.none? {|cell| cell == "\u25EF".encode('utf-8')}
      true
    else
      false
    end
  end
    
  def game_over?
    if victory?
      switch_player
      puts "Game over! #{@current_player.disc} wins!"
      true
    elsif draw?
      puts "Draw!"
      true
    else
      false
    end
  end
     
  def play
    display
    instructions
    until game_over?
      drop_disc(get_column)
      display
      switch_player
    end
  end
end

game = Board.new
game.play