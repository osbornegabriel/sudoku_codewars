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
    # p "It's Coming..."
  puzzle = box_solve(puzzle)
end

def horizontal_solve(puzzle)
  puzzle.map!{|line| solve_line(line)}
end

def vertical_solve(puzzle)
  puzzle
  transposed_puzzle = puzzle.transpose
  horizontal_solve(transposed_puzzle).transpose
end

def box_solve(puzzle)
  box_puzzle = box_unbox(puzzle)
  horizontal_solve(box_puzzle)
  box_unbox(box_puzzle)
end

def solve_line(line)
  line.map!{|square| solve_square(line, square)}
end

def solve_square(line, square)
  return square if square.is_a?(Integer)
  square.reject!{|number| line.include?(number)}
  square
end

def box_unbox(puzzle)
  thirded_puzzle = third_it(puzzle)
  boxed_puzzle = thirded_puzzle.map!{|third| box_it(third)}
  boxed_puzzle.reduce(:+)
end

def third_it(array)
  first_third = array.slice(0,3)
  second_third = array.slice(3,3)
  third_third = array.slice(6,3)
  [first_third, second_third, third_third]
end

def box_it(third_of_puz)
  sequenced = third_of_puz.map{|line| third_it(line)}
  box_one = sequenced.map{|line| line[0]}.reduce(:+)
  box_two = sequenced.map{|line| line[1]}.reduce(:+)
  box_three = sequenced.map{|line| line[2]}.reduce(:+)
  [box_one, box_two, box_three]
end