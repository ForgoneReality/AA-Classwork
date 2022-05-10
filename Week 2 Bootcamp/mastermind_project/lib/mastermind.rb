require_relative "code"

class Mastermind

    def initialize(length)
        @secret_code = Code.random(length)
    end

    def print_matches(c)
        p c.num_exact_matches(@secret_code)
        p c.num_near_matches(@secret_code)
    end

    def ask_user_for_guess
        p "Enter a code"
        inp = gets
        c = Code.from_string(inp.chomp)
        print_matches(c)
        return c == @secret_code
    end

end
