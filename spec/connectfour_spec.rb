#spec/connectfour_spec.rb
require 'connectfour.rb'
require 'spec_helper.rb'

describe Player do
  let(:player_one){ Player.new("player_one", 1) }
  let(:player_two){ Player.new("player_two", 2) }
  
  describe "#name" do
    it "returns each player's name" do
      expect(player_one.name).to eql("player_one")
      expect(player_two.name).to eql("player_two")
    end
  end
  
  describe "#disc" do
    it "assigns each player a unique color" do
      expect(player_one.disc).to eql("\u2B24".yellow)
      expect(player_two.disc).to eql("\u2B24".red)
    end
  end
  
end

describe Board do
  let(:empty_board)        { Board.new }
  let(:p1)                 { "\u2B24".yellow }
  let(:p2)                 { "\u2B24".red }
  let(:draw_board)         { Board.new([[p2,p1,p2,p1,p2,p1,p2],
                                        [p2,p2,p1,p1,p2,p2,p1],
                                        [p1,p2,p1,p1,p1,p2,p1],
                                        [p1,p2,p1,p2,p2,p1,p2],
                                        [p1,p1,p2,p2,p2,p1,p2],
                                        [p2,p1,p1,p2,p1,p2,p1]]) }
  let(:horizontal_board)   { Board.new([[p2,p1,p2,p1,p2,p1,p2],
                                        [p2,p2,p1,p1,p2,p2,p1],
                                        [p1,p2,p1,p1,p1,p2,p1],
                                        [p1,p2,p1,p2,p2,p1,p2],
                                        [p1,p1,p2,p2,p2,p1,p2],
                                        [p2,p1,p1,p2,p2,p2,p2]]) }
  let(:vertical_board)     { Board.new([[p2,p1,p2,p1,p2,p1,p2],
                                        [p2,p2,p2,p1,p2,p2,p1],
                                        [p1,p2,p1,p1,p1,p2,p1],
                                        [p1,p2,p1,p2,p1,p1,p2],
                                        [p1,p1,p2,p2,p1,p1,p2],
                                        [p2,p1,p1,p2,p1,p2,p1]]) }
  let(:diagonal_board)     { Board.new([[p2,p1,p2,p1,p2,p1,p2],
                                        [p2,p2,p1,p1,p2,p2,p1],
                                        [p1,p2,p1,p1,p1,p2,p1],
                                        [p1,p2,p2,p2,p2,p1,p2],
                                        [p1,p1,p2,p2,p2,p1,p2],
                                        [p2,p1,p1,p2,p1,p2,p1]]) }
  
  describe "#create_board" do
    it "creates an array of arrays" do
      expect(empty_board.create_board).to eql(empty_board.current_board)
    end
  end
  
  describe "#victory?" do
    it "correctly awards a victory to the winning player" do
      4.times {empty_board.drop_disc(0, p1)}
      expect(empty_board.victory?).to be true
    end
  end
  
  describe "#draw?" do
    context "if all squares are filled and nobody has achieved victory" do
      it "ends the game in a draw" do      
        expect(draw_board.draw?).to be true
      end
    end
  end    
  
  describe "#check_horizontally" do
    it "ends the game if a player gets four in a row horizontally" do
      expect(horizontal_board.check_horizontally).to eql(p2)
    end
  end
  
  describe "#check_vertically" do
    it "ends the game if a player gets four in a row vertically" do
      expect(vertical_board.check_vertically).to eql(p1)
    end
  end
  
  describe "#check_diagonally" do
    it "ends the game if a player gets four in a row diagonally" do
      expect(diagonal_board.check_diagonally).to eql(p2)
    end
  end  
end