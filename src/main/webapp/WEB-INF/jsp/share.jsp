<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/6/29 0029
  Time: 下午 2:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>${CACHE_SYS_CONFIG.sysWebsitename}</title>
    <meta http-equiv="Expires" content="-1">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta name="format-detection" content="telephone=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <script src="/common/js/jquery-1.8.3.min.js"></script>
    <script src="/common/js/jquery.qrcode.min.js"></script>
    <script src="/common/share/nativeShare.js"></script>
    <script src="//open.mobile.qq.com/sdk/qqapi.js"></script>
    <script src="//res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
    <link rel="stylesheet" href="/common/share/nativeShare.css"/>
    <style type="text/css">
        .yq_code {
            position: fixed;
            top: 30%;
            left: 9%;
            width: 82%;
            height: auto;
            background-color: #fff;
            padding-top: 1rem;
            padding-bottom: 2rem;
            text-align: center;
            padding-bottom: 1.5rem;
            display: none;
            box-shadow: 0px 0px 2px #f7f7f7;
            z-index: 9999; /* 此处的图层要大于覆盖层 */
        }

        #overlay {
            background: #000;
            filter: alpha(opacity=50); /* IE的透明度 */
            opacity: 0.5; /* 透明度 */
            display: none;
            position: absolute;
            top: 0px;
            left: 0px;
            width: 100%;
            height: 100%;
            z-index: 100; /* 此处的图层要大于页面 */
            display: none;
            _background-color: #a0a0a0; /* 解决IE6的不透明问题 */
        }

        .mark {
            position: fixed;
            left: 0;
            top: 0;
            opacity: .5;
            width: 100%;
            height: 100%;
            background: #000;
            z-index: 998;
        }

        .header #mytitleh1 {
            height: auto;
            width: 100%;
            line-height: 3rem;
            font-size: 16px;
            font-family: 'Microsoft YaHei';
            color: #333333;
        }

        .welfare_up {
            width: 100%;
            background-image: url('${configjscss}/images2/invite/grid_background.png');
            background-size: 100%;
            background-repeat: no-repeat;
        }

        .recommend div i {
            margin-right: 10px;
        }

        .explain_icon {
            text-indent: 1px;
            letter-spacing: 1px;
            display: inline-block;
            color: #fff;
            border-radius: 3px;
            border: 1px solid #fff;
            text-shadow: none;
            font-size: 14px;
            font-size: 0.7rem;
            line-height: 16px;
        }

        .gt_icon {
            display: inline-block;
            color: #fff;
            height: 18px;
            width: 18px;
            line-height: 16px;
            font-size: 16px;
            background-color: #ff5757;
            border-radius: 50%;
            -moz-border-radius: 50%;
            -webkit-border-radius: 50%;
            text-shadow: none;
            text-align: center;
            font-family: "Consolas", "Monaco", "Bitstream Vera Sans Mono", "Courier New", Courier, monospace;
            margin-left: 3px;
        }

        .ui-page {
            background-image: -webkit-linear-gradient(left, #efc0af, #f9ecdb, #efc0af);
            color: #9e582e;
        }

    </style>
    <script>
        var isWeixin = null;
        var isqq = "";
        var ua = "";
        var urlHead = "${urlHead}";//分享路径
        $(document).ready(function () {
            ua = navigator.userAgent.toLowerCase();
            isWQ();//判断是不是qq
            isWeixin = ua.indexOf('micromessenger') != -1;//判断是不是微信
            if (isWeixin) {
                wx.config({
                    debug: false,
                    appId: '${wx.appId}',
                    timestamp: "${wx.timestamp}",
                    nonceStr: "${wx.noncestr}",
                    signature: "${wx.signature}",
                    jsapi_ticket: "${wx.ticket}",
                    jsApiList: ['checkJsApi', 'onMenuShareTimeline', 'onMenuShareAppMessage', 'onMenuShareQQ', 'onMenuShareWeibo', 'onMenuShareQZone', 'showOptionMenu', 'hideAllNonBaseMenuItem', 'showAllNonBaseMenuItem']
                });
                wx.ready(function () {
                    var share = {
                        title: '${setting.shareTitle}',
                        desc: '${setting.shareDesc}',
                        imgUrl: '${path}' + '${setting.imgUrl}',
                        link: urlHead,
                        success: function (data) {
                            console.log("success" + JSON.stringify(data))
                        },
                        cancel: function (data) {
                            console.log("cancel" + JSON.stringify(data))
                        }
                    };
                    wx.onMenuShareAppMessage(share);  // 微信好友
                    wx.onMenuShareTimeline(share);  // 朋友圈
                    wx.onMenuShareQQ(share);  // QQ
                    wx.onMenuShareQZone(share);  // QQ空间
                    wx.onMenuShareWeibo(share);  // 腾讯微博
                });
            } else if (isqq == "qq") {
                var share = {
                    title: '${setting.shareTitle}',
                    desc: '${setting.shareDesc}',
                    image_url: '${path}' + '${setting.imgUrl}',
                    share_url: urlHead
                };
                mqq.data.setShareInfo(share, function (data) {
                    if (data != true) {
                    }
                });
            } else {
                var config = {
                    url: urlHead,
                    title: '${setting.shareTitle}',
                    desc: '${setting.shareDesc}',
                    img: '${path}' + '${setting.imgUrl}',
                    img_title: '${setting.shareTitle}',
                    from: '财易久'
                };
                var share_obj = new nativeShare('nativeShare', config);
            }

            $("#cover_cotain").on("click", function () {
                $("#cover_cotain").hide();
            })

        });

        function isWQ() {
            var ua = window.navigator.userAgent.toLowerCase();
            if (ua.indexOf('qq') > -1) {
                if (/nettype/i.test(ua)) {
                    //微信或者QQ
                    if (/micromessenger/i.test(ua)) {
                        //微信
                        isqq = "weixin";
                    } else {
                        //QQ
                        isqq = "qq";
                    }
                } else {
                    //QQ浏览器
                    isqq = "";
                }
            } else {
                //其他浏览器
                isqq = "";
            }
        }

        function toShare() {
            var uas = navigator.userAgent.toLowerCase();
            var androidApp = uas.indexOf('fromandroidapp') != -1;
            var iosApp = uas.indexOf('fromiosapp') != -1;
            if (!androidApp && !iosApp) {
                var isWeixin = uas.indexOf('micromessenger') != -1;
                if (isWeixin) {
                    $("#cover_cotain").show();
                } else if (isqq == "qq") {
                    mqq.ui.showShareMenu();
                } else {
                    $("#nativeShare").show();
                }
            } else {
                $.openPage("//web/app/sharePage.do");

            }
        }


    </script>

</head>
<body>
<div style="text-align: center; margin-top: 20px;">
    <div style="background-image: url('${configjscss}/images2/invite/invite_button.png');margin: 0px 12%;border-radius:35px;
            background-position: center;" onclick="toShare()">
        <span>立即邀请好友</span>
    </div>
</div>
<div id="cover_cotain" class="mark" style="display: none"><img style="width: 100%"
                                                               src="/common/share/share.png"/></div>
<div id="nativeShare" style="display: none;line-height: normal"></div>
<div id="overlay"></div>
<div class="yq_code" id="codeDialog">
    <div style="text-align: center">
        <p style="width: 50px; border-bottom: 1px solid #f7f7f7; display: inline-block;"></p>
        <span style="margin: 0px 20px; position: relative; top:3px;">分享至</span>
        <p style="width: 50px; border-bottom: 1px solid #f7f7f7; display: inline-block;"></p>
    </div>
    <div id="qrcode" style="padding: 20px 0; border-bottom: 1px solid #f7f7f7"></div>
    <div style="font-size: 18px; text-align: center; line-height: 30px;"><span>扫描二维码加入财易久</span></div>
</div>
</div>
</body>
<script type="text/javascript">

    function inviteCode() {
        var invitesUrl = "${urlHead}" + "?from=code";
        console.log(invitesUrl);
        jQuery('#qrcode').qrcode({width: 170, height: 170, text: invitesUrl})
    }

    inviteCode();

    function closeCover() {
        $.mobile.loading('hide');
    }

    function showCode(e) {
        showCode();
    }

    function showCode() {
        showOverlay();
        $("#codeDialog").toggle();
    }

    function showOverlay() {
        $("#overlay").height(document.body.scrollHeight);
        $("#overlay").width(document.body.scrollWidth);
        // fadeTo第一个参数为速度，第二个为透明度
        // 多重方式控制透明度，保证兼容性，但也带来修改麻烦的问题
        $("#overlay").fadeTo(200, 0.5);
        // 解决窗口缩小时放大后不全屏遮罩的问题
        // 简单来说，就是窗口重置的问题
        $(window).resize(function () {
            $("#overlay").height(document.body.scrollHeight);
            $("#overlay").width(document.body.scrollWidth);
        });
    }

    /* 隐藏覆盖层 */
    function hideOverlay() {
        $("#overlay").fadeOut(200);
        $("#codeDialog").hide();
    }
</script>
</html>
