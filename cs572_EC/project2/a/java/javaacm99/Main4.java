import java.io.*;
import java.util.*;

public class Main
{
    public static void main(String[] args) 
    {
        int i;
        Scanner cin = new Scanner (new BufferedInputStream(System.in));
        String st = "abcdefg";
        System.out.println(st.charAt(0)); // st.charAt(i)���൱��st[i].
        char [] ch;
        ch = st.toCharArray(); // �ַ���ת��Ϊ�ַ�����.
        for (i = 0; i < ch.length; i++) ch[i] += 1;
        System.out.println(ch); // ����Ϊ��bcdefgh��.
        if (st.startsWith("a")) // ����ַ�����'0'��ͷ.
        {
            st = st.substring(1); // ��ӵ�1λ��ʼcopy(��ͷΪ��0λ).
        }
    }
}
