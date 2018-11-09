# puzzle = [[5,3,0,0,7,0,0,0,0],
#           [6,0,0,1,9,5,0,0,0],
#           [0,9,8,0,0,0,0,6,0],
#           [8,0,0,0,6,0,0,0,3],
#           [4,0,0,8,0,3,0,0,1],
#           [7,0,0,0,2,0,0,0,6],
#           [0,6,0,0,0,0,2,8,0],
#           [0,0,0,4,1,9,0,0,5],
#           [0,0,0,0,8,0,0,7,9]]

def sudoku(puzzle)
  start_puzzle(puzzle)
  solve(puzzle)
end

def start_puzzle(puzzle)
  puzzle.map!{|line| create_unsolved_squares(line)}
end

def create_unsolved_squares(line)
  line.map!{|square| square != 0 ? square : Array(1..9)}
end

def solve(puzzle)
  horizontal_solve(puzzle)
  puzzle = vertical_solve(puzzle)
end

def horizontal_solve(puzzle)
  puzzle.map!{|line| solve_line(line)}
end

def vertical_solve(puzzle)
  transposed_puzzle = puzzle.transpose
  horizontal_solve(transposed_puzzle).transpose
end

def solve_line(line)
  line.map! do |square|
    solve_square(line, square)
  end
end

def solve_square(line, square)
  return square if square.is_a?(Integer)
  square.reject!{|number| line.include?(number)}
  square
end