require "byebug"

class AiPlayer
    attr_reader :name
    attr_accessor :losses

    def initialize(name)
        @name = name
        @losses = 0
    end

    # def guess(num_players, fragment, dict)
    #     #This implication is almost exactly as spec wished for, except 
    #     #that it didn't mention if choices with n+1 or more possibiliteis
    #     #were losers or winners, so I made them-inbetween
    #     losers = []
    #     better_losers = []
    #     dict[fragment].each do |choice|
    #         if dict[fragment + choice].include?("*")
    #             losers << choice
    #         elsif dict[fragment + choice].length <=num_players
    #             return choice #found winner
    #         else
    #             better_losers << choice
    #         end
    #     end
    #     if better_losers.empty?
    #         return losers.sample
    #     else
    #         return better_losers.sample
    #     end
    # end

    def guess(num_players, fragment, dict)
        superlosers = []
        stack = []
        winners = Hash.new(Array.new(2))

        dict[fragment].each do |choice|
            if dict[fragment + choice].include?("*")
                superlosers << choice
            else
                winners[choice] = [0,0]
                stack.push(fragment + choice)
            end
        end
        while(!stack.empty?)
            top = stack.pop
            dict[top].each do |choice|
                temp = top + choice
                if dict[temp].include?("*")
                    if (temp.length - fragment.length - 1) % num_players == 0
                        winners[temp[fragment.length]][1] += 1
                    else
                        winners[temp[fragment.length]][0] += 1
                    end
                else
                    stack.push(temp)
                end
            end
        end

        if winners.length == 0
            return superlosers.sample
        else
            winners.each do |k, v| #guranteed
                if v[1] == 0
                    return k
                end
            end
            w = winners.max_by{|k, v| (v[0] + 0.0)/(v[1])}
            return w[0]
        end
    end
end
            
                


