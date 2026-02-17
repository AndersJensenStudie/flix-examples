mod RandomHandlerBuilder {
    type alias B = {b = Option[Bool], i32 = Option[Int32]}

    pub def createBuilder(): B = 
        {
            b = None,
            i32 = None
        }

    pub def setInt32(i: Int32, builder: B): B = 
        {
            b = builder#b,
            i32 = Some(i)
        }

    pub def setBool(b: Bool, builder: B): B = 
        {
            b = Some(b),
            i32 = builder#i32
        }


    pub def ||>(b: B, g: B -> B): ((Unit -> a \ ef) -> a \ ef + Random) = 
        b |> g |> runWithStub

    pub def handleWithStub(builder: B, f: a -> b \ ef): a -> b \ ef + Random = 
        x -> run {
            f(x)
        } with handler Random {
            def randomBool(k) = 
                match builder#b {
                    case Some(b) => k(b)
                    case None => k(false) // how should a call to a method not handled be treated??
                }
            def randomInt32(k) = 
                match builder#i32 {
                    case Some(i) => k(i)
                    case None => k(0) // same here
                }
            def randomFloat32(k) = ???
            def randomFloat64(k) = ???
            def randomInt64(k) = ???
            def randomGaussian(k) = ???
        }

    pub def runWithStub(builder: B, f: Unit -> a \ ef): a \ ef + Random = 
        handleWithStub(builder, f)() 

    pub def createHandler(builder: B): (Unit -> a \ ef) -> a \ ef + Random = 
        runWithStub(builder)
}