require_relative("./list.rb")

class TodoBoard
    def initialize(labels=[])
        @lists = {}
        labels.each do |label|
            @lists[label] = List.new(label)
        end
    end

    def get_command
        p "Please enter a command"
        cmd, *args = gets.chomp.split(" ")

        case cmd
        when 'mklist'
            if args.length >= 1
                @lists[args[0]] = List.new(args[0])
            end
        when 'ls'
            @lists.keys.each do |k|
                p k
            end
        when 'showall'
            @lists.values.each {|list| list.print}
        when 'mktodo'
            @lists[args[0]].add_item(args[1], args[2], args[3])
        when 'up'
            if args.length > 2
                @lists[args[0]].up((args[1]).to_i, (args[2]).to_i)
            elsif args.length == 2
                @lists[args[0]].up((args[1]).to_i)
            end
        when 'down'
            if args.length > 2
                @lists[args[0]].down((args[1]).to_i, (args[2]).to_i)
            elsif args.length == 2
                @list[args[0]].down((args[1]).to_i)
            end
        when 'swap'
            if args.length > 2
                @lists[args[0]].swap((args[1]).to_i, (args[2]).to_i)
            end
        when 'sort'
            @lists[args[0]].sort_by_date!
        when 'priority'
            @lists[args[0]].print_priority
        when 'print'
            if args.length >= 2
                @lists[args[0]].print_full_item(args[1].to_i)
            else
                @lists[args[0]].print
            end
        when 'toggle'
            if args.length >= 2
                @lists[args[0]].toggle_item(args[1].to_i)
            end
        when 'rm'
            if args.length >= 2
                @lists[args[0]].remove_item(args[1].to_i)
            end
        when 'quit'
            return false
        when 'purge'
            @list.purge
        else
            print "Unrecognized command"
        end

        return true
    end

    def run
        while(get_command)
        end
    end

end

my_todo = TodoBoard.new()
my_todo.run