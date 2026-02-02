@Test
def topRowAll1sMeans1Won(): Unit \ Assert = 
    let won = region rc {
        let board = Array#{
            Array#{1, 1, 1} @ rc,
            Array#{0, 0, 0} @ rc,
            Array#{0, 0, 0} @ rc
        } @ rc;
        checkWinner(board)
    };
    Assert.assertEq(expected = 1, won)

@Test
def leftColumnAll1sMeans1Won(): Unit \ Assert = 
    let won = region rc {
        let board = Array#{
            Array#{1, 0, 0} @ rc,
            Array#{1, 0, 0} @ rc,
            Array#{1, 0, 0} @ rc
        } @ rc;
        checkWinner(board)
    };
    Assert.assertEq(expected = 1, won)

@Test
def leftDiagonalAll2sMeans2Won(): Unit \ Assert = 
    let won = region rc {
        let board = Array#{
            Array#{2, 0, 0} @ rc,
            Array#{1, 2, 0} @ rc,
            Array#{1, 0, 2} @ rc
        } @ rc;
        checkWinner(board)
    };
    Assert.assertEq(expected = 2, won)

@Test 
def initialBoardHasWinner0(): Unit \ Assert = 
    region rc {
        let board = createBoard(rc);
        let winner = checkWinner(board);
        Assert.assertEq(expected = 0, winner)
    }