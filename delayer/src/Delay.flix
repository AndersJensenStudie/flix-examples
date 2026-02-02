def delay(delay_t: Int32, f: Unit -> b \ ef): b \ {Clock} + ef = 
    let now = Clock.currentTime(TimeUnit.Seconds);
    let delay_64 = Int32.toInt64(delay_t);
    recDelay(f, delay_64, now)

def delayWithParams(f: a -> b \ ef, params: List[a], delay_t: Int32): List[b] \ {Clock} + ef = 
    let functions = List.map(a -> () -> f(a), params);
    List.map(elm -> delay(delay_t, elm), functions)

def recDelay(f: Unit -> b \ ef, delay_t: Int64, now: Int64): b \ {Clock} + ef = 
    let newTime = Clock.currentTime(TimeUnit.Seconds);
    if (newTime > now + delay_t) {
        f()
    } else {
        recDelay(f, delay_t, now)
    }

def wait(t: Int32): Unit \ Clock = 
    let now = Clock.currentTime(TimeUnit.Seconds);
    let t_64 = Int32.toInt64(t);
    recDelay(() -> (), t_64, now)

def transformingDelay(t: Int32, f: a -> b \ ef): a -> b \ ef + Clock = 
    let fkt = p -> {
        wait(t); 
        f(p)
    };
    fkt