mod AltFlexibleRandomStub {
    use Random.{randomBool, randomFloat32, randomFloat64, randomInt32, randomInt64, randomGaussian}

    pub def randomBoolStub(b: Bool, step: Bool -> Bool, f: a -> b \ ef): a -> b \ ef + Random =
        y -> region rc {
            let r = Ref.fresh(rc, b);
            run {
                f(y)
            } with handler Random {
                def randomBool(k) = 
                    let b_ = Ref.get(r);
                    Ref.put(step(b_), r);
                    k(b_)
                def randomFloat32(k) = k(randomFloat32())
                def randomFloat64(k) = k(randomFloat64())
                def randomInt32(k) = k(randomInt32())
                def randomInt64(k) = k(randomInt64())
                def randomGaussian(k) = k(randomGaussian())
            }
        }

    pub def randomInt32Stub(i: Int32, step: Int32 -> Int32, f: a -> b \ ef): a -> b \ ef + Random =
        y -> region rc {
            let r = Ref.fresh(rc, i);
            run {
                f(y)
            } with handler Random {
                def randomBool(k) = k(randomBool())
                def randomFloat32(k) = k(randomFloat32())
                def randomFloat64(k) = k(randomFloat64())
                def randomInt32(k) = 
                    let i_ = Ref.get(r);
                    Ref.put(step(i_), r);
                    k(i_)
                def randomInt64(k) = k(randomInt64())
                def randomGaussian(k) = k(randomGaussian())
            }
        }
        
}