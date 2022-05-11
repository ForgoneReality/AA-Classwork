require "byebug"

require_relative "piece.rb"
require_relative "bishop.rb"
require_relative "rook.rb"
require_relative "queen.rb"
require_relative "knight.rb"
require_relative "pawn.rb"
require_relative "nullpiece.rb"
require_relative "king.rb"

class Board
    attr_accessor :rows, :nullpi, :black_king, :white_king, :white_pieces, :black_pieces
    def initialize
        @rows = Array.new(8) {Array.new(8)}
        #Initialize all pieces


        @white_pieces = []
        @black_pieces = []

        #rooks
        self[[0,0]] = Rook.new(:black,self,[0,0])
        self[[0,7]] = Rook.new(:black,self,[0,7])
        self[[7,0]] = Rook.new(:white,self,[7,0])
        self[[7,7]] = Rook.new(:white,self,[7,7])
        #Knights
        self[[0,1]] = Knight.new(:black,self,[0,1])
        self[[0,6]] = Knight.new(:black,self,[0,6])
        self[[7,1]] = Knight.new(:white,self,[7,1])
        self[[7,6]] = Knight.new(:white,self,[7,6])
        #Bishops
        self[[0,2]] = Bishop.new(:black,self,[0,2])
        self[[0,5]] = Bishop.new(:black,self,[0,5])
        self[[7,2]] = Bishop.new(:white,self,[7,2])
        self[[7,5]] = Bishop.new(:white,self,[7,5])
        #Queens
        self[[7,3]] = Queen.new(:white,self,[7,3])
        self[[0,3]] = Queen.new(:black,self,[0,3])
        #Kings
        @white_king = King.new(:white,self,[7,4])
        self[[7,4]] = @white_king
        @black_king =  King.new(:black,self,[0,4])
        self[[0,4]] = @black_king
        #Pawns
        (0..7).each do |y|
            paw = Pawn.new(:black, self, [1,y])
            black_pieces << paw
            self[[1,y]] = paw
        end
        (0..7).each do |y|
            paw = Pawn.new(:white, self, [6,y])
            white_pieces << paw
            self[[6,y]] = paw
        end

        
        @nullpi = NullPiece.instance
        (2..5).each do |x|
            (0..7).each do |y|
                self[[x,y]] = @nullpi
            end
        end

        (0..7).each do |j|
            black_pieces << self[[0,j]]
            white_pieces << self[[7,j]]
        end


    end
    
    def [](pos)
        x,y = pos
        return rows[x][y]
    end

    def []=(pos,val)
        x,y = pos
        rows[x][y] = val
    end

    def move_piece(start_pos, end_pos) #CASTLING, EN PASSANTE, AND PROMOTIONS
        x, y = start_pos
        piece = rows[x][y]
        return false if piece.empty?
        if piece.valid_moves.include?(end_pos)
            piece.pos = end_pos
            a,b = end_pos
            if !rows[a][b].empty? #check if king too?
                if rows[a][b].color == :white
                    white_pieces.delete(rows[a][b])
                else
                    black_pieces.delete(rows[a][b])
                end
            end
            rows[a][b] = piece 
            rows[x][y] = @nullpi
        else
            raise StandardError.new ("Illegal Move Made!")
        end
    end

    def in_check?(color, modified=nil, king=nil)
        #two kings?
        if color == :black
            if king == nil
                bkp = black_king.pos
            else
                bkp = king
            end
            white_pieces.each do |piece|
                next if modified != nil && piece.pos == modified
                if piece.moves.include?(bkp)
                    return true
                end
            end
            return false
        else #repetiive code but idc
            if king == nil
                wkp = white_king.pos
            else
                wkp = king
            end
            black_pieces.each do |piece|
                next if modified != nil && piece.pos == modified
                if piece.moves.include?(wkp)
                    return true
                end
            end
            return false
        end
    end

    def checkmate?(color) #can be made faster if AI is slow
        return false if !in_check?(color)
        c_mate = true
        color == :white ? pieces = @white_pieces : pieces = @black_pieces
        pieces.each do |piece|
            x,y = piece.pos
            self[[x,y]] = @nullpi
            
            piece.moves.each do |potential_move|
                a,b = potential_move
                temp = self[[a,b]]
                self[[a,b]] = piece

                if piece.symbol == :king
                    if !in_check?(color, [a,b], potential_move)
                        c_mate = false
                    end
                else
                    if !in_check?(color, [a,b])
                        c_mate = false
                    end
                end

                self[[a,b]] = temp
                if !c_mate
                    self[[x,y]] = piece
                    return false
                end
            end
            self[[x,y]] = piece
        end
        return c_mate
    end
end
