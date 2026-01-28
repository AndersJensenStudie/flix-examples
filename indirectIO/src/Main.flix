def main(): Unit \ {Console, IO, NonDet} = 
    region rc {
        run {
            let board = createBoard(rc);
            let playerInTurn = 1;
            recPlayGame(board, playerInTurn)
        } with Random.runWithIO
    }

def recPlayGame(board: Array[Array[Int32, r], r], playerInTurn: Int32): Unit \ r + Console + Random = 
    // play a round
    let _ = placeRandomPiece(playerInTurn, board);
    printBoard(board);
    Console.println("");
    
    // check if there is a winner
    let winner = checkWinner(board);
    if (winner != 0) {
        Console.println("Winner!");
        Console.println(ToString.toString(winner))
    } else if (amountOfFreeSpaces(board) == 0) {
        () 
    } else {
        // setup for next turn
        let newPlayerInTurn = if (playerInTurn == 1) 2 else 1;
        recPlayGame(board, newPlayerInTurn) 
    }

def amountOfFreeSpaces(board: Array[Array[Int32, r], r]): Int32 \ r = 
    let row1 = Array.get(0, board) |> Array.toList;
    let row2 = Array.get(1, board) |> Array.toList;
    let row3 = Array.get(2, board) |> Array.toList;
    let fullList = List.append(row1, List.append(row2, row3));
    let filteredList = List.filter(a -> a == 0, fullList);
    List.length(filteredList)

def createBoard(rc: Region[r]): Array[Array[Int32, r], r] \ r = 
    Array#{
        Array#{0, 0, 0} @ rc,
        Array#{0, 0, 0} @ rc,
        Array#{0, 0, 0} @ rc
    } @ rc

def printBoard(board: Array[Array[Int32, r], r]): Unit \ Console + r = 
    Console.print("[");
    List.forEach(s -> Console.print(ToString.toString(s)), Array.toList(Array.get(0, board)));
    Console.println("]");
    Console.print("[");
    List.forEach(s -> Console.print(ToString.toString(s)), Array.toList(Array.get(1, board)));
    Console.println("]");
    Console.print("[");
    List.forEach(s -> Console.print(ToString.toString(s)), Array.toList(Array.get(2, board)));
    Console.println("]")

def placePiece(piece: Int32, row: Int32, column: Int32, board: Array[Array[Int32, r], r]): Bool \ r = 
    let placement_row = Array.get(row, board);
    let piece_already_there = Array.get(column, placement_row);
    if (piece_already_there == 0) {
        Array.put(piece, column, placement_row);
        true
    } else {
        false
    } 

def placeRandomPiece(playerInTurn: Int32, board: Array[Array[Int32, r], r]): Bool \ r + Random = 
    if (amountOfFreeSpaces(board) > 0) {
        let row = Int32.modulo(Random.randomInt32(), 3);
        let column = Int32.modulo(Random.randomInt32(), 3);
        let success = placePiece(playerInTurn, row, column, board);
        if (success) {
            true
        } else {
            placeRandomPiece(playerInTurn, board)
        }
    } else {
        false
    }
    
