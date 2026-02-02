eff Increment {
    def inc(x: Int32): Int32
}

def incs(x: Int32): Int32 \ Increment = 
    Increment.inc(x)

def helloing(x: Int32): Unit \ IO = 
    let str = "Hello, " + Int32.toString(x) + "!";
    println(str)
    
def main(): Unit \ {IO, Clock} = 
    let out = delayWithParams(helloing, List#{1, 2, 3}, 5);
    //let out = delay(() -> inc(1), 10);
    println(out)

def asHandler(): Unit \ {IO, Clock} = 
    let res = run {
        incs(10)
    } with delay(3)
    with handler Increment {
        def inc(x, k) = k(x + 1)
    };
    println(res)

def incHandler(f: Unit -> Int32 \ ef): Int32 \ ef - Increment = 
    run {
        f()
    } with handler Increment {
        def inc(x, k) = k(x + 1)
    }

def byChangingHandler(): Unit \ IO = 
    let res = run {
        incs(100)
    } with transformingDelay(2, incHandler)
    with Clock.runWithIO;
    println(res)
