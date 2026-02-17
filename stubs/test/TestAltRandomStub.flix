mod TestRandomStub {
    use Assert.assertEq
    use Random.{randomBool, randomInt32, randomInt64, randomFloat32, randomFloat64, runWithIO}
    use AltRandomStub.{randomBoolStub, randomInt32Stub, randomInt64Stub, randomFloat64Stub}
    use AltFlexibleRandomStub.{randomBoolStub => flexRandomBoolStub, randomInt32Stub => flexRandomInt32Stub}

    def compositeHandler(h: (Unit -> a \ ef1) -> (Unit -> a \ ef2), f: Unit -> a \ ef1): a \ ef2 = 
        h(f)()

    // for terminating
    pub def |>>(t1: (Unit -> a \ ef1) -> (Unit -> a \ ef2), 
                    t2: (Unit -> a \ ef2) -> (Unit -> a \ ef3)): (Unit -> a \ ef1) -> a \ ef3 =
        let h = t1 >> t2 |> compositeHandler;
        h

    @Test
    def altRandom(): Unit \ {Assert + NonDet + IO} = 
        let h = randomBoolStub(true) 
            >> randomInt32Stub(42) 
            |> compositeHandler;
        let (b, i) = run {
            (randomBool(), randomInt32())
        } with h
        with runWithIO;
        assertEq(expected = true, b);
        assertEq(expected = 42, i)

    @Test
    def altRandom01(): Unit \ {Assert + NonDet + IO} = 
        let h = compositeHandler(randomBoolStub(true) >> randomInt32Stub(42));
        let (b, i) = run {
            (randomBool(), randomInt32())
        } with h
        with runWithIO;
        assertEq(expected = true, b);
        assertEq(expected = 42, i)

    @Test
    def altRandom02(): Unit \ {Assert + NonDet + IO} = 
        let h = randomBoolStub(true) 
            >> randomInt32Stub(42)
            >> randomInt64Stub(42i64)
            |>> randomFloat64Stub(42.0); 
        let (b, i, i64, f) = run {
            (randomBool(), randomInt32(), randomInt64(), randomFloat64())
        } with h
        with runWithIO;
        assertEq(expected = true, b);
        assertEq(expected = 42, i);
        assertEq(expected = 42i64, i64);
        assertEq(expected = 42.0, f)


    @Test
    def altFlexRandom(): Unit \ {Assert + NonDet + IO} = 
        let h = flexRandomBoolStub(false, b -> not b)
            >> flexRandomInt32Stub(1, x -> x + 2) 
            |> compositeHandler;
        let (bs, is) = run {
            (
                (List#{randomBool(), randomBool(), randomBool(), randomBool()},
                List#{randomInt32(), randomInt32(), randomInt32(), randomInt32()})
            )
        } with h
        with runWithIO;
        assertEq(expected = List#{false, true, false, true}, bs);
        assertEq(expected = List#{1, 3, 5, 7}, is)
}