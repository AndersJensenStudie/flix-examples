// import java.awt.LayoutManager
// import javax.swing.JFrame;
// import javax.swing.JButton;
// import java.awt.BorderLayout;
// import java.lang.Object;

// def √(x: Int32): Int32 = 
//     let x_prime = Int32.toFloat64(x);
//     let sq = Float64.pow({base = x_prime}, 0.5);
//     sq |> Float64.round |> Float64.tryToInt32 |> Option.getWithDefault(0)

// def main(): Unit \ IO = 
//     let frame = new JFrame();
//     let button = new JButton("Clickme");
//     button.setBounds(150, 200, 220, 50);
//     frame.add(button);
//     let manager: BorderLayout = checked_cast(null);
//     frame.setLayout(manager);
//     frame.setSize(500, 500);
//     frame.setVisible(true)
import java.lang.{Object, CharSequence, Object, String => JString, Integer => JInt}
import java.io.Serializable
def main(): Unit = 
    let _: JInt = unchecked_cast("Hello World" as JInt);
    ()
