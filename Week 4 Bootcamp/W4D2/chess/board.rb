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

        #populate
        #checkmate_dodger_hard
        #easy_take_piece
        easy_checkmate
        

        
    end

    def populate
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
        return false if piece.empty? #edge case covered: king must be able to move normally if able to castle
        # debugger if start_pos == [7,4]
        if piece.valid_moves.include?(end_pos)
            piece.pos = end_pos
            piece.moved = true
            a,b = end_pos
            if !rows[a][b].empty? #check if king too?
                if rows[a][b].color == :white
                    white_pieces.delete(rows[a][b])
                else
                    black_pieces.delete(rows[a][b])
                end
            end
            if piece.symbol == :pawn && a == 0
                white_pieces.delete(piece)
                new_queen = Queen.new(:white, self, [a,b])
                white_pieces << new_queen
                rows[a][b] = new_queen
            elsif piece.symbol == :pawn && a == 7
                black_pieces.delete(piece)
                new_queen = Queen.new(:black, self, [a,b])
                black_pieces << new_queen
                rows[a][b] = new_queen
            else
                rows[a][b] = piece 
            end
            rows[x][y] = @nullpi
        elsif piece.symbol == :king && !in_check?(piece.color) #castling
            if piece.color == :white && @white_king.moved == false && start_pos == [7,4]
                if (end_pos == [7,2] || end_pos == [7,1] )&& rows[7][0].symbol == :rook && rows[7][0].moved == false && rows[7][1].empty? && rows[7][2].empty? && rows[7][3].empty?
                    rows[7][3] = @white_king
                    @white_king.pos = [7,3]
                    rows[7][4] = @nullpi
                    if (in_check?(:white))
                        rows[7][4] = @white_king
                        @white_king.pos = [7,4]
                        rows[7][3] = @nullpi
                        raise StandardError.new ("Illegal Move Made!")
                    end
                    rows[7][2] = @white_king
                    @white_king.pos = [7,2]
                    rows[7][3] = @nullpi
                    if (in_check?(:white))
                        rows[7][4] = @white_king
                        @white_king.pos = [7,4]
                        rows[7][3] = @nullpi
                        rows[7][2] = @nullpi
                        raise StandardError.new ("Illegal Move Made!")
                    end
                    rows[7][3] = rows[7][0]
                    rows[7][3].pos = [7,3]
                    rows[7][0] = @nullpi #2 more cases to-do for blocks
                elsif end_pos == [7,6] && rows[7][7].symbol == :rook && rows[7][7].moved == false && rows[7][5].empty? && rows[7][6].empty?
                    rows[7][5] = @white_king
                    @white_king.pos = [7,5]
                    rows[7][4] = @nullpi
                    #debugger
                    if (in_check?(:white))
                        rows[7][4] = @white_king
                        rows[7][5] = @nullpi
                        @white_king.pos = [7,4]
                        raise StandardError.new ("Illegal Move Made!")
                    end
                    rows[7][6] = @white_king
                    @white_king.pos = [7,6]
                    rows[7][5] = @nullpi
                    if (in_check?(:white))
                        rows[7][4] = @white_king
                        @white_king.pos = [7,4]
                        rows[7][5] = @nullpi
                        rows[7][6] = @nullpi
                        raise StandardError.new ("Illegal Move Made!")
                    end
                    rows[7][5] = rows[7][7]
                    rows[7][5].pos = [7,5]
                    rows[7][7] = @nullpi
                else
                    raise StandardError.new ("Illegal Move Made!")
                end
            elsif piece.color == :black && @black_king.moved == false && start_pos == [0,4]
                if (end_pos == [0,2] || end_pos == [0,1] )&& rows[0][0].symbol == :rook && rows[0][0].moved == false && rows[0][1].empty? && rows[0][2].empty? && rows[0][3].empty?
                    rows[0][3] = @black_king
                    rows[0][4] = @nullpi
                    @black_king.pos = [0,3]
                    if (in_check?(:black))
                        rows[0][4] = @black_king
                        rows[0][3] = @nullpi
                        @black_king.pos = [0,4]
                        raise StandardError.new ("Illegal Move Made!")
                    end
                    rows[0][2] = @black_king
                    rows[0][3] = @nullpi
                    if (in_check?(:black))
                        rows[0][4] = @black_king
                        @black_king.pos = [0,4]
                        rows[0][3] = @nullpi
                        rows[0][2] = @nullpi
                        raise StandardError.new ("Illegal Move Made!")
                    end
                    rows[0][3] = rows[0][0]
                    @rows[0][3].pos = [0,3]
                    rows[0][0] = @nullpi #2 more cases to-do for blocks
                elsif end_pos == [0,6] && rows[0][7].symbol == :rook && rows[0][7].moved == false && rows[0][5].empty? && rows[0][6].empty?
                    rows[0][5] = @black_king
                    @black_king.pos = [0,5]
                    rows[0][4] = @nullpi
                    if (in_check?(:black))
                        rows[0][4] = @black_king
                        @black_king.pos = [0,4]
                        rows[0][5] = @nullpi
                        raise StandardError.new ("Illegal Move Made!")
                    end
                    rows[0][6] = @black_king
                    @black_king.pos = [0,6]
                    rows[0][5] = @nullpi
                    if (in_check?(:black))
                        rows[0][4] = @black_king
                        @black_king.pos = [0,4]
                        rows[0][5] = @nullpi
                        rows[0][6] = @nullpi
                        raise StandardError.new ("Illegal Move Made!")
                    end
                    rows[0][5] = rows[0][7]
                    rows[0][5].pos = [0,5]
                    rows[0][7] = @nullpi
                else
                    raise StandardError.new ("Illegal Move Made!")
                end
            else
                raise StandardError.new ("Illegal Move Made!")
            end
        else
            raise StandardError.new ("Illegal Move Made!")
        end
    end

    def in_check?(color, modified=nil)
        #two kings?
        if color == :black
            bkp = black_king.pos
            white_pieces.each do |piece|
                next if modified != nil && piece.pos == modified
                if piece.attack_moves.include?(bkp) #moves also works
                    return true
                end
            end
            return false
        else #repetiive code but idc
            wkp = white_king.pos
            black_pieces.each do |piece|
                next if modified != nil && piece.pos == modified
                if piece.attack_moves.include?(wkp)
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
            if piece.valid_moves.length > 0
                return false
            end
            # x,y = piece.pos
            # self[[x,y]] = @nullpi
            
            # # piece.moves.each do |potential_move|
            # #     a,b = potential_move
            # #     temp = self[[a,b]]
            # #     self[[a,b]] = piece
            # #     piece.pos = [a,b] #
            
            # #     if !in_check?(color, [a,b])
            # #         c_mate = false
            # #     end

            # #     # if piece.symbol == :king
            # #     #     if !in_check?(color, [a,b], potential_move)
            # #     #         c_mate = false
            # #     #     end
            # #     # else
            # #     #     if !in_check?(color, [a,b])
            # #     #         c_mate = false
            # #     #     end
            # #     # end

            # #     self[[a,b]] = temp
            # #     if !c_mate
            # #         self[[x,y]] = piece
            # #         piece.pos = [x,y]
            # #         return false
            # #     end
            # # end
            # self[[x,y]] = piece
            # piece.pos = [x,y] 
        end
        return c_mate
    end

    def checkmate_dodger_hard

        @nullpi = NullPiece.instance
        
        (0..7).each do |x|
            (0..7).each do |y|
                self[[x,y]] = @nullpi
            end
        end

        @white_king = King.new(:white,self,[1,2])
        self[[1,2]] = @white_king
        @black_king =  King.new(:black,self,[5,5])
        self[[5,5]] = @black_king

        self[[1,7]] = Rook.new(:black,self,[1,7])
        self[[2,6]] = Rook.new(:black,self,[2,6])
        self[[2,1]] = Knight.new(:white,self,[2,1])
        self[[3,0]] = Bishop.new(:black,self,[3,0])
        self[[5,4]] = Bishop.new(:white, self, [5,4])
        self[[7,1]] = Rook.new(:white,self,[7,1])
        self[[6,1]] = Queen.new(:white, self, [6,1])

        #remove


        (0..7).each do |x|
            (0..7).each do |y|
                if rows[x][y].color == :white
                    white_pieces << rows[x][y]
                elsif rows[x][y].color == :black
                    black_pieces << rows[x][y]
                end
            end
        end
    end

    def easy_take_piece

        @nullpi = NullPiece.instance
        
        (0..7).each do |x|
            (0..7).each do |y|
                self[[x,y]] = @nullpi
            end
        end

        @white_king = King.new(:white,self,[7,4])
        self[[7,4]] = @white_king
        @black_king =  King.new(:black,self,[0,4])
        self[[0,4]] = @black_king

        self[[3,7]] = Queen.new(:white,self,[3,7])
        self[[3,6]] = Rook.new(:black,self,[3,6])
        self[[2,6]] = Knight.new(:black,self,[2,6])
        self[[4,7]] = Pawn.new(:black,self,[4,7])
        self[[2,5]] = Pawn.new(:black, self, [2,5])
        self[[1,7]] = Bishop.new(:black, self, [1,7])


        (0..7).each do |x|
            (0..7).each do |y|
                if rows[x][y].color == :white
                    white_pieces << rows[x][y]
                elsif rows[x][y].color == :black
                    black_pieces << rows[x][y]
                end
            end
        end
    end
end

def easy_checkmate
    @nullpi = NullPiece.instance
        
    (0..7).each do |x|
        (0..7).each do |y|
            self[[x,y]] = @nullpi
        end
    end

    @white_king = King.new(:white,self,[7,7])
    self[[7,7]] = @white_king
    @black_king =  King.new(:black,self,[0,0])
    self[[0,0]] = @black_king

    self[[1,5]] = Rook.new(:white,self,[1,5])
    self[[2,6]] = Rook.new(:white,self,[2,6])


    (0..7).each do |x|
        (0..7).each do |y|
            if rows[x][y].color == :white
                white_pieces << rows[x][y]
            elsif rows[x][y].color == :black
                black_pieces << rows[x][y]
            end
        end
    end

end

