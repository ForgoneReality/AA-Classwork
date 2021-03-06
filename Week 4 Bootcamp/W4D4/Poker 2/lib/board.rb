require_relative "card.rb"
require_relative "player.rb"
require_relative "hand.rb"
require_relative "deck.rb"
require "colorize"

class Board 

    LEGEND = [nil, 'Single'.colorize(:cyan), 'Single Pair'.colorize(:cyan), 'Double Pair'.colorize(:cyan), 'Three-of-a-Kind'.colorize(:cyan), 'Straight'.colorize(:cyan), 'Flush'.colorize(:cyan), 'Full House'.colorize(:cyan), 'Four-of-a-Kind'.colorize(:cyan), 'Straight Flush'.colorize(:cyan), 'Royal Flush'.colorize(:gold)]

    # 1 move: 1 player move
    # 1 turn: 1 circle of activities around the table
    # 1 round: completion of a flop
    # when does a turn end
        # everyone but one person folds
        # more than two people stick to the end reveal cards at showdown
    attr_accessor :flop, :big_blind_index, :start_bet, :minimum_bet, :count, :players, :main_pot, :dead_players
    attr_reader :num_players, :deck

    def initialize(num_players)
        @flop = []
        @num_players = num_players
        @players = []
        @deck = Deck.new
        @big_blind_index = -1
        # @current_player_index = 1
        @start_bet = 20 # keeps track of minimum start bet for the blind
        @minimum_bet = @start_bet # keeps track of minimum bet player needs to match in order to stay in the game
        @main_pot = 0 #keeps track of of size of the pot in a round
        # @side_pots = [] #used when more than 1 person goes all in and their all-ins are different
        # @player_bets = [] #keeps track of each player's bet in each turn
        @count = 0  #keep tracker of player actions
        @dead_players = [] #just in case needed
    end

    def active_players # players who has not folded
        @players.select {|player| player.active}
    end

    def betting_players # players who has not folded and has not gone all in
        @players.select {|player| player.active && !player.all_in}
    end

    def play_round
        # 0. reset for the new game
        @main_pot = 0
        @big_blind_index = (@big_blind_index + 1) % @num_players
        puts "#{@players[@big_blind_index].name} is the big blind"
        @players.each do |player| 
            player.reset
        end
        @players[@big_blind_index].big_blind  = true
        @minimum_bet = @start_bet
        # 1. dealer draws cards for the round
        reserve_cards = @deck.deal(@num_players)

        
        # 2. pre-flop
        deal_players(reserve_cards)
        play_preflop_turn
        if @players.any? {|player| player.all_in == true} && self.active_players.length > 1
            while @flop.length < 5
                deal_flop(reserve_cards)
            end
        end
        
        # #reset player's current bet and minimum bet for post flop
        # betting_players.each {|player| player.current_bet = 0}
        # @minimum_bet = 0

        # 3. post-flop

        3.times {deal_flop(reserve_cards) if @flop.length == 0}

        while self.active_players.length > 1 && @flop.length < 5
            deal_flop(reserve_cards)
            play_postflop_turn
            if @players.any? {|player| player.all_in == true} && self.active_players.length > 1
                while @flop.length < 5
                    deal_flop(reserve_cards)
                end
            end
        end

        # 4. divide winnings and reveal cards
        if self.active_players.length == 1
            self.active_players[0].chips += @main_pot  # the person who didn't fold gets the pot
        else
            # reveal cards if more than two players reach the last round 
            # r = reveal_cards
            # num_winners = r.length
            # r.each do |winner|
            #     winner += @main_pot / num_winners
            # end
            reveal_cards
        end

        @players.each do |player|
            if player.chips <= 0
                @dead_players<< player
                @players.delete(player)
            end
        end
    end

    def deal_players(cards)
        @players.each do |player|
            player.hand.cards_in_hand << cards.pop
            player.hand.cards_in_hand << cards.pop
        end
    end

    def deal_flop(cards)
        if @flop.length < 5
            @flop << cards.pop
        end
    end

    def play_preflop_turn
       
        blind_player = players[@big_blind_index]
        p blind_player.name
        p blind_player.chips
        p @start_bet
        if blind_player.chips > @start_bet
            blind_player.chips -= @start_bet
            blind_player.current_bet = @start_bet
            @main_pot += @start_bet
        else
            @main_pot += blind_player.chips
            blind_player.current_bet = blind_player.chips
            blind_player.chips = 0
            blind_player.all_in = true
        end
        i = (big_blind_index + 1) % @num_players
        @count = 0  #count reset to 0
        until self.active_players.length < 2 || (count >= betting_players.length && betting_players.all? {|player| player.current_bet == betting_players[0].current_bet}) 
            p "0000000000000000000"
            p "******"
            p "number of count: #{count}"
            p "number of betting player: #{betting_players.length}"
            players.each {|player| p "#{player.name} has #{player.chips}"}
            p "*******"
            players.each {|player| p "#{player.name}'s current bet is #{player.current_bet}"}
            p "*******"
            @players[i].get_move if @players[i].active == true && @players[i].all_in == false
            i = (i+1) % @num_players
            p count >= betting_players.length
            p betting_players.all? {|player| player.current_bet == players[0].current_bet}
        end
        puts "main pot is #{@main_pot}"
        puts "--------------end of preflop--------------------"
    end

    def play_postflop_turn
        #reset player's current bet and minimum bet for post flop
        @players.each {|player| player.current_bet = 0}
        @minimum_bet = 0
        @count = 0 
        i = big_blind_index #big blind always start first in the post flop
        #count reset to 0
        puts "post flop start"
        until self.active_players.length < 2 || (count >= betting_players.length && betting_players.all? {|player| player.current_bet == betting_players[0].current_bet})
            p "0000000000000000000"
            p "******"
            p "number of count: #{count}"
            p "number of betting player: #{betting_players.length}"
            players.each {|player| p "#{player.name} has #{player.chips}"}
            p "*******"
            players.each {|player| p "#{player.name}'s current bet is #{player.current_bet}"}
            p "*******"
            @players[i].get_move if @players[i].active == true && @players[i].all_in == false
            i = (i+1) % @num_players
        end
        puts "main pot is #{@main_pot}"
        puts "--------------end of postflop--------------------"
    end




        #count increase by 1 when player take a move
        #count reset to 0 when a player raise



   

        #minium_bet turns 0 after each turn post flop
        #all players@current_bet turns 0 after completion of each turn



        #if someone went all in, if the person_wins, they only win based on what they put in,
        #the remaining pot goes back to the other players

    def reveal_cards
        best_score = 0
        best_tie_score = 0
        best_bruh_score = nil #second tie-breaker
        best_player = [] #may need something like minheap to handle ties/2nd vs 3rd place etc
        best_hand = nil
        
        #HANDLE TIES!! BEST_PLAYER CAN BE ARRAY OR OTHER CONTAINER FOR NOW 

        ##############################################
        #TESTING PURPOSES
        reserve_cards = @deck.deal(@num_players) 
        deal_players(reserve_cards) 
        self.flop = reserve_cards 
        ##############################################

        @players.each do |player|
            sleep_time = 4
            if player.active
                f = Array.new(9, "") 
                player.hand.small_hand.each do |card|
                    cp = card.card_picture
                    (0..8).each do |i|
                        f[i] += cp[i]
                    end
                end

                f.each_with_index do |ele, i|
                    f[i] = ele + "??? "
                end

                self.flop.each do |card|
                    cp = card.card_picture
                    (0..8).each do |i|
                        f[i] += cp[i]
                    end
                end
                    
                (0..8).each do |line|
                    puts f[line]
                end

                puts "#{player.name}'s Hand".center(23) + "The Flop".center(65)

                puts ""

                puts "#{player.name}'s Hand combined with the Flop's five cards"
                sleep(sleep_time)

                five = Array.new(9, "")

                p_hand, p_score, tie_score, bruh_score = player.hand.best_five



                p_hand.each do |card|
                    cp = card.card_picture
                    (0..8).each do |i|
                        five[i] += cp[i]
                    end
                end

                (0..8).each do |line|
                    puts five[line]
                end

                puts "#{player.name}'s Best Five Cards with a #{LEGEND[p_score]} (rank: #{p_score}, tiebreaker score: #{tie_score})"

                
                p_hand, p_score, tie_score, bruh_score = player.hand.best_five

                puts ""
                puts "????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????"
                puts ""
                sleep(sleep_time)

                #Handle scoring.. below may need readjusting for side pot BS
                if !best_score || p_score > best_score
                    best_player = [player]
                    best_score = p_score
                    best_tie_score = tie_score
                    best_bruh_score = bruh_score
                    best_hand = [p_hand]
                elsif p_score == best_score
                    if tie_score > best_tie_score
                        best_player = [player]
                        best_tie_score = tie_score
                        best_bruh_score = bruh_score
                        best_hand = [p_hand]
                    elsif tie_score == best_tie_score
                        if bruh_score == nil || bruh_score == best_bruh_score #tie
                            best_player << player
                            best_hand << p_hand
                        elsif bruh_score > best_bruh_score
                            best_player = [player]
                            best_bruh_score = bruh_score
                            best_hand = [p_hand]
                        end
                    end
                end
            else
                Card.print_empty_cards
                puts "#{player.name} FOLDED..".center(23)
                sleep(sleep_time)
            end
        end

        if best_player.length == 1
            puts "#{best_player[0].name} WINS $#{@main_pot}!".center(88)
            puts
            fiver = Array.new(9, "")
            best_hand[0].each do |card|
                if card.suit == :hearts || card.suit == :diamonds
                    color = :red
                else
                    color = :white
                end
                fiver[0] += "????????????????????????????????? "
                fiver[1] += "???#{card.type_s.ljust(2)}       ??? "  # use two {} one for char, one for space or char
                fiver[2] += "???         ??? "
                fiver[3] += "???         ??? "
                fiver[4] += "???    #{card.suit_s.colorize(color)}    ??? "
                fiver[5] += "???         ??? "
                fiver[6] += "???         ??? "
                fiver[7] += "???       #{card.type_s.rjust(2)}??? "
                fiver[8] += "????????????????????????????????? "
            end

            (0..8).each do |line|
                puts "              " + fiver[line]
            end
            puts
            puts "Winning Hand".center(86)

            best_player[0].chips += @main_pot

        elsif best_player.length > 1
            if best_player.length == 2
                puts "#{best_player[0].name} and #{best_player[0].name} split the pot for $#{@main_pot/2} each!".center(88)
                puts

                best_player.each do |player|
                    player.chips += @main_pot / 2
                end
            else
                s = ""
                i = 0
                while(i<player.length - 1)
                    s += "#{best_player[i].name}, "
                    i += 1
                end
                puts s + "and #{best_player[-1].name} split the pot for $#{@main_pot/best_player.length} each!"
                puts

                best_player.each do |player|
                    player.chips += @main_pot / best_player.length
                end
            end
        else
            raise StandardError.new("Shouldn't have no best player")
        end

        # #return best_player
        # return best_player

    end


end

# b = Board.new(4)
# b.play_round