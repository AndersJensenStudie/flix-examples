public class Main {
    public static void main(String[] args) {
        int a = 0;
        try {
            a = 10;
        } finally {
            System.out.println("The final value of a is: " + a);
        }
    }

    public static int add(int a, int b) {
        return a + b;
    }
}