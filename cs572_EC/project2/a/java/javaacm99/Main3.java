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
        // ���bΪ�ֿ�Ϊ10���Ҷ��룬����С�����5λ����������.
        System.out.printf("%d %10.5f\n", a, b); 
    }
}