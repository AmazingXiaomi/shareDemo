package com.xiaomi.util;

/**
 * @Author: xiaomi
 * @Description:
 * @Date:下午 12:03 2018/6/14 0014
 * @Email:a1205938863@gmail.com
 **/

import com.xiaomi.bean.WinXinEntity;
import net.sf.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Map;

public class WeinXinUtil {
    private static final Logger logger = LoggerFactory.getLogger(WeinXinUtil.class);

    public static  String getProperties(String prop){
        return PropertiesUtil.get(prop);
    }
    public static WinXinEntity getWinXinEntity(String url) {
        WinXinEntity wx = new WinXinEntity();
        String access_token = getAccessToken();
        String ticket = getTicket(access_token);
        Map<String, String> ret = Sign.sign(ticket, url);
        //System.out.println(ret.toString());
        wx.setTicket(ret.get("jsapi_ticket"));
        wx.setSignature(ret.get("signature"));
        wx.setNoncestr(ret.get("nonceStr"));
        wx.setTimestamp(ret.get("timestamp"));
        wx.setAppId(getProperties("WX.APPID"));
        return wx;
    }

    //获取token
    private static String getAccessToken() {
        String access_token = "";
        //获取access_token填写client_credential
        String grant_type = "client_credential";
        //第三方用户唯一凭证
        String AppId=getProperties("WX.APPID");
        //第三方用户唯一凭证密钥，即appsecret
        String secret=getProperties("WX.SECRET");
        //这个url链接地址和参数皆不能变 //访问链接
        String url = "https://api.weixin.qq.com/cgi-bin/token?grant_type="+grant_type+"&appid="+AppId+"&secret="+secret;

        try {
            URL urlGet = new URL(url);
            HttpURLConnection http = (HttpURLConnection) urlGet.openConnection();
            // 必须是get方式请求
            http.setRequestMethod("GET");
            http.setRequestProperty("Content-Type","application/x-www-form-urlencoded");
            http.setDoOutput(true);
            http.setDoInput(true);
            /*System.setProperty("sun.net.client.defaultConnectTimeout", "30000");// 连接超时30秒
            System.setProperty("sun.net.client.defaultReadTimeout", "30000"); // 读取超时30秒 */
            http.connect();
            InputStream is = http.getInputStream();
            int size = is.available();
            byte[] jsonBytes = new byte[size];
            is.read(jsonBytes);
            String message = new String(jsonBytes, "UTF-8");
            logger.info("========================message"+message);
            JSONObject demoJson = JSONObject.fromObject(message);
            access_token = demoJson.getString("access_token");
            is.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return access_token;
    }

    //获取ticket
    private static String getTicket(String access_token) {
        String ticket = null;
        String url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token="+ access_token +"&type=jsapi";//这个url链接和参数不能变
        try {
            URL urlGet = new URL(url);
            HttpURLConnection http = (HttpURLConnection) urlGet.openConnection();
            http.setRequestMethod("GET"); // 必须是get方式请求
            http.setRequestProperty("Content-Type","application/x-www-form-urlencoded");
            http.setDoOutput(true);
            http.setDoInput(true);
            System.setProperty("sun.net.client.defaultConnectTimeout", "30000");// 连接超时30秒
            System.setProperty("sun.net.client.defaultReadTimeout", "30000"); // 读取超时30秒
            http.connect();
            InputStream is = http.getInputStream();
            int size = is.available();
            byte[] jsonBytes = new byte[size];
            is.read(jsonBytes);
            String message = new String(jsonBytes, "UTF-8");
            JSONObject demoJson = JSONObject.fromObject(message);
            ticket = demoJson.getString("ticket");
            is.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ticket;
    }
}