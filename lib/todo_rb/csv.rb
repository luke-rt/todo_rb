require "csv"

module TodoRb
  class Csv
    def initialize(filename)
      @filename = filename
    end

    def parse!
      if !File.exist?(@filename)
        CSV.open(@filename, "w", headers: ["Value", "Completed"]) {}
      end
      @table = CSV.read(@filename)
    end

    def save!
      CSV.open(@filename, "w", headers: ["Value", "Completed"]) do |csv|
        @table.each do |row|
          csv << row
        end
      end
    end

    def list
      @table
    end

    def add_rows(values)
      values.each { |value| @table << [value, false] }
    end

    def delete_rows(ids)
      @table = @table.reject.with_index { |_, i| ids.include?(i + 1) }
    end

    def mark_rows(ids)
      @table.each_with_index { |row, i| row[1] = true if ids.include?(i + 1) }
    end

    def unmark_rows(ids)
      @table.each_with_index { |row, i| row[1] = false if ids.include?(i + 1) }
    end
  end
end
