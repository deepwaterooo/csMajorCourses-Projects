import java.util.Scanner;
import java.io.BufferedInputStream;
import java.math.BigInteger;
public class Main
{
    public static void main(String[] args) 
    {
        Scanner cin = new Scanner (new BufferedInputStream(System.in));
        int a;
        double b;
        BigInteger c; 
        String st;
        a = cin.nextInt();
        b = cin.nextDouble();
        c = cin.nextBigInteger();
        st = cin.nextLine(); // 每种类型都有相应的输入函数.
    }
}
