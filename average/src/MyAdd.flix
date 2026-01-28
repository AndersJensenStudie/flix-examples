trait MyAdd[a] {
    pub def add(x: a, y: a): a
    pub def sum(lst: List[a]): a
}

instance MyAdd[Int32] {
    pub def add(x: Int32, y: Int32): Int32 = x + y
    pub def sum(lst: List[Int32]): Int32 = List.foldLeft(acc -> x -> acc + x, 0, lst)
}

instance MyAdd[Float64] {
    pub def add(x: Float64, y: Float64): Float64 = x + y
    pub def sum(lst: List[Float64]): Float64 = List.foldLeft(acc -> x -> acc + x, 0.0, lst)
}