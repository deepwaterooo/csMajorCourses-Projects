import java.io.*;
import java.math.*;
import java.util.*;

public class Main
{
    public static void main(String[] args) 
    {
        Scanner cin = new Scanner (new BufferedInputStream(System.in));
        int a; double b;
        a = 12345; 
        b = 1.234567;
        System.out.println(a + " " + b);
        // 输出b为字宽为10，右对齐，保留小数点后5位，四舍五入.
        System.out.printf("%d %10.5f\n", a, b); 
    }
}