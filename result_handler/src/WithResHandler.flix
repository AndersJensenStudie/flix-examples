def fileReadWithResultHandled(): Unit \ IO = 
    let res = run {
        FileReadWithResult.exists("README.md")
    } with runWithFileRead
    with FileRead.runWithIO;
    println(res)

def fileReadWithResult(): Unit \ IO = 
    let res = run {
        FileReadWithResult.exists("README.md")
    } with FileReadWithResult.runWithIO;
    println(res)

def runWithFileRead(g: Unit -> b \ ef): b \ (ef - FileReadWithResult) + FileRead = 
    run {
        g()
    } with handler FileReadWithResult {
        def exists(f, k) = {
            let res = FileRead.exists(f);
            k(Ok(res))
        }
        def isDirectory(f, k) = {
            let res = FileRead.isDirectory(f);
            k(Ok(res))
        }
        def isRegularFile(f, k) = {
            let res = FileRead.isReadable(f);
            k(Ok(res))
        }
        def isReadable(f, k) = {
            let res = FileRead.isReadable(f);
            k(Ok(res))
        }
        def isSymbolicLink(f, k) = {
            let res = FileRead.isReadable(f);
            k(Ok(res))
        }
        def isWritable(f, k) = {
            let res = FileRead.isWritable(f);
            k(Ok(res))
        }
        def isExecutable(f, k) = {
            let res = FileRead.isExecutable(f);
            k(Ok(res))
        }
        def accessTime(f, k) = {
            let res = FileRead.accessTime(f);
            k(Ok(res))
        }
        def creationTime(f, k) = {
            let res = FileRead.creationTime(f);
            k(Ok(res))
        }
        def modificationTime(f, k) = {
            let res = FileRead.modificationTime(f);
            k(Ok(res))
        }
        def size(f, k) = {
            let res = FileRead.size(f);
            k(Ok(res))
        }
        def read(f, k) = {
            let res = FileRead.read(f);
            k(Ok(res))
        }
        def readLines(f, k) = {
            let res = FileRead.readLines(f);
            k(Ok(res))
        }
        def readBytes(f, k) = {
            let res = FileRead.readBytes(f);
            k(Ok(res))
        }
        def list(f, k) = {
            let res = FileRead.list(f);
            k(Ok(res))
        }
    }