/*
*Created by liulei on 2016/5/15.
*/
package com.utils;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import net.sf.json.JSONObject;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.UUID;

/**
 * Created by liulei on 2016/5/15.
 */
public class WeChatUtils {
    public static final String GET_TOKEN_URL = "https://api.weixin.qq.com/cgi-bin/token?";// 获取accessurl
    public static final String APP_ID = "wx859353b820585d28";//公众号appid唯一标识
    public static final String SECRET = "d4624c36b6795d1d99dcf0547af5443d";//公众号secret

    /**
     * SHA1加密算法
     * @param decript
     * @return
     */
    public static String SHA1(String decript) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-1");
            digest.update(decript.getBytes());
            byte messageDigest[] = digest.digest();
            StringBuffer hexString = new StringBuffer();
            for (int i = 0; i < messageDigest.length; i++) {
                String shaHex = Integer.toHexString(messageDigest[i] & 0xFF);
                if (shaHex.length() < 2) {
                    hexString.append(0);
                }
                hexString.append(shaHex);
            }
            return hexString.toString();

        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return "";
    }

    /**
     * 获取accesstoken，有限期是7200秒需进行缓存
     * @return
     */
    public static String getToken(){
        String turl = String.format("%sgrant_type=client_credential&appid=%s&secret=%s", GET_TOKEN_URL, APP_ID, SECRET);
        HttpClient client = new DefaultHttpClient();
        HttpGet get = new HttpGet(turl);
        JsonParser jsonparer = new JsonParser();// 初始化解析json格式的对象
        String result = "";
        try
        {
            HttpResponse res = client.execute(get);
            String responseContent = null; // 响应内容
            HttpEntity entity = res.getEntity();
            responseContent = EntityUtils.toString(entity, "UTF-8");
            JsonObject json = jsonparer.parse(responseContent).getAsJsonObject();// 将json字符串转换为json对象
            if (res.getStatusLine().getStatusCode() == HttpStatus.SC_OK)
            {
                if (json.get("errcode") != null)
                {// 错误时微信会返回错误码等信息，{"errcode":40013,"errmsg":"invalid appid"}
                    result = "accesstoken获取失败！错误码是："+json.get("errcode").getAsString();
                }
                else
                {// 正常情况下{"access_token":"ACCESS_TOKEN","expires_in":7200}
                    result = json.get("access_token").getAsString();
                }
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        finally
        {
            // 关闭连接 ,释放资源
            client.getConnectionManager().shutdown();
            return result;
        }
    }

    /**
     * 获取用户信息
     * @param accessToken
     * @param openid
     * @return
     */
    public static JSONObject getUserInformation(String accessToken, String openid){

        String url = "https://api.weixin.qq.com/sns/userinfo?access_token="+accessToken
                +"&openid="+openid+"&lang=zh_CN";
        //获取用户信息
        JSONObject jsonObject = JSONObject.fromObject(HttpRequestUtils.sendGet(url));

        if(jsonObject.containsKey("errcode")){
            jsonObject.put("error","获取用户信息失败");
            return jsonObject;
        }
        jsonObject.getString("headimgurl");
        jsonObject.replace("headimgurl",jsonObject.getString("headimgurl"),jsonObject.getString("headimgurl").replace("\\",""));

        return jsonObject;
    }

    /**
     * 获取jsapi_ticket
     * @param accessToken
     * @return
     */
    public static JSONObject getJsapiTicket(String accessToken){
        String url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token="+accessToken+"&type=jsapi";

        //获取jsapi_ticket
        String jsapiTicket = HttpRequestUtils.sendGet(url);
        JSONObject jsonObject = JSONObject.fromObject(jsapiTicket);

        return jsonObject;
    }

    /**
     * 生成签名
     * @return
     */
    public static JSONObject getSign(String jsapiTicket, String url){

        JSONObject jsonObject = new JSONObject();
        String noncestr = createNonceStr();//随机字符串
        long timestamp = createTimestamp();//时间戳

        //注意这里参数名必须全部小写，且必须有序
        String string = "jsapi_ticket=" + jsapiTicket +
                "&noncestr=" + noncestr +
                "&timestamp=" + timestamp +
                "&url=" + url;
        String signature = SHA1(string);

        jsonObject.put("timestamp",timestamp);
        jsonObject.put("nonceStr",noncestr);
        jsonObject.put("signature",signature);

        return jsonObject;
    }

    /**
     * 生成签名的随机串
     * @return
     */
    public static String createNonceStr() {
        return UUID.randomUUID().toString();
    }

    /**
     * 生成时间戳
     */
    public static long createTimestamp(){
        Date date = new Date();
        return date.getTime();
    }
}
