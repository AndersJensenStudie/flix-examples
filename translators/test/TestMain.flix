def fileWriteWithResultStub(g: Unit -> b \ ef): Result[IoError, b] \ (ef - FileWriteWithResult) = 
    run {
        Ok(g())
    } with handler FileWriteWithResult {
        def write(_, _, k) = 
            k(Ok())
        def writeLines(data, f, k) = 
            k(Ok())
        def writeBytes(data, f, k) = 
            k(Ok())
        def append(data, f, k) = 
            k(Ok())
        def appendLines(data, f, k) = ???
        def appendBytes(data, f, k) = ???
        def truncate(f, k) = ???
        def mkDir(d, k) = ???
        def mkDirs(d, k) = ???
        def mkTempDir(prefix, k) = ???
    }

@Test
def runWithFileWriteWithResult01(): Unit \ Assert = 
    ???
