package com.xiaomi.bean;

/**
 * @Author: xiaomi
 * @Description:
 * @Date:下午 12:11 2018/6/14 0014
 * @Email:a1205938863@gmail.com
 **/
public class WinXinEntity {
    private String access_token;
    private String ticket ;
    private String noncestr;
    private String timestamp;
    private String str;
    private String signature;
    private String appId;

    public String getAppId() {
        return appId;
    }

    public void setAppId(String appid) {
        this.appId = appid;
    }

    public String getAccess_token() {
        return access_token;
    }

    public void setAccess_token(String access_token) {
        this.access_token = access_token;
    }

    public String getTicket() {
        return ticket;
    }

    public void setTicket(String ticket) {
        this.ticket = ticket;
    }

    public String getNoncestr() {
        return noncestr;
    }

    public void setNoncestr(String noncestr) {
        this.noncestr = noncestr;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public String getStr() {
        return str;
    }

    public void setStr(String str) {
        this.str = str;
    }

    public String getSignature() {
        return signature;
    }

    public void setSignature(String signature) {
        this.signature = signature;
    }
}
