def test02(): Unit \ IO = 
    let m = RichString.text("Testing a simple string");
    let s = Severity.Fatal;
    let res = run {
        Logger.log(s, m)
    } with runWithFileWrite("log")
    with handler FileWrite {
        def write(data, f, k) = ???
        def writeLines(data, f, k) = ???
        def writeBytes(data, f, k) = ???
        def append(dat, f, k) = {
            println("Writing " + dat#str + " to " + f);
            k()
        }
        def appendLines(data, f, k) = ???
        def appendBytes(data, f, k) = ???
        def truncate(f, k) = ???
        def mkDir(d, k) = ???
        def mkDirs(d, k) = ???
        def mkTempDir(prefix, k) = ???
    };
    ()

def test03(): Unit \ IO = 
    let m = RichString.text("Testing a simple string");
    let s = Severity.Fatal;
    let res = run {
        Logger.log(s, m)
    } with runWithFileWrite("log.txt")
    with FileWrite.runWithIO;
    println(res)