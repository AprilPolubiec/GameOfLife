srand

def deadBoard(width, height)
	board = []
	height.times do 
		board.push(Array.new(width, 0))
	end
	return board
end

def randomBoard(width,height)
	random_board = deadBoard(width, height)
	random_board.each_with_index {|row, i|
		row.each_with_index {|col, j|
			random_board[i][j] = rand(2)
		}
	}
	return random_board
end

def printBoard(board)
	new_board = deadBoard(board[0].length-1, board.length-1)

	new_board.each_with_index {|row, i|
		row.each_with_index {|col, j|
			if board[i][j] == 1
				new_board[i][j] = '*'
			elsif board[i][j] == 0
				new_board[i][j] = '.'
			end
		}
	}
	puts new_board.map { |x| x.join(' ') }
	puts
end

def checkNeighbors(xcoord, ycoord, board)
	if xcoord == 0
		rowStart = xcoord
		rowEnd = xcoord + 1
	elsif xcoord == board.length-1
		rowStart = xcoord - 1 
		rowEnd = xcoord
	else
		rowStart = xcoord - 1
		rowEnd = xcoord + 1
	end

	if ycoord == 0
		colStart = ycoord
		colEnd = ycoord + 1
	elsif ycoord == board[0].length-1
		colStart = ycoord - 1 
		colEnd = ycoord
	else
		colStart = ycoord - 1
		colEnd = ycoord + 1
	end

	liveNeighborCount = 0

	board[rowStart..rowEnd].each {|row|
		row[colStart..colEnd].each {|col|
			if col == 1
				liveNeighborCount += 1
			end
		}
	}

	if board[xcoord][ycoord] == 1
		liveNeighborCount -= 1
	end

	return liveNeighborCount
end

def nextBoardState(initBoard)
	finalBoard = deadBoard(initBoard[0].length, initBoard.length)
	initBoard.each_with_index{ |row, i|
		row.each_with_index {|col, j|
			case col 
			when 0
				if checkNeighbors(i,j,initBoard) == 3
					finalBoard[i][j] = 1
				else
					finalBoard[i][j] = 0
				end
			when 1
				if (checkNeighbors(i, j, initBoard) <= 1) || (checkNeighbors(i, j, initBoard) > 3)
					finalBoard[i][j] = 0
				else
					finalBoard[i][j] = 1
				end
			end		
		}
	}
	return finalBoard
end

if __FILE__ == $0
	userInput = 0
	while userInput == 0
		puts "Select board size: "
		puts "A. 10x10"
		puts "B. 20x20"
		puts "C. 30x30"
		puts "D. 40x40"
		userInput = gets.chomp.downcase
	end

	case userInput
		when 'a'
			init_board = randomBoard(10,10)
		when 'b'
			init_board = randomBoard(20,20)	
		when 'c'
			init_board = randomBoard(30,30)
		when 'd'
			init_board = randomBoard(40,40)
	end

	printBoard(init_board)
	while true
		init_board = nextBoardState(init_board)
		printBoard(init_board)
	end
end
