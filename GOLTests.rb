load 'project.rb'

def runTest(init_board, expected_board, test_number)
    actual_next_board = nextBoardState(init_board)
    if actual_next_board == expected_board
        puts "PASSED " + test_number.to_s
    else
        puts "FAILED" + test_number.to_s + "!"
        puts "Expected:"
        puts expected_board.map { |x| x.join(' ') }
        puts "Actual:"
        puts actual_next_board.map { |x| x.join(' ') }
    end
end

    # TEST 1: dead cells with no live neighbors
    # should stay dead.
    init_state1 = [
        [0,0,0],
        [0,0,0],
        [0,0,0]
    ]
    expected_next_state1 = [
        [0,0,0],
        [0,0,0],
        [0,0,0]
    ]

    runTest(init_state1, expected_next_state1, 1)

    # TEST 2: dead cells with exactly 3 neighbors
    # should come alive.
    init_state2 = [
        [0,0,1],
        [0,1,1],
        [0,0,0]
    ]
    expected_next_state2 = [
        [0,1,1],
        [0,1,1],
        [0,0,0]
    ]
    runTest(init_state2, expected_next_state2, 2)

    # TEST 3: live cells with exactly 0 neighbors
    # should become dead.
    init_state3 = [
        [0,1,0],
        [0,0,0],
        [1,0,0]
    ]
    expected_next_state3 = [
        [0,0,0],
        [0,0,0],
        [0,0,0]
    ]

    runTest(init_state3, expected_next_state3, 3)

    # TEST 4: live cells with exactly 1 neighbors
    # should become dead.
    init_state4 = [
        [0,1,0],
        [0,1,0],
        [0,0,0]
    ]
    expected_next_state4 = [
        [0,0,0],
        [0,0,0],
        [0,0,0]
    ]
    
    runTest(init_state4, expected_next_state4, 4)

    # TEST 5: live cells with exactly 2 neighbors
    # should stay alive.
    init_state5 = [
        [1,1,1],
        [0,0,0],
        [0,0,0]
    ]
    expected_next_state5 = [
        [0,1,0],            #[0][0] and [0][2] will die because they have just 1 neighbor
        [0,1,0],            #[1][1] will come alive because it has 3 neighbors   
        [0,0,0]
    ]
    
    runTest(init_state5, expected_next_state5, 5)

    # TEST 6: live cells with exactly 3 neighbors
    # should stay alive.
    init_state6 = [
        [0,1,1],
        [0,1,1],
        [0,0,0]
    ]
    expected_next_state6 = [
        [0,1,1],
        [0,1,1],
        [0,0,0]
    ]
    
    runTest(init_state6, expected_next_state6, 6)

    # TEST 7: live cells with more than 3 neighbors
    # should die.
    init_state7 = [
        [1,1,1],
        [0,1,1],
        [0,0,0]
    ]
    expected_next_state7 = [
        [1,0,1],
        [1,0,1],            #[1][0] comes to life because its surrounded by 3
        [0,0,0]
    ]
    
    runTest(init_state7, expected_next_state7, 7)