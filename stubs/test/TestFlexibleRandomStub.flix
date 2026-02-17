mod TestFlexibleBoolStub {
    use Assert.assertEq
    use Random.{randomBool, randomInt32, runWithIO}
    use FlexibleRandomStub.{randomBoolStub, randomInt32Stub}

    /// Bool

    @Test
    def randomBoolStub01(): Unit \ Assert + IO + NonDet = 
        let res = run {
            List#{randomBool(), randomBool(), randomBool(), randomBool()}
        } with randomBoolStub(false, b -> not b)
        with runWithIO;
        assertEq(expected = res, List#{false, true, false, true})

    /// Int32

    @Test
    def randomInt32Stub01(): Unit \ Assert + IO + NonDet = 
        let res = run {
            List#{randomInt32(), randomInt32(), randomInt32()}
        } with randomInt32Stub(0, x -> x + 1)
        with runWithIO;
        assertEq(expected = List#{0, 1, 2}, res)

    @Test
    def randomInt32Stub02(): Unit \ Assert + IO + NonDet = 
        let res = run {
            List#{randomInt32(), randomInt32(), 
                randomInt32(), randomInt32()}
        } with randomInt32Stub(1, x -> x * 2)
        with runWithIO;
        assertEq(expected = List#{1, 2, 4, 8}, res)
}