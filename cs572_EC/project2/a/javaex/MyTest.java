public class MyTest {
    public static void main(String[] args) {
        Singleton mysingleton = Singleton.GetInstence();
        System.out.println(mysingleton.a);
        System.out.println(mysingleton.b);
    }
}
