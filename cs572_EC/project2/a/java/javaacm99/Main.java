import java.io.*;
import java.util.*;


public class Main
{
    public static void main(String[] args) 
    {
        Scanner cin = new Scanner (new BufferedInputStream(System.in));
        int n = cin.nextInt();
        int a[] = new int [n];
        for (int i = 0; i < n; i++) 
           a[i] = cin.nextInt();
        Arrays.sort(a);
        for (int i = 0; i < n; i++) 
          System.out.print(a[i] + " ");
    }
}
