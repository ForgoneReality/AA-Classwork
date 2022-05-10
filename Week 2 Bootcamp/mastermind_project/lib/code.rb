require "byebug"

class Code
  attr_reader :pegs

  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }

  def self.valid_pegs?(arr)
    arr.all? {|ele| POSSIBLE_PEGS.include?(ele.upcase)}
  end

  def initialize(arr)
    cap = arr.map {|char| char.upcase}
    if Code.valid_pegs?(cap)
      @pegs = cap
    else
      raise ArgumentError.new("Invalid Arguments")
    end
  end

  def self.random(number)
    arr = []
    while(number > 0)
      arr << POSSIBLE_PEGS.keys[rand(0...POSSIBLE_PEGS.length)]
      number -= 1
    end
    Code.new(arr)
  end

  def self.from_string(s)
    Code.new(s.split(""))
  end

  def [](ind)
    @pegs[ind]
  end

  def length
    @pegs.length
  end

  def num_exact_matches(other_code)
    (0...length).count {|i| @pegs[i] == other_code[i]}
  end

  def num_near_matches(other_code)
    count = 0
    annoyed = []
    (0...length).each do |i|
      if @pegs[i] != other_code[i]
        (0...length).each do |j|
          if (other_code[i] == pegs[j] && !(annoyed.include?(j)) && other_code[i] != other_code[j] && i != j)
            count += 1
            annoyed << j
            break
          end
        end
      end
    end
    count
  end

  def ==(other_code)
    if ((length == other_code.length) && num_exact_matches(other_code) == length)
      return true
    else
      return false

    end
  end
  



end
