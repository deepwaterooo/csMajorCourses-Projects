import java.io.*;
import java.math.*;
import java.util.*;


public class Main
{
    public static void main(String[] args) 
    {
        Scanner cin = new Scanner (new BufferedInputStream(System.in));
        int a = 123, b = 456, c = 7890;
        BigInteger x, y, z, ans;
        x = BigInteger.valueOf(a); 
        y = BigInteger.valueOf(b);
        z = BigInteger.valueOf(c);
        ans = x.add(y); 
        System.out.println(ans);
        ans = z.divide(y);
        System.out.println(ans);
        ans = x.mod(z);
        System.out.println(ans);
        if (ans.compareTo(x) == 0) 
          System.out.println("1");
    }
}
