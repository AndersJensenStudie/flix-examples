eff DivByZero {
    def divByZeroThrow(): Void
}

trait MyDiv[a] {
    type Aef: Eff

    pub def div(x: a, y: a): a \ MyDiv.Aef[a]
}

instance MyDiv[Int32] {
    type Aef = DivByZero

    pub def div(x: Int32, y: Int32): Int32 \ DivByZero = 
        if (y == 0) {
            DivByZero.divByZeroThrow()
        } else {
            x / y
        }
}

instance MyDiv[Float64] {
    type Aef = {}

    pub def div(x: Float64, y: Float64): Float64 \ {} = x / y

}

trait TypedLength[a] {
    pub def length(lst: List[a]): a 
}

instance TypedLength[Int32] {
    pub def length(lst: List[Int32]): Int32 = List.foldLeft(acc -> _ -> acc + 1, 0, lst)
}

instance TypedLength[Float64] {
    pub def length(lst: List[Float64]): Float64 = List.foldLeft(acc -> _ -> acc + 1.0, 0.0, lst)
}