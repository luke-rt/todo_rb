# frozen_string_literal: true

require "todo_rb/version"
require "todo_rb/parser"
require "todo_rb/csv"

module TodoRb
  class Error < StandardError; end

  class App
    def initialize(args)
      @args = args
      @filename = ".todo.csv"
    end

    def run
      options = Parser.new(@args).parse!
      csv = Csv.new(@filename)
      csv.parse!

      case options[:command]
      when "list"
        csv.list.each_with_index { |row, i| puts " #{(row[1] == "true") ? "\u2713" : " "} #{i + 1}. #{row[0]}" }
      when "add"
        csv.add_rows(options[:args])
        csv.save!
      when "delete"
        csv.delete_rows(options[:args].map(&:to_i))
        csv.save!
      when "mark"
        csv.mark_rows(options[:args].map(&:to_i))
        csv.save!
      when "unmark"
        csv.unmark_rows(options[:args].map(&:to_i))
        csv.save!
      end
    end
  end
end
