
// def useGetWith(x: Int32, f: Option[Int32 -> Int32 \ ef]): Int32 \ ef = 
//     Option.getWithDefault(y -> y, f)(x)

// def useMatch(x: Int32, f: Option[Int32 -> Int32 \ ef]): Int32 \ ef = 
//     def id(t: Int32): Int32 \ ef = 
//         ???;
    
//     let f_ = match f {
//         case Some(g) => g
//         case None => id
//     };
//     f_(x)

// def getWithDefault(d: a, o: Option[a \ ef]): a = match o {
//         case None    => d
//         case Some(v) => v
//     }

// def applyFunctions(x: Int32, fl: List[Int32 -> Int32 \ ef]): Int32 = 
//     match fl {
//         case Cons(f, xs) => applyFunctions(f(x), xs)
//         case Nil => x 
//     }