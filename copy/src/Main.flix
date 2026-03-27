def copyWithResult(): Unit \ IO + Sys.Exit = 
    run {
        let readResult = FileReadWithResult.read("copyme.txt");
        let text = match readResult {
            case Ok(text) => text
            case Err(e) => println(e); Sys.Exit.exit(1)
        };
        let writeResult = FileWriteWithResult.write(str = text, "imcopied.txt");
        match writeResult {
            case Ok() => println("Copied file sucessfully")
            case Err(e) => println(e); Sys.Exit.exit(1)
        }
    } with FileReadWithResult.runWithIO
    with FileWriteWithResult.runWithIO