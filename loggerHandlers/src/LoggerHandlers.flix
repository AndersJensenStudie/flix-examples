def handleWithFileWrite(filename: String, f: a -> b \ ef): a -> b \ (ef - Logger) + FileWrite = 
    z -> run {
        f(z)
    } with handler Logger {
        def log(s, m, k) = 
            let prefix = match s {
                case Severity.Trace => "[Trace]: "
                case Severity.Debug => "[Debug]: "
                case Severity.Info  => "[Info]: "
                case Severity.Warn  => "[Warn]: "
                case Severity.Fatal => "[Fatal]: "
            };
            let output = prefix + RichString.toString(m) + "\n";
            FileWrite.append({str = output}, filename);
            k()
    }

def runWithFileWrite(filename: String, f: Unit -> a \ ef): a \ (ef - Logger) + FileWrite =
    handleWithFileWrite(filename, f)()
