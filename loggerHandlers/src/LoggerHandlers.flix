mod Logger_ {
    use Logger_.handleWithJSON
    use RichString.text
    use Severity.Fatal
    use Severity.{Warn, Info, Debug, Trace, Fatal}
    use RichString.{yellow, red}

    /// 
    /// Handles the `Logger` effect of the given function `f` with the `FileWrite` effect.
    /// 
    /// Appends the logged message to the file obtained by running `file` with the 
    /// severity of the `log`.
    ///
    // pub def handleWithWriteByLevel(file: Severity -> String, f: a -> b \ ef): a -> b \ (ef - Logger) + FileWrite = 
    //     x -> run {
    //         f(x)
    //     } with handler Logger {
    //         def log(s, m, k) = 
    //             let filename = file(s);
    //             let output = "[${ToString.toString(s)}] ${RichString.toString(m)}\n";
    //             FileWrite.append({str = output}, filename);
    //             k()
    //     }
    // /// 
    // /// Runs the `Logger` effect of the given function `f` with the `FileWrite` effect.
    // /// 
    // /// Appends the logged message to the file obtained by running `file` with the 
    // /// severity of the `log`.
    // ///
    // pub def runWithWriteByLevel(file: Severity -> String, f: Unit -> a \ ef): a \ (ef - Logger) + FileWrite = 
    //     handleWithWriteByLevel(file, f)()

    /// 
    /// Handles the `Logger` effect of the given function `f`. Uses the `Abort` effect to
    /// abort if anything is logged with `Fatal` severity. Otherwise, it lets the effect propagate.
    /// 
    pub def handleWithAbortOnFatal(f: a -> b \ ef): a -> b \ ef + Abort + Logger = 
        x -> run {
            f(x)
        } with handler Logger {
            def log(s, m, k) = match s {
                case Severity.Warn => Logger.warn(m); k()
                case Severity.Fatal => Abort.abort(red(m))
                case Severity.Trace => Logger.trace(m); k()
                case Severity.Debug => Logger.debug(m); k()
                case Severity.Info => Logger.info(m); k()
            }
        }

    ///
    /// Runs the `Logger` effect of the given function `f`. Uses the `Abort` effect to
    /// abort if anything is logged with `Fatal` severity. Otherwise, it lets the effect propagate.
    /// 
    pub def runWithAbortOnFatal(f: Unit -> a \ ef): a \ ef + Abort + Logger = 
        handleWithAbortOnFatal(f)()

    /// 
    /// Handles the `Logger` effect of the given function `f`. Uses the `Abort` effect to
    /// abort if anything is logged with `Warn` severity. Otherwise, it lets the effect propagate.
    /// 
    pub def handleWithAbortOnWarn(f: a -> b \ ef): a -> b \ ef + Abort + Logger = 
        x -> run {
            f(x)
        } with handler Logger {
            def log(s, m, k) = match s {
                case Warn => Abort.abort(yellow(m))
                case Fatal => Logger.fatal(m); k()
                case Trace => Logger.trace(m); k()
                case Debug => Logger.debug(m); k()
                case Info => Logger.info(m); k()
            }
        }

    ///
    /// Runs the `Logger` effect of the given function `f`. Uses the `Abort` effect to
    /// abort if anything is logged with `Warn` severity. Otherwise, it lets the effect propagate.
    /// 
    pub def runWithAbortOnWarn(f: Unit -> a \ ef): a \ ef + Abort + Logger = 
        handleWithAbortOnWarn(f)()

    pub def handleWithAbort(g: (Severity, RichString) -> Bool \ ef1, f: a -> b \ ef2): a -> b \ ef1 + ef2 + Abort + Logger = 
        x -> run {
            f(x)
        } with handler Logger {
            def log(s, m, k) =
                if (g(s, m)) {
                    Abort.abort(m)
                } else {
                    Logger.log(s, m); k()
                }
            }

    pub def runWithAbort(g: (Severity, RichString) -> Bool \ ef1, f: Unit -> a \ ef2): a \ ef1 + ef2 + Abort + Logger = 
        handleWithAbort(g, f)() 


    // pub def handleWithPrependTime(f: a -> b \ ef): a -> b \ ef + Logger + Clock = 
    //     x -> run {
    //         f(x)
    //     } with handler Logger {
    //         def log(s, m, k) = 
    //             let t = Int64.toString(Clock.currentTime(TimeUnit.Seconds));
    //             let n = text(t);
    //             Logger.log(s, n + m);
    //             k()
    //     }

    
    ///
    /// Handles the `Logger` effect of the given function `f`. Appends the logged to `file`.
    ///
    /// In other words, re-interprets the `Logger` effect using the `FileWriteWithResult` effect.
    /// If an `IoError` is encountered while writing to file, executes the optional `onError` function.
    /// Discards style from the logged messages. 
    ///
    pub def handleWithFileWriteWithResult(file: String, onError: Option[IoError -> Unit \ ef2], f: a -> b \ ef1): a -> b \ (ef1 - Logger) + ef2 + Fs.FileWrite = 
        x -> run {
            f(x)
        } with handler Logger {
            def log(s, m, k) = {
                let output = "[${ToString.toString(s)}] ${RichString.toString(m)}\n"; // #### Reverse to toPlainString!!
                let res = Fs.FileWrite.append({str = output}, file);
                match res {
                    case Ok() => ()
                    case Err(e) => match onError {
                        case Some(g) => g(e)
                        case None => ()
                    }
                };
                k()
            }
        }

    ///
    /// Handles the `Logger` effect of the given function `f`. Appends the logged to `file`.
    ///
    /// In other words, re-interprets the `Logger` effect using the `FileWriteWithResult` effect.
    /// If an `IoError` is encountered while writing to file, executes the optional `onError` function.
    /// Discards style from the logged messages. 
    ///
    pub def runWithFileWrite(file: String, onError: Option[IoError -> Unit \ ef2], f: Unit -> a \ ef): a \ (ef - Logger) + ef2 + Fs.FileWrite =
        handleWithFileWriteWithResult(file, onError, f)()


    pub def fnCons(f: Unit -> (RichString, RichString) \ ef1, fns: List[Unit -> (RichString, RichString) \ ef2]): List[Unit -> (RichString, RichString) \ ef1 + ef2] = 
        let wf = _ -> checked_ecast(f());
        let wl = List.map(g -> ((_ -> checked_ecast(g())): Unit -> (RichString, RichString) \ (ef1 + ef2)), fns);
        Cons(wf, wl)

    pub def handleWithJSON(fields: List[Unit -> (RichString, RichString) \ ef2], f: a -> b \ ef): a -> b \ ef + ef2 + Logger = 
        x -> run {
            f(x)
        } with handler Logger {
            def log(s, m, k) = 
                let n = List.foldLeft(acc -> g -> 
                    let res = g();
                    let (label, value) = res;
                    let r = RichString.text("${label}: ${value},\n");
                    acc + r
                , RichString.empty(), fields);
                let m_ = RichString.text("{\nmessage: \"${m}\",\nseverity: ${s},\n${n}}");
                k(Logger.log(s, m_))
        }

    pub def runWithJSON(fields: List[Unit -> (RichString, RichString) \ ef2], f: Unit -> a \ ef): a \ ef + ef2 + Logger = 
        handleWithJSON(fields, f)()

    pub def handleWithEmoji(f: a -> b \ ef): a -> b \ ef + Logger = 
        x -> run {
            f(x)
        } with handler Logger {
            def log(s, m, k) = 
                let e = match s {
                    case Severity.Fatal => "🔥"
                    case Severity.Warn => "⚠️"
                    case Severity.Trace => "🫆"
                    case Severity.Debug => "🐛"
                    case Severity.Info => "ℹ️"
                } + " ";
                let m_ = RichString.text(e) + m;
                k(Logger.log(s, m_))
        }

    pub def runWithEmoji(f: Unit -> a \ ef): a \ ef + Logger = 
        handleWithEmoji(f)()


    pub def handleWithLoss(f: a -> b \ ef): a -> b \ ef + IO - Logger = 
        x -> run {
            f(x)
        } with handler Logger {
            def log(_, _, k) = 
                let _ = println(":̶.̶|̶:̶;̶");
                k()
        }

    pub def runWithLoss(f: Unit -> a \ ef): a \ ef + IO - Logger = 
        handleWithLoss(f)()
}
