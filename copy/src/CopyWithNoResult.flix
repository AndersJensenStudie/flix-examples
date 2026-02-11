def copyWithNoResult(): Unit \ IO + Exit = 
    // reads
    let result = run {
        let text = FileRead.read("copyme.txt");
        text
    } with FileRead.handle;
    let text = match result() {
        case Ok(text) => text
        case Err(e) => println(e); Exit.exit(1)
    };
    // write
    let writeResult = run {
        FileWrite.append(str = text, "cope.txt")
    } with FileWrite.handle;
    match writeResult() {
        case Ok() => ()
        case Err(e) => println(e)
    }
