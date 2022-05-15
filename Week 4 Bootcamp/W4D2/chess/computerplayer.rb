class ComputerPlayer < Player
    attr_reader :my_pieces, :their_pieces, :display, :color

    def initialize(color, display)
        super
        
        if color == :white
            @my_pieces = display.board.white_pieces
            @their_pieces = display.board.black_pieces
        else
            @my_pieces = display.board.black_pieces
            @their_pieces = display.board.white_pieces
        end
    end

    #add castling AND add pawn promotion LATERR
    def make_move
        p "Thinking..."
        # if board.in_check?(color) #if we're in check, let's get out of check
            #avoid incoming checkmate
            @display.render
            #avoid losing pieces tho!!
            best_move = [] #CHANGE INTO ARRAY AND SAMPLE IT LATER
            best_score = nil
            best_piece = nil
            if color == :white
                enemy = :black
            else
                enemy = :white
            end
            my_pieces.each do |wp|
                wp.valid_moves.each do |mov| 
                    score = 0
                    #PREPROCESS ALL THINGS THAT CHECK-> SEE IF THEY LEAD INTO CHECKMATE IN 1!! 
                    

                    if board[mov].empty?
                        debugger if mov == [0,6]
                        old_pos = wp.pos
                        board[mov] = wp
                        board[old_pos] = board.nullpi
                        wp.pos = mov

                        # p "bro..."
                        if board.in_check?(enemy)
                            score += 1
                            p "ok?"
                            if board.checkmate?(enemy)
                                # p "?"
                                wp.pos = old_pos
                                board[old_pos] = wp
                                board[mov] = board.nullpi
                                board.move_piece(wp.pos, mov)
                                return
                                
                            end
                        end

                        t = try_move(board, 2)
                        score += t
                        # p "nopie?"
                        # p wp.symbol
                        # p board[old_pos].symbol
                        # p mov
                        # p "t: #{t}"
                        # p "score: #{score}"   

                        wp.pos = old_pos
                        board[old_pos] = wp
                        board[mov] = board.nullpi
                        # if t > 1000 #this move causes checkmate, prematurely stop checking through moves <--- PROBLEM CHECKMATE IN 3 OVERRIDING
                        #     board.move_piece(wp.pos, mov)
                        #     return
                        # end
                    else
                        # p "..."
                        temp = board[mov]
                        case temp.symbol
                        when :queen
                            score += 27
                            # p "SHOULD NOT GET HERE"
                        when :knight, :bishop
                            score += 9
                        when :rook
                            score += 15
                        when :pawn
                            score += 3
                        end

                        their_pieces.delete(temp)
                        
                        old_pos = wp.pos
                        board[mov] = wp
                        wp.pos = mov
                        board[old_pos] = board.nullpi
                        

                        if board.in_check?(enemy)
                            # p "how lol"
                            score += 1
                            if board.checkmate?(enemy)
                                # p "dude"
                                wp.pos = old_pos
                                board[old_pos] = wp
                                board[mov] = board.nullpi
                                their_pieces << temp
                                board.move_piece(wp.pos, mov)
                                return
                                
                            end
                        end
                        
                        t = try_move(false, 2)
                        score += t 
                        # p "huh?"
                        # p wp.symbol
                        # p temp.symbol
                        # p mov
                        # p "t: #{t}"
                        # p "score: #{score}"                  

                        board[mov] = temp
                        their_pieces << temp
                        wp.pos = old_pos
                        board[old_pos] = wp

                        # if t>1000
                        #     board.move_piece(wp.pos, mov) 
                        #     return
                        # end
                    end

                    if best_score == nil || score > best_score
                        best_score = score
                        best_move = [[mov, wp]]
                    elsif score == best_score
                        best_move << [mov, wp]
                    end
                
                end
            end
            #no way out then do random
            puts "best score:"
            puts best_score[0]
            puts "best piece:"
            bb = best_move.sample
            puts bb[1].symbol 
            puts "moves to"
            p bb[0]

            board.move_piece(bb[1].pos, bb[0])

        # end 

        #check if we have incoming checkmate
    end

    def try_move(my_turn, depth) #don't need board
        return 0 if depth == 0
        if my_turn == true ##################################################################
            highest = nil #get the lowest we can
            my_pieces.each do |enemy_piece| ##########################################################
                enemy_piece.valid_moves.each do |mov|
                    score = 0
                    needs_replacement = !board[mov].empty?
                    temp = board[mov]
                    if needs_replacement
                        case temp.symbol
                            when :queen
                                score = 27
                                # p "SHOULD NOT GET HERE"
                            when :knight, :bishop
                                score = 9
                            when :rook
                                score = 15
                            when :pawn
                                score = 3
                        end
                        their_pieces.delete(temp)
                    end
                    old_pos = enemy_piece.pos
                    board[mov] = enemy_piece
                    enemy_piece.pos = mov
                    board[old_pos] = board.nullpi

                    if color == :white
                        enemy = :black
                    else
                        enemy = :white
                    end
                    if board.in_check?(enemy)
                        score += 1
                        if board.checkmate?(enemy)
                            enemy_piece.pos = old_pos
                            board[old_pos] = enemy_piece
                            board[mov] = temp
                            if needs_replacement
                                their_pieces << temp
                            end
                            return 10000 * (depth + 1)
                            
                        end
                    end

                    t = try_move(!my_turn, depth - 1)
                    score += t

                    enemy_piece.pos = old_pos
                    board[old_pos] = enemy_piece
                    board[mov] = temp
                    if needs_replacement
                        their_pieces << temp
                    end
                    if highest == nil || score > highest
                        highest = score
                    end
                end
            end
            return highest #if still nil, might be stalemate
        else #not my turn
            lowest = nil #get the lowest we can
            their_pieces.each do |enemy_piece|
                enemy_piece.valid_moves.each do |mov|
                    score = 0
                    needs_replacement = !board[mov].empty?
                    temp = board[mov]
                    if needs_replacement
                        case temp.symbol
                            when :queen
                                score = -27
                                # p "should get here..."
                            when :knight, :bishop
                                score = -9
                            when :rook
                                score = -15
                            when :pawn
                                score = -3
                        end
                        their_pieces.delete(temp)
                    end

                    old_pos = enemy_piece.pos

                    board[mov] = enemy_piece
                    enemy_piece.pos = mov
                    board[old_pos] = board.nullpi

                    enemy = color
                    if board.in_check?(enemy)
                        score -= 1
                        if board.checkmate?(enemy)
                            enemy_piece.pos = old_pos
                            board[old_pos] = enemy_piece
                            board[mov] = temp
                            if needs_replacement
                                their_pieces << temp
                            end
                            return -10000 * (depth + 1)
                        end
                    end

                   
                    t = try_move(!my_turn, depth - 1)
                    score += t

                    enemy_piece.pos = old_pos
                    board[old_pos] = enemy_piece
                    board[mov] = temp
                    if needs_replacement
                        their_pieces << temp
                    end
                    if lowest == nil || score < lowest
                        lowest = score
                    end

                end
            end
            return lowest #if still nil, might be stalemate
        end
    end


    # def try_move(board, depth=1)
    #     stack = Array.new
    #     #[start_pos, end_position, replaced_piece, score] <- Stack elements
    #     best_score = nil

    #     p "checking...: "
    #     p their_pieces
    #     their_pieces.each do |enemy_pieces|
    #         enemy_pieces.valid_moves.each do |mov|
    #             if board[mov].empty?
    #                 stack.push([[enemy_pieces.pos, mov, nil, 0]])
    #             else
    #                 #delete here
    #                 temp = board[mov]
    #                 case board[mov].symbol
    #                 when :queen
    #                     stack.push([[enemy_pieces.pos, mov, nil, -9]])
    #                 when :knight, :bishop
    #                     stack.push([[enemy_pieces.pos, mov, nil, -3]])
    #                 when :rook
    #                     stack.push([[enemy_pieces.pos, mov, nil, -5]])
    #                 when :pawn
    #                     stack.push([[enemy_pieces.pos, mov, nil, -1]])
    #                 end
    #             end
    #         end
    #     end
        
    #     while(!stack.empty?)
    #         top = stack.pop
            
    #         if top.length == depth
    #             if best_score == nil || top[-1][3] < best_score
    #                 best_score = top[-1][3]
    #             end
    #         # elsif curr_color != color

    #         # else
    #         end
    #         depth -= 1
    #     end
    #     return best_score
    # end

end