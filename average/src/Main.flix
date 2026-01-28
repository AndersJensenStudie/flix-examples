def average(lst: List[a]): a \ MyDiv.Aef[a] with MyDiv[a], MyAdd[a], TypedLength[a] = 
    MyDiv.div(MyAdd.sum(lst), TypedLength.length(lst)) 

def main(): Unit \ IO = 
    // int division
    run {
        let lst = List#{1, 2, 3};
        println(average(lst));

        let lst2: List[Int32] = Nil;
        println(average(lst2))
    } with handler DivByZero {
        def divByZeroThrow(_) = println("Division by zero not allowed")
    };
    let lst = List#{1.1, 2.2, 3.3};
    println(average(lst));

    let lst2: List[Float64] = Nil;
    println(average(lst2))