///
/// Handles the `FileWriteWithResult` effect of the given function `f` with the `FileWrite` effect.
///
/// In other words, re-interprets the `FileWriteWithResult` effect using the `FileWrite` effect.
///
pub def handleWithFileWrite(f: a -> Result[e, b] \ ef): (a -> b \ (ef - FileWriteWithResult) + FileWrite) = 
    y -> let res = run {
        f(y)
    } with handler FileWriteWithResult {
        def write(data, fi, k) = 
            k(Ok(FileWrite.write(data, fi)))
        def writeLines(data, fi, k) = 
            k(Ok(FileWrite.writeLines(data, fi)))
        def writeBytes(data, fi, k) = 
            k(Ok(FileWrite.writeBytes(data, fi)))
        def append(data, fi, k) = 
            k(Ok(FileWrite.append(data, fi)))
        def appendLines(data, fi, k) = 
            k(Ok(FileWrite.appendLines(data, fi)))
        def appendBytes(data, fi, k) = 
            k(Ok(FileWrite.appendBytes(data, fi)))
        def truncate(fi, k) = 
            k(Ok(FileWrite.truncate(fi)))
        def mkDir(d, k) = 
            k(Ok(FileWrite.mkDir(d)))
        def mkDirs(d, k) = 
            k(Ok(FileWrite.mkDirs(d)))
        def mkTempDir(prefix, k) = 
            k(Ok(FileWrite.mkTempDir(prefix)))
    };
    match res {
        case Ok(k) => k
        case Err(_t) => unreachable!() 
    }

///
/// Runs the `FileWriteWithResult` effect of the given function `f` with the `FileWrite` effect.
///
/// In other words, re-interprets the `FileWriteWithResult` effect using the `FileWrite` effect.
///
pub def runWithFileWrite(f: Unit -> Result[e, b] \ ef): b \ (ef - FileWriteWithResult) + FileWrite = 
    handleWithFileWrite(f)()