import java.awt.Point;
import java.awt.MouseInfo;
import java.awt.PointerInfo;
import java.lang.Thread;

import javax.swing.JButton;
import javax.swing.JFrame;

class Main {
    public static void testMouse(String[] args) throws InterruptedException {
        while (true) {
            PointerInfo pointerInfo = MouseInfo.getPointerInfo();
            Point location = pointerInfo.getLocation();
            System.out.println(location.x + ", " + location.y);
            Thread.sleep(50);
        }
    }

    public static void testFrame(String[] args) {
    // Creating instance of JFrame
        JFrame frame = new JFrame();

        // Creating instance of JButton
        JButton button = new JButton("Click Me");

        button.setBounds(150, 200, 220, 50);

        frame.add(button);

        frame.setSize(500, 500);

        frame.setLayout(null);

        frame.setVisible(true);
    }

    public static void main(String[] args) throws InterruptedException {
        testFrame(args);
    }
}