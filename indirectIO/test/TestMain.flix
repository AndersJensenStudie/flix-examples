@Test 
def printingAnEmptyBoardLooksCorrect(): Unit \ Assert = 
    region rc {
        let str = run {
                let board = createBoard(rc);
                printBoard(board);
                ""
        } with handler Console {
            def print(msg, resume) = msg + resume()
            def println(msg, resume) = msg + "\n" + resume()
            def eprint(_msg, resume) = resume()
            def eprintln(_msg, resume) = resume()
            def readln(resume) = resume("")
        };
        Assert.assertEq(expected = "[000]\n[000]\n[000]\n", str)
    }

@Test 
def piece1CanBePlacedIn00(): Unit \ Assert = 
    region rc {
        let str = run {
                let board = createBoard(rc);
                let _ = placePiece(1, 0, 0, board);
                printBoard(board);
                ""
        } with handler Console {
            def print(msg, resume) = msg + resume()
            def println(msg, resume) = msg + "\n" + resume()
            def eprint(_msg, resume) = resume()
            def eprintln(_msg, resume) = resume()
            def readln(resume) = resume("")
        };
        Assert.assertEq(expected = "[100]\n[000]\n[000]\n", str)
    }

@Test
def piece2CannotBePlacedWherePiece1Is(): Unit \ Assert = 
    region rc {
        let str = run {
                let board = createBoard(rc);
                let _ = placePiece(1, 0, 0, board);
                let _ = placePiece(2, 0, 0, board);
                printBoard(board);
                ""
        } with handler Console {
            def print(msg, resume) = msg + resume()
            def println(msg, resume) = msg + "\n" + resume()
            def eprint(_msg, resume) = resume()
            def eprintln(_msg, resume) = resume()
            def readln(resume) = resume("")
        };
        Assert.assertEq(expected = "[100]\n[000]\n[000]\n", str)
    }

@Test
def placeRandomPiecePlacesAPieceIn22(): Unit \ Assert = 
    region rc {
        let str = run {
                let board = createBoard(rc);
                let _ = placeRandomPiece(1, board);
                printBoard(board);
                ""
        } with handler Console {
            def print(msg, resume) = msg + resume()
            def println(msg, resume) = msg + "\n" + resume()
            def eprint(_msg, resume) = resume()
            def eprintln(_msg, resume) = resume()
            def readln(resume) = resume("")
        } with handler Random {
            def randomInt32(resume) = resume(2)
            def randomInt64(resume) = resume(Int32.toInt64(0))
            def randomFloat32(resume) = resume(Float32.nan())
            def randomFloat64(resume) = resume(0.0)
            def randomGaussian(resume) = resume(0.0)
            def randomBool(resume) = resume(false)
        };
        Assert.assertEq(expected = "[000]\n[000]\n[001]\n", str)
    }

@Test 
def correctlySee9FreeSpaces(): Unit \ Assert = 
    let n = region rc {
        let board = createBoard(rc);
        amountOfFreeSpaces(board)
    };
    Assert.assertEq(expected = 9, n)

@Test 
def correctlySee5FreeSpaces(): Unit \ Assert = 
    let n = region rc {
        let board = Array#{
            Array#{2, 0, 0} @ rc,
            Array#{0, 2, 0} @ rc,
            Array#{1, 0, 2} @ rc
        } @ rc;
        amountOfFreeSpaces(board)
    };
    Assert.assertEq(expected = 5, n)
