package com.xiaomi.controller;

import com.alibaba.fastjson.JSONObject;
import com.xiaomi.bean.WinXinEntity;
import com.xiaomi.util.WeinXinUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * @Author: xiaomi
 * @Description:
 * @Date:下午 2:26 2018/6/29 0029
 * @Email:a1205938863@gmail.com
 **/
@Controller
@RequestMapping(value = "share")
public class ShareController {
    private static final Logger logger = LoggerFactory.getLogger(ShareController.class);

    @RequestMapping(value = "/page")
    public String getShare(HttpServletRequest request, HttpServletResponse response, Model model) {
        String path = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
        String strUrl = path +
                request.getRequestURI() + "?" + request.getQueryString(); //参数
        WinXinEntity wx = WeinXinUtil.getWinXinEntity(strUrl);
        //将wx的信息到给页面
        logger.info("---------------------------------------" + strUrl + "----------------------");
        request.setAttribute("wx", wx);
        String setting="{'imgUrl':'/common/share/30220803.png','shareTitle':'小米博客','shareDesc':'欢迎访问小米兄弟的博客','urlHead':'/share/toBlog.do','id':'0'}";
        Map map = JSONObject.parseObject(setting, Map.class);
        request.setAttribute("urlHead", path+map.get("urlHead")+"?share=share");
        request.setAttribute("setting", map);
        request.setAttribute("path", path);
        return "/share";
    }



    @RequestMapping(value = "/toBlog")
    public String toBog(HttpServletRequest request, HttpServletResponse response){
        return "/toBlog";
    }
}
