def main(): Unit \ IO = 
    let l = List#{1, 2, 3, 4, 5};
    let f = (acc: Int32, x: Int32) -> acc + x;
    let result = Foldable_.foldLeft(f, 0, l);
    println(result)

trait Foldable_ [t : Type ] {
	type Aef : Eff // An associated effect synonym
	type Elm : Type // An associated type synonym
	
	pub def foldLeft (f: (b , Foldable_.Elm[t] ) -> b \ ef , s: b , t: t ): b \ Foldable_.Aef[t] + ef
}

instance Foldable_ [ List [ a ]] {
	type Aef = {} // Pure
	type Elm = a
	
    pub def foldLeft (f: (b , a) -> b \ ef , s: b , t: List [a ]): b \ ef = {
        match t {
            case Nil => s
            case Cons (hd , tl) => 
                let s1 = f (s , hd);
                Foldable_.foldLeft(f , s1 , tl)
        }
    }
}


instance Foldable_[MutList[a, r]] {
    type Aef = r
    type Elm = a

    pub def foldLeft(f: (b, a) -> b \ ef, s: b , t: MutList [a, r]): b \ r + ef = {
        foreach (t_elm <- t) {
            s = f(s, t_elm)
        };
        s
    }

}


