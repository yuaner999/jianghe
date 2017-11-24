/*
*Created by liulei on 2016-05-25.
*/

import org.junit.Test;
import org.omg.PortableInterceptor.SYSTEM_EXCEPTION;

/**
 * Created by liulei on 2016-05-25.
 */
public class ExtentTest {

    @Test
    public void t(){
        Base b = new Sub();
        System.out.println(b.x);
        b.printMessage();
        b.p();
    }
}

class Base{
    int x = 10;
    public Base(){
        this.printMessage();
        x = 20;
    }
    public void printMessage(){
        System.out.println("Base.x = " + x);
    }
    public void p(){
        System.out.println(x);
    }
}

class Sub extends Base{
    int x = 30;
    public Sub(){
        this.printMessage();
        x = 40;
    }
    public void printMessage(){
        System.out.println("Sub.x = " + x);
    }
}