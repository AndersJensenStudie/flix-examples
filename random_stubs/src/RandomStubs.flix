mod RandomStubs {
    use RandomStubs.handleWithFunction
    use Math.Random

    pub def handleWithFixedValue(rf: Float64, ri: Int64, f: a -> b \ ef): a -> b \ (ef - Random) = 
        x -> run {
            f(x)
        } with handler Random {
            def randomFloat64(k) = k(rf)
            def randomInt64(k) = k(ri)
        }

    pub def runWithFixedValue(rf: Float64, ri: Int64, f: Unit -> a \ ef): a \ (ef - Random) = 
        handleWithFixedValue(rf, ri, f)()

    pub def handleWithFixedList(fls: List[Float64], ils: List[Int64], f: a -> b \ ef): a -> Option[b] \ (ef - Random) = 
        x -> region rc {
            let flsr = Ref.fresh(rc, fls);
            let ilsr = Ref.fresh(rc, ils);
            run {
                Some(f(x))
            } with handler Random {
                // maybe refactor to use function? A lot of code duplication
                def randomFloat64(k) = 
                    let li = Ref.get(flsr);
                    match li {
                        case Nil => 
                            match fls {
                                case fl :: fs => 
                                    Ref.put(fs, flsr);
                                    k(fl)
                                case Nil => None
                            }
                        case fl :: fs => 
                            Ref.put(fs, flsr);
                            k(fl)
                    }
                def randomInt64(k) = 
                    let li = Ref.get(ilsr);
                    match li {
                        case Nil => 
                            match ils {
                                case i :: is => 
                                    Ref.put(is, ilsr);
                                    k(i)
                                case Nil => None
                            }
                        case i :: is => 
                            Ref.put(is, ilsr);
                            k(i)
                    }
            }
        }

    pub def runWithFixedList(fls: List[Float64], ils: List[Int64], f: Unit -> a \ ef): Option[a] \ (ef - Random) = 
        handleWithFixedList(fls, ils, f)()

    pub def handleWithFunction(start: (Int64, Float64), step: ((Int64, Float64)) -> (Int64, Float64), f: a -> b \ ef): a -> b \ ef + Random =
        x -> region rc {
            let r = Ref.fresh(rc, start);
            run {
                f(x)
            } with handler Random {
                def randomInt64(k) = 
                    let i = Ref.get(r);
                    Ref.put(step(i), r);
                    k(fst(i))
                def randomFloat64(k) = 
                    let i = Ref.get(r);
                    Ref.put(step(i), r);
                    k(snd(i))
            }
        }

    pub def runWithFunction(start: (Int64, Float64), step: ((Int64, Float64)) -> (Int64, Float64), f: Unit -> a \ ef): a \ ef + Random =
        handleWithFunction(start, step, f)()
}