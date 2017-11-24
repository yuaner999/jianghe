import org.junit.Test;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by liuzg on 2016/2/21.
 */
public class TestJxPath {
    @Test
    public void testJxPath(){

        //Change("Influence Maximization Aims to identify k nodes from a Network");
        myuppercase("influence Maximization Aims;to identify.k nodes from a Network.");

        int[] array = {9012,5099,6012,7025,8088,1000,9999};
        //SortArray(array);
        //calc(array);
    }

    public String Change(String string){
        String result = "";
        String[] list = string.split(" ");
        for (String str : list) {
            result += str.replace(str.substring(0,1),str.substring(0,1).toLowerCase()) + " ";
        }
        System.out.println(result.substring(0,result.length()-1));
        return result.substring(0,result.length()-1);
    }

    public void SortArray(int[] array){

        for (int i = 0; i < array.length; i++)
        {
            for (int j = i; j < array.length; j++)
            {
                int f = array[i]%1000;
                int s = array[j]%1000;
                if(f<s){
                    int temp = array[i];
                    array[i] = array[j];
                    array[j] = temp;
                }else if(f==s){
                    if(array[i]>array[j]){
                        int temp = array[i];
                        array[i] = array[j];
                        array[j] = temp;
                    }
                }
            }
        }
        for (int i :
                array) {
            System.out.println(i);
        }
    }

    public void calc(int[] a){
        int jNum = 0;
        int oNum = 0;
        int jSum = 0;
        int jL = 0;
        int p = 0;
        for(int i=0;i<a.length;i++){
            if(a[i]%2==0){
                oNum++;
            }else {
                jNum++;
            }
            if(i%2==0){
                jSum += a[i];
                jL++;
            }
        }
        p = jSum/jL;
        System.out.println("基数："+jNum);
        System.out.println("偶数："+oNum);
        System.out.println("平均数："+p);
    }

    public void myuppercase(String a){
        String s = Change(a);
        String result = "";
        for(int i=0;i<s.length();i++){
            if(i>0){
                if(String.valueOf(s.charAt(i-1)).equals(";")||String.valueOf(s.charAt(i-1)).equals(".")){
                    result += String.valueOf(s.charAt(i)).toUpperCase();
                }else {
                    result += String.valueOf(s.charAt(i));
                }
            }else {
                result += String.valueOf(s.charAt(i)).toUpperCase();
            }
        }
        System.out.println(result);
    }
}
