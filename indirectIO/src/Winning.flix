def checkWinner(board: Array[Array[Int32, r], r]): Int32 \ r = 
    recCheckWinner(2, board)

def getRowAsString(row: Int32, board: Array[Array[Int32, r], r]): String \ r = 
    List.foldLeft((acc -> str -> acc + ToString.toString(str)), "", Array.toList(Array.get(row, board)))

def getColumnAsString(column: Int32, board: Array[Array[Int32, r], r]): String \ r = 
    let row1 = Array.get(0, board);
    let row2 = Array.get(1, board);
    let row3 = Array.get(2, board);
    ToString.toString(Array.get(column, row1)) + 
    ToString.toString(Array.get(column, row2)) + 
    ToString.toString(Array.get(column, row3))

def getDiagonalAsString(diagonal: Int32, board: Array[Array[Int32, r], r]): String \ r = 
    let row1 = Array.get(0, board);
    let row2 = Array.get(1, board);
    let row3 = Array.get(2, board);
    if (diagonal == 1)
        ToString.toString(Array.get(0, row1)) + 
        ToString.toString(Array.get(1, row2)) + 
        ToString.toString(Array.get(2, row3))
    else 
        ToString.toString(Array.get(2, row1)) + 
        ToString.toString(Array.get(1, row2)) + 
        ToString.toString(Array.get(0, row3))

def recCheckWinner(current: Int32, board: Array[Array[Int32, r], r]): Int32 \ r = 
    if (current == 0) {
        0
    } else {
        let wonRow = ToString.toString(current) + ToString.toString(current) + ToString.toString(current);

        if (wonRow == getRowAsString(0, board) 
            or wonRow == getRowAsString(1, board) 
            or wonRow == getRowAsString(2, board)) {
            current
        } else if (wonRow == getColumnAsString(0, board) 
            or wonRow == getColumnAsString(1, board) 
            or wonRow == getColumnAsString(2, board)) {
            current
        } else if (wonRow == getDiagonalAsString(0, board)
            or wonRow == getDiagonalAsString(1, board)) {
                current
        } else {
            recCheckWinner(current - 1, board)
        }
    }