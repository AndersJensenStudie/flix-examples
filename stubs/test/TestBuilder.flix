mod TestBuilder {
    use Assert.assertEq
    use RandomHandlerBuilder.{
        createBuilder, setBool, 
        setInt32, handleWithStub, 
        runWithStub, ||>,
        createHandler}
    use Random.{randomInt32, randomBool}

    @Test
    def builder01(): Unit \ Assert + IO + NonDet = 
        let h = createBuilder() 
            |> setBool(true) 
            ||> setInt32(16);
        let (i, b) = run {
            (randomInt32(), randomBool())
        } with h 
        with Random.runWithIO;
        assertEq(expected = true, b);
        assertEq(expected = 16, i)

    @Test
    def builder02(): Unit \ Assert + IO + NonDet = 
        let h = createBuilder() 
            |> setBool(true) 
            |> setInt32(16);
        let randStub = createHandler(h);
        let (i, b) = run {
            (randomInt32(), randomBool())
        } with randStub
        with Random.runWithIO;
        assertEq(expected = true, b);
        assertEq(expected = 16, i)
}