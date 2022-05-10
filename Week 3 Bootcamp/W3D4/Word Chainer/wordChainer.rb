require 'set'

class WordChainer
    ALPHABET = "abcdefghijklmnopqrstuvwxyz"
    attr_accessor :dictionary, :current_words

    def initialize(dictionary_file_name)
        file = File.open(dictionary_file_name)
        @dictionary = Set.new
        file.readlines.each do |line|
            @dictionary.add(line.chomp)
        end
    end

    def adjacent_words(word)
        ans = []
        (0...word.length).each do |i|
            ALPHABET.each_char do |letter|
                s = word[0...i] + letter + word[i+1...word.length]
                if @dictionary.include?(s)
                    ans << s 
                end
            end
        end
        ans
    end

    def run(source, target)
        current_words = [source]
        all_seen_words = {source => nil}
        while (!current_words.empty?)
            new_current_words = []
            current_words.each do |cw|
                adjacent_word_list = adjacent_words(cw)
                adjacent_word_list.each do |adjacent_word|
                    if all_seen_words.keys.include?(adjacent_word)
                        #skip
                    else
                        new_current_words << adjacent_word
                        all_seen_words[adjacent_word] = cw
                    end
                end
            end
            new_current_words.each do |nw|
                p "#{nw} came from: #{all_seen_words[nw]}"
            end
            current_words = new_current_words
        end
    end

end

if __FILE__ == $PROGRAM_NAME
    w = WordChainer.new("dictionary.txt")
    p w.adjacent_words("cat")
    w.run("cat", "bat")
end

