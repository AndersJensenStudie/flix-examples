mod BetterRandom {

    /// Returns a uniformly random Bool.
    pub def randomBool(): Bool \ Math.Random =
        Math.Random.randomFloat64() < 0.5

    /// Returns a uniformly random Int32.
    pub def randomInt32(): Int32 \ Math.Random =
        let r = Math.Random.randomInt64();
        match Int64.tryToInt32(Int64.bitwiseAnd(r, Int32.toInt64(Int32.maxValue()))) {
            case Some(i) => i
            case None    => 0
        }

    /// Returns a uniformly random Int32 in [min, max] (inclusive).
    pub def randomInt32Between(min: Int32, max: Int32): Int32 \ Math.Random =
        let range = Int32.toFloat64(max - min + 1);
        let r = Math.Random.randomFloat64();
        min + (Float64.tryToInt32(r * range) |> Option.getWithDefault(min))

    /// Returns a uniformly random Int64.
    pub def randomInt64(): Int64 \ Math.Random =
        Math.Random.randomInt64()

    /// Returns a uniformly random Int64 in [min, max] (inclusive).
    pub def randomInt64Between(min: Int64, max: Int64): Int64 \ Math.Random =
        let range = Int64.toFloat64(max - min + 1i64);
        let r = Math.Random.randomFloat64();
        min + (Float64.tryToInt64(r * range) |> Option.getWithDefault(min))

    /// Returns a uniformly random Float64 in [0.0, 1.0).
    pub def randomFloat64(): Float64 \ Math.Random =
        Math.Random.randomFloat64()

    /// Returns a uniformly random Float64 in [min, max).
    pub def randomFloat64Between(min: Float64, max: Float64): Float64 \ Math.Random =
        min + Math.Random.randomFloat64() * (max - min)

    /// Returns a uniformly random Float32 in [0.0f32, 1.0f32).
    pub def randomFloat32(): Float32 \ Math.Random =
        Float64.tryToFloat32(Math.Random.randomFloat64()) |> Option.getWithDefault(0.0f32)

    /// Returns a uniformly random Float32 in [min, max).
    pub def randomFloat32Between(min: Float32, max: Float32): Float32 \ Math.Random =
        let r = randomFloat32();
        min + r * (max - min)

    /// Returns a uniformly random Char in [min, max] (inclusive).
    pub def randomCharBetween(min: Char, max: Char): Char \ Math.Random =
        let lo = Char.toBmpCodePoint(min);
        let hi = Char.toBmpCodePoint(max);
        let cp = randomInt32Between(lo, hi);
        CodePoint.toBmpChar(cp) |> Option.getWithDefault(min)

    /// Returns a uniformly random lowercase letter a-z.
    pub def randomLowerCase(): Char \ Math.Random =
        randomCharBetween('a', 'z')

    /// Returns a uniformly random uppercase letter A-Z.
    pub def randomUpperCase(): Char \ Math.Random =
        randomCharBetween('A', 'Z')

    /// Returns a uniformly random digit character '0'-'9'.
    pub def randomDigitChar(): Char \ Math.Random =
        randomCharBetween('0', '9')
}
