require 'colorize'

class Board 
    def initialize(board)
        @board = inpupt_board(board)
        @has_won = false
    end

    def has_won
        return @has_won
    end

    def update_won
        @has_won = true
    end

    def inpupt_board(board)
        final_board = []
        board.each_with_index do |row, i|
            final_board << row[0].split(' ').map! {|e|  [e.strip, false] } 
        end
        return final_board
    end

    def update_number(number)
        return if @has_won == true
        @board.each_with_index do |row, i|
            row.each_with_index do |cell, j|
                if cell[0].to_i == number.to_i
                    @board[i][j] = [number, true]
                end
            end
        end
    end

    def score_board(last_called) 
        final_total = 0

        @board.each do |row|
            row.each do |cell|
                if cell[1] == false
                    final_total += cell[0].to_i
                end
            end
        end

        return final_total*last_called.to_i
    end

    def print_board
        @board.each do |row|
            row.each do |cell|
                if cell[1] == true
                    print cell[0].to_s.colorize(:green) + " "
                else
                    print cell[0].to_s.colorize(:red) + " "
                end
            end
            puts
        end
    end

    def check_for_win
        return true if @has_won == true 

        @board.each do |row|
            if row.all? { |cell| cell[1] == true }
                return true
            end
        end

        @board.transpose.each do |column|
            if column.all? { |cell| cell[1] == true }
                return true
            end
        end

        # if @board[0][0][1] && @board[1][1][1] && @board[2][2][1] && @board[3][3][1] && @board[4][4][1]
        #     return true
        # end

        # if @board[0][4][1] && @board[1][3][1] && @board[2][2][1] && @board[3][1][1] && @board[4][0][1]
        #     return true
        # end

        return false
    end
end

def play_bingo_to_win(input_file)
    file_array = File.readlines(input_file)
    numbers_to_pull = file_array[0].split(',').map(&:to_i)
    board_array = []
    board_buffer = []

    file_array.each_with_index do |row, i|
        if i == 0
            next
        end

        if row == "\n" && board_buffer.length == 0
            next
        elsif row == "\n" && board_buffer.length != 0
            board = Board.new(board_buffer)
            board_buffer = []
            board_array << board
        else
            board_buffer << [row]
        end
    end

    board = Board.new(board_buffer)
    board_array << board

    numbers_to_pull.each do |number|
        board_array.each do |board|
            
            board.update_number(number)
            win = board.check_for_win
            if win == true
                return board.score_board(number)
            end
        end
    end

    return false
end

def play_bingo_to_lose(input_file)
    file_array = File.readlines(input_file)
    numbers_to_pull = file_array[0].split(',').map(&:to_i)
    board_array = []
    board_buffer = []

    file_array.each_with_index do |row, i|
        if i == 0
            next
        end

        if row == "\n" && board_buffer.length == 0
            next
        elsif row == "\n" && board_buffer.length != 0
            board = Board.new(board_buffer)
            board_buffer = []
            board_array << board
        else
            board_buffer << [row]
        end
    end

    board = Board.new(board_buffer)
    board_array << board

    last_won = nil
    last_number = nil
    numbers_to_pull.each do |number|
        board_array.each do |board|
            
            board.update_number(number)
            win = board.check_for_win
            if win == true && board.has_won == false
                board.update_won
                last_number = number
                last_won =  board
            end
        end
    end

    return last_won.score_board(last_number)
end

p play_bingo_to_lose('input.txt')