def click(): Unit \ Http = 
    let _ = Http.post("https://bertramsuttertaer.dk/inc", Map.empty(), "");
    ()

def ask(): Int32 \ Http = 
    let res = Http.get("https://bertramsuttertaer.dk/amount", Map.empty());
    let i = Http.Response.body(res);
    Option.getWithDefault(0, Int32.fromString(i))

def main(): Unit \ IO = 
    let _ = run {
        click();
        let s = ask();
        println(s)
    } with Http.runWithIO;
    ()