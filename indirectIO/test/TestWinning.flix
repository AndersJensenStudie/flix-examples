@Test
def topRowAll1sMeans1Won(): Bool = 
    let won = region rc {
        let board = Array#{
            Array#{1, 1, 1} @ rc,
            Array#{0, 0, 0} @ rc,
            Array#{0, 0, 0} @ rc
        } @ rc;
        checkWinner(board)
    };
    won == 1

@Test
def leftColumnAll1sMeans1Won(): Bool = 
    let won = region rc {
        let board = Array#{
            Array#{1, 0, 0} @ rc,
            Array#{1, 0, 0} @ rc,
            Array#{1, 0, 0} @ rc
        } @ rc;
        checkWinner(board)
    };
    won == 1

@Test
def leftDiagonalAll2sMeans2Won(): Bool = 
    let won = region rc {
        let board = Array#{
            Array#{2, 0, 0} @ rc,
            Array#{1, 2, 0} @ rc,
            Array#{1, 0, 2} @ rc
        } @ rc;
        checkWinner(board)
    };
    won == 2

@Test 
def initialBoardHasWinner0(): Bool = 
    region rc {
        let board = createBoard(rc);
        let winner = checkWinner(board);
        winner == 0
    }