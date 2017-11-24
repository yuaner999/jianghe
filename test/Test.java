import com.lowagie.text.DocumentException;
import com.lowagie.text.pdf.BaseFont;
import com.utils.PwdUtil;
import org.xhtmlrenderer.pdf.ITextRenderer;

import java.io.*;
import java.lang.reflect.Field;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by admin on 2016/7/15.
 */
public class Test {
    @org.junit.Test
    public void test(){
        try {
            System.out.println(PwdUtil.getPassMD5("175d9c9d9362fe24515b2f641ed4539f18afad23e75d8bcf7954c0812746694794c0b7789311b98ccc87b5dcfeed77fc").toLowerCase());
            System.out.println(PwdUtil.getPassMD5(PwdUtil.getPassMD5("16511x")));
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
    }

    @org.junit.Test
    public void testAES(){
        String str="";
        String ciphertext =PwdUtil.AESEncoding(str);
        System.out.println(ciphertext.toLowerCase());
        String content=PwdUtil.AESDecoding(ciphertext);
        System.out.println(content);
        System.out.println(str.length()+"|"+ciphertext.length());
    }



    @org.junit.Test
    public void test_export_pdf_xhtmlrenderer() throws IOException, DocumentException {
        String pdfName = "/D:/studentManager/out/artifacts/StudentManage_war_exploded/"+new SimpleDateFormat("yyyyMMddHHmmss").format(new Date())+".pdf";
        OutputStream os;
        try {
            os = new FileOutputStream(pdfName);
            ITextRenderer renderer = new ITextRenderer();
//            Document doc=
            renderer.setDocument("file:/D:/studentManager/out/artifacts/StudentManage_war_exploded/contractTemplate.html");

// 解决汉字问题
            renderer.getFontResolver().addFont("C:/WINDOWS/Fonts/SIMSUN.TTC", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);// 宋体字
//// 解决图片的相对路径问题
//            renderer.getSharedContext().setBaseURL("file:/D:/work_code_2014/order/src/main/webapp/");
            renderer.layout();
            renderer.createPDF(os);
            os.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (DocumentException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
