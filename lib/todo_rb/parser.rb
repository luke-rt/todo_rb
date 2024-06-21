require "optparse"

module TodoRb
  class Parser
    def initialize(args)
      @args = args
      @options = {}
    end

    def parse!
      global = OptionParser.new do |opts|
        opts.banner = "Usage: todo [command] [options]"

        opts.on("-h", "--help") do |h|
          puts opts
          exit 0
        end

        opts.on("-V", "--version") do |h|
          puts VERSION
          exit 0
        end

        opts.separator ""
        opts.separator <<~COMMAND
          Commands:
            list    List all todos
            add     Add a new todo
            delete  Delete a todo
            mark    Mark a todo as complete
            unmark  Mark a todo as incomplete
        COMMAND
      end

      commands = {
        "list" => OptionParser.new do |opts|
          opts.banner = "Usage: todo list [options]"

          opts.on("-c", "--complete", "Show only complete todos") do |c|
            @options[:complete] = c
          end
          opts.on("-i", "--incomplete", "Show only incomplete todos") do |i|
            @options[:incomplete] = i
          end
        end,
        "add" => OptionParser.new do |opts|
          opts.banner = "Usage: todo add <todo>"
        end,
        "delete" => OptionParser.new do |opts|
          opts.banner = "Usage: todo delete <id>"
        end,
        "mark" => OptionParser.new do |opts|
          opts.banner = "Usage: todo mark <id>"
        end,
        "unmark" => OptionParser.new do |opts|
          opts.banner = "Usage: todo unmark <id>"
        end
      }

      global.order!
      @options[:command] = ARGV.shift
      if @options[:command].nil?
        puts "global"
      end
      if commands[@options[:command]].nil?
        puts "Invalid command '#{@options[:command]}'"
        exit 1
      end
      commands[@options[:command]].order!

      case @options[:command]
      when "list"
        if @options[:complete] && @options[:incomplete]
          puts "Cannot use both --complete and --incomplete"
          exit 1
        end
        if @options[:complete].nil? && @options[:incomplete].nil?
          @options[:complete] = true
          @options[:incomplete] = true
        end
        if !ARGV.empty?
          puts "Invalid arguments for command 'list'"
          puts ""
          puts commands["list"]
          exit 1
        end
      else
        if ARGV.empty?
          puts "Missing arguments for command '#{@options[:command]}'"
          puts ""
          puts commands[@options[:command]]
          exit 1
        end
        @options[:args] = ARGV
      end

      @options
    end
  end
end
