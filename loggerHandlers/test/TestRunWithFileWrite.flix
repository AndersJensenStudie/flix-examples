@Test
def testJson01(): Unit \ IO = 
    run {
        Logger.fatal("Hello world")
    } with Logger_.runWithJSON(List#{})
    with Logger.runWithIO

@Test
def testJson02(): Unit \ IO + Time.Clock = 
    let timeLog = (() -> (RichString.text("${Time.Clock.currentTime(Time.TimeUnit.Seconds)}"), RichString.text("time")));
    run {
        Logger.fatal("Hello world")
    } with Logger_.runWithJSON(List#{timeLog})
    with Logger.runWithIO
    
@Test
def testJson03(): Unit \ IO + Time.Clock = 
    let timeLog = (() -> (RichString.text("${Time.Clock.currentTime(Time.TimeUnit.Seconds)}"), RichString.text("time")));
    let twolog = (() -> (RichString.text("${2}"), RichString.text("data")));
    let l = Logger_.fnCons(timeLog, List#{twolog});
    run {
        Logger.fatal("Hello world")
    } with Logger_.runWithJSON(l)
    with Logger.runWithIO

@Test
def testEmoji01(): Unit \ IO = 
    run {
        Logger.fatal("Oh no");
        Logger.debug("A bug!")
    } with Logger_.runWithEmoji
    with Logger.runWithIO

@Test
def testLoss01(): Unit \ IO = 
    run {
        Logger.fatal("Oh no")
    } with Logger_.runWithLoss