///
/// Handles the `FileWrite` effect of the given function `f`.
///
/// In other words, re-interprets the `FileWrite` effect using the `FileWriteWithResult` effect.
///
pub def handleWithFileWriteWithResult(f: a -> b \ ef): a -> Result[IoError, b] \ (ef - FileWrite) + FileWriteWithResult = 
    x -> run {
        Ok(f(x))
    } with handler FileWrite {
        def write(data, fi, k) = 
            handles(FileWriteWithResult.write(data), fi, k)
        def writeLines(data, fi, k) = 
            handles(FileWriteWithResult.writeLines(data), fi, k)
        def writeBytes(data, fi, k) = 
            handles(FileWriteWithResult.writeBytes(data), fi, k)
        def append(data, fi, k) = 
            handles(FileWriteWithResult.append(data), fi, k)
        def appendLines(data, fi, k) = 
            handles(FileWriteWithResult.appendLines(data), fi, k)
        def appendBytes(data, fi, k) = 
            handles(FileWriteWithResult.appendBytes(data), fi, k)
        def truncate(fi, k) = 
            handles(FileWriteWithResult.truncate, fi, k)
        def mkDir(d, k) = 
            handles(FileWriteWithResult.mkDir, d, k)
        def mkDirs(d, k) = 
            handles(FileWriteWithResult.mkDirs, d, k)
        def mkTempDir(prefix, k) = 
            let res = FileWriteWithResult.mkTempDir(prefix);
            match res {
                case Ok(ok) => k(ok)
                case Err(t) => Err(t)
            }
    }

def handles(f: a -> Result[IoError, Unit] \ ef, param: a, k: Unit -> Result[IoError, b] \ ef2): Result[IoError, b] \ ef + ef2 = 
    let res = f(param);
    match res {
        case Ok(ok) => k(ok) 
        case Err(t) => Err(t)
    }

///
/// Handles the `FileWrite` effect of the given function `f`.
///
/// In other words, re-interprets the `FileWrite` effect using the `FileWriteWithResult` effect.
///
pub def runWithFileWriteWithResult(f: Unit -> b \ ef): Result[IoError, b] \ (ef - FileWrite) + FileWriteWithResult = 
    handleWithFileWriteWithResult(f)()

