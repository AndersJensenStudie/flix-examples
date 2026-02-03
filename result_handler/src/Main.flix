def fileReadHandled(): Unit \ IO = 
    let res = run {
        FileRead.exists("README.md")
    } with runWithReadWithResult 
    with FileReadWithResult.runWithIO;
    println(res)

def fileReadUnhandled(): Unit \ IO = 
    let res = run {
        FileRead.exists("README.md")
    } with FileRead.runWithIO;
    println(res)

def runWithReadWithResult(g: Unit -> b \ ef): Result[IoError, b] \ (ef - FileRead) + FileReadWithResult = 
    run {
        Ok(g())
    } with handler FileRead {
        def exists(f, k) = {
            let res = FileReadWithResult.exists(f);
            match res {
                case Ok(b) => k(b)
                // In FileReadWithResult we have already handled a potential error. We cannot now "unhandle" it
                case Err(e) => Err(e)
            }
        }
        def isDirectory(f, k) = {
            let res = FileReadWithResult.isDirectory(f);
            match res {
                case Ok(b) => k(b)
                case Err(e) => Err(e)
            }
        }
        def isRegularFile(f, k) = {
            let res = FileReadWithResult.isRegularFile(f);
            match res {
                case Ok(b) => k(b)
                case Err(e) => Err(e)
            }
        }
        def isReadable(f, k) = {
            let res = FileReadWithResult.isReadable(f);
            match res {
                case Ok(b) => k(b)
                case Err(e) => Err(e)
            }
        }
        def isSymbolicLink(f, k) = {
            let res = FileReadWithResult.isSymbolicLink(f);
            match res {
                case Ok(b) => k(b)
                case Err(e) => Err(e)
            }
        }
        def isWritable(f, k) = {
            let res = FileReadWithResult.isWritable(f);
            match res {
                case Ok(b) => k(b)
                case Err(e) => Err(e)
            }
        }
        def isExecutable(f, k) = {
            let res = FileReadWithResult.isExecutable(f);
            match res {
                case Ok(b) => k(b)
                case Err(e) => Err(e)
            }
        }
        def accessTime(f, k) = {
            let res = FileReadWithResult.accessTime(f);
            match res {
                case Ok(b) => k(b)
                case Err(e) => Err(e)
            }
        }
        def creationTime(f, k) = {
            let res = FileReadWithResult.creationTime(f);
            match res {
                case Ok(b) => k(b)
                case Err(e) => Err(e)
            }
        }
        def modificationTime(f, k) = {
            let res = FileReadWithResult.modificationTime(f);
            match res {
                case Ok(b) => k(b)
                case Err(e) => Err(e)
            }
        }
        def size(f, k) = {
            let res = FileReadWithResult.size(f);
            match res {
                case Ok(b) => k(b)
                case Err(e) => Err(e)
            }
        }
        def read(f, k) = {
            let res = FileReadWithResult.read(f);
            match res {
                case Ok(b) => k(b)
                case Err(e) => Err(e)
            }
        }
        def readLines(f, k) = {
            let res = FileReadWithResult.readLines(f);
            match res {
                case Ok(b) => k(b)
                case Err(e) => Err(e)
            }
        }
        def readBytes(f, k) = {
            let res = FileReadWithResult.readBytes(f);
            match res {
                case Ok(b) => k(b)
                case Err(e) => Err(e)
            }
        }
        def list(f, k) = {
            let res = FileReadWithResult.list(f);
            match res {
                case Ok(b) => k(b)
                case Err(e) => Err(e)
            }
        }
    }

