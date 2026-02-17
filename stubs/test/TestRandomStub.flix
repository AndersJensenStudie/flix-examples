mod TestRandomStub {
    use Assert.assertEq
    use Random.{randomBool, randomInt32, runWithIO}
    use RandomStub.{randomBoolStub, randomInt32Stub}

    @Test
    def randomBoolStub01(): Unit \ Assert + IO + NonDet = 
        let res = run {
            randomBool()
        } with randomBoolStub(true)
        with runWithIO;
        assertEq(expected = true, res)        
}