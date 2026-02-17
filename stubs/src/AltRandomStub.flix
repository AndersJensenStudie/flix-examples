/// 
/// A library of test stub handlers to be used for testing code containing the `Random`-effect. 
///
mod AltRandomStub {
    use Random.{randomBool, randomFloat32, randomFloat64, randomInt32, randomInt64, randomGaussian}

    ///
    /// Fixes the result of the `randomBool`-operation 
    /// of the `Random`-effect to always be the provided `b`.
    /// Lets all the other operations in `Random` propagate.
    /// 
    pub def randomBoolStub(b: Bool, f: a -> b \ ef): a -> b \ ef - Random + Random =
        x -> run {
            f(x)
        } with handler Random {
            def randomBool(k) = k(b)
            def randomFloat32(k) = k(randomFloat32())
            def randomFloat64(k) = k(randomFloat64())
            def randomInt32(k) = k(randomInt32())
            def randomInt64(k) = k(randomInt64())
            def randomGaussian(k) = k(randomGaussian())
        }

    ///
    /// Fixes the result of the `randomFloat32`-operation 
    /// of the `Random`-effect to always be the provided `x`.
    /// Lets all the other operations in `Random` propagate.
    /// 
    pub def randomFloat32Stub(x: Float32, f: a -> b \ ef): a -> b \ ef + Random =
        y -> run {
            f(y)
        } with handler Random {
            def randomBool(k) = k(randomBool())
            def randomFloat32(k) = k(x)
            def randomFloat64(k) = k(randomFloat64())
            def randomInt32(k) = k(randomInt32())
            def randomInt64(k) = k(randomInt64())
            def randomGaussian(k) = k(randomGaussian())
        }

    ///
    /// Fixes the result of the `randomFloat64`-operation 
    /// of the `Random`-effect to always be the provided `x`.
    /// Lets all the other operations in `Random` propagate.
    /// 
    pub def randomFloat64Stub(x: Float64, f: a -> b \ ef): a -> b \ ef + Random =
        y -> run {
            f(y)
        } with handler Random {
            def randomBool(k) = k(randomBool())
            def randomFloat32(k) = k(randomFloat32())
            def randomFloat64(k) = k(x)
            def randomInt32(k) = k(randomInt32())
            def randomInt64(k) = k(randomInt64())
            def randomGaussian(k) = k(randomGaussian())
        }

    ///
    /// Fixes the result of the `randomInt32`-operation 
    /// of the `Random`-effect to always be the provided `i`.
    /// Lets all the other operations in `Random` propagate.
    /// 
    pub def randomInt32Stub(i: Int32, f: a -> b \ ef): a -> b \ ef + Random =
        y -> run {
            f(y)
        } with handler Random {
            def randomBool(k) = k(randomBool())
            def randomFloat32(k) = k(randomFloat32())
            def randomFloat64(k) = k(randomFloat64())
            def randomInt32(k) = k(i)
            def randomInt64(k) = k(randomInt64())
            def randomGaussian(k) = k(randomGaussian())
        }

    ///
    /// Fixes the result of the `randomInt64`-operation 
    /// of the `Random`-effect to always be the provided `i`.
    /// Lets all the other operations in `Random` propagate.
    /// 
    pub def randomInt64Stub(i: Int64, f: a -> b \ ef): a -> b \ ef + Random =
        y -> run {
            f(y)
        } with handler Random {
            def randomBool(k) = k(randomBool())
            def randomFloat32(k) = k(randomFloat32())
            def randomFloat64(k) = k(randomFloat64())
            def randomInt32(k) = k(randomInt32())
            def randomInt64(k) = k(i)
            def randomGaussian(k) = k(randomGaussian())
        }

    ///
    /// Fixes the result of the `randomGaussian`-operation 
    /// of the `Random`-effect to always be the provided `g`.
    /// Lets all the other operations in `Random` propagate.
    /// 
    pub def randomGaussianStub(g: Float64, f: a -> b \ ef): a -> b \ ef + Random =
            y -> run {
                f(y)
            } with handler Random {
                def randomBool(k) = k(randomBool())
                def randomFloat32(k) = k(randomFloat32())
                def randomFloat64(k) = k(randomFloat64())
                def randomInt32(k) = k(randomInt32())
                def randomInt64(k) = k(randomInt64())
                def randomGaussian(k) = k(g)
            }
}