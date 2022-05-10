def all_words_capitalized?(arr)
    arr.all? {|ele| ele == ele.capitalize}
end

def no_valid_url?(arr)
    #assuming no tiny invalid urls
    arr.none? {|ele| ele[-3..-1] == '.io' ||  ele[-4..-1] == '.com' || ele[-4..-1] == '.net' || ele[-4..-1] == '.org'}
end

def any_passing_students?(arr)
    arr.any? {|student| (student[:grades].sum)/(student[:grades].length) >= 75}
end