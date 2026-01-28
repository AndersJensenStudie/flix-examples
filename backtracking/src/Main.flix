def main(): Unit \ IO = 
    let games = run {
        List#{game(10)}
    } with handler Choice {
        def choice(resume) = resume(true) ::: resume(false)
    };
    let filtered = List.filter(a -> fst(a), games);
    List.forEach(elm -> println(snd(elm)), filtered)

eff Choice {
    def choice(): Bool
}

def game(n: Int32): (Bool, String) \ Choice =
    if (n == 0) {
        (true, "")
    } else if (n < 0) {
        (false, "")
    } else {
        let (f, step) = if (Choice.choice()) {
            (x -> x - 2, "x - 2, ")
        } else {
            (x -> x / 3, "x / 3, ")
        };
        let (won, result) = game(f(n));
        (won, step + result)
    }