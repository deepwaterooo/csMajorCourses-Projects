import java.io.*;
import java.util.*;

public class Main
{
    public static void main(String[] args) 
    {
        int i;
        Scanner cin = new Scanner (new BufferedInputStream(System.in));
        String st = "abcdefg";
        System.out.println(st.charAt(0)); // st.charAt(i)就相当于st[i].
        char [] ch;
        ch = st.toCharArray(); // 字符串转换为字符数组.
        for (i = 0; i < ch.length; i++) ch[i] += 1;
        System.out.println(ch); // 输入为“bcdefgh”.
        if (st.startsWith("a")) // 如果字符串以'0'开头.
        {
            st = st.substring(1); // 则从第1位开始copy(开头为第0位).
        }
    }
}
