mod ServerUtils {
    pub def runWithLogger(f: Unit -> Unit \ ef): Unit \ (ef - Abort) + Logger =
        run {
            f()
        } with handler Abort {
            def abort(m, _k) = 
                Logger.fatal(m)
        }
}