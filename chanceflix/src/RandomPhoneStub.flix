mod RandomPhoneStub {

    /// Handler that always returns the same fixed phone number.
    pub def runWithFixed(number: String, f: Unit -> a \ ef): a \ ef - RandomPhone =
        run {
            f()
        } with handler RandomPhone {
            def randomPhone(k) = k(number)
        }

    /// Handler that cycles through a list of phone numbers, wrapping around.
    pub def runWithList(numbers: List[String], f: Unit -> a \ ef): a \ ef - RandomPhone =
        region rc {
            let r = Ref.fresh(rc, numbers);
            run {
                f()
            } with handler RandomPhone {
                def randomPhone(k) =
                    let current = Ref.get(r);
                    match current {
                        case Nil =>
                            match numbers {
                                case Nil     => k("00000000")
                                case x :: rest =>
                                    Ref.put(rest, r);
                                    k(x)
                            }
                        case x :: rest =>
                            Ref.put(rest, r);
                            k(x)
                    }
            }
        }
}
