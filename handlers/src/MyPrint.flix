eff MyPrint {
    def print(s: String): Unit
}

mod MyPrint {
    @DefaultHandler
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - MyPrint) + IO =
        run {
            f()
        } with handler MyPrint {
            def print(s, resume) = {
                println(s);
                resume()
            }
        }

    pub def runWithReverse(f: Unit -> a \ ef): a \ (ef - MyPrint) + IO = 
        run {
            f()
        } with handler MyPrint {
            def print(s, k) = 
                let res = k();
                println(s);
                res
        }

    pub def runWithConsole(f: Unit -> a \ ef): a \ (ef - MyPrint) + Console =
        run {
            f()
        } with handler MyPrint {
            def print(s, resume) = {
                Console.println(s);
                resume()
            }
        }

    pub def collectPrints(f: Unit -> a \ ef): String \ ef + MyPrint = {
        run {
            let _ = f(); 
            ""
        } with handler MyPrint {
            def print(s, resume) = {
                MyPrint.print(s);
                let res = resume();
                s + res
            }
        }
    }

    pub def runWithIgnore(f: Unit -> a \ ef): a \ (ef - MyPrint) + IO = 
        run {
            f()
        } with handler MyPrint {
            def print(_, k) = 
                k()
    }
}

def nestedHandlers(): Unit \ IO = 
    let res = run {
        MyPrint.print("A");
        MyPrint.print("B");
        MyPrint.print("C")
    } with MyPrint.collectPrints
    with MyPrint.runWithIO;
    println(res)
