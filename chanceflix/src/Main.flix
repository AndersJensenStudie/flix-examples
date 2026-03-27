def main(): Unit \ IO + Math.Random =
    println("--- Using RandomPhone with US handler ---");
    run {
        println("Phone: " + RandomPhone.randomPhone());
        println("Phone: " + RandomPhone.randomPhone());
        println("Phone: " + RandomPhone.randomPhone())
    } with RandomPhone.runWithUs;
    println("");
    println("--- Using RandomPhone with DK handler ---");
    run {
        println("Phone: " + RandomPhone.randomPhone());
        println("Phone: " + RandomPhone.randomPhone());
        println("Phone: " + RandomPhone.randomPhone())
    } with RandomPhone.runWithDk
