<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/12/15
  Time: 9:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <!--兼容360浏览器，防止布局乱，设置IE的文档模式为最高版本，并且如果存在chrome插件，自动使用Webkit引擎-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title></title>
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset_font/images/neu.jpg" type="image/x-icon">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font/css/common_head.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font/css/common_foot.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font/css/newsList.css"/>
    <script src="<%=request.getContextPath()%>/asset_font/js/jquery-2.1.0.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/jquery.dotdotdot.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/common_head.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/common.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/respond.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/index.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/CommonlyFunction.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/newsList.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset/layer/layer.js" type="text/javascript"></script>
    <script type="text/javascript">
        //获取所属模块id
        var newsClass = GetQueryString("newsClass");
        var type = GetQueryString("type");
        var sqlStr = GetQueryString("sqlStr");
        var newsDescribe = GetQueryString("newsDescribe");
        var totalNUm=5;
        var page=1;
        var rows=5;
        var moduleType="f4d9dac1-c446-11e6-b626-00ac7dc2f176";
        $(function(){
            $.post("/jsons/statistics.form",{statisticsId:'newsList'},function(){

            })
        });
        $(function(){
            getpartteacher();
        });
        //特殊处理文件下载
        function Download(val){
            window.open("<%=request.getContextPath()%>/Files/Files/"+val);
        }
       /* 获取建筑系教授*/
       function getpartteacher(){
           var str="";
           $.ajax({
               url:"/jsons/loadarcprofession.form",
               type:"post",
               data:{moduleType:moduleType},
               dataType:"json",
               success:function(data){
                   for(var i=0,j=0;i<data.rows.length;i++,j++){
                       if(j==10)
                       {
                           str+="<br>";
                           j=0;
                       }
                       str+="<a href='detail.form?newsId="+data.rows[i].newsId+"&type=1'>"+data.rows[i].newsTitle+"</a>";
                   }
                   str=str.replace(/null/,"");
                   $("#arcpro").append(str);
               }
           });
       }

        //获取URL参数
        function GetQueryString(name)
        {
            var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if(r!=null)return  decodeURI(r[2]); return null;
        }

     /*   //跳转到详情页
        function go(val){
            window.location.href="newsList.form?moduleType="+val;
        }*/
//        function newsimgerr(btn,i){
//            if(i==1)
//                $(btn).attr("src","'/asset_font/images/img1_07.png'");
//            if(i==2)
//                $(btn).attr("src","'/asset_font/images/img2_07.png'");
//            if(i==3)
//                $(btn).attr("src","'/asset_font/images/img3_07.png'");
//        }
    </script>
    <style>
        #arcpro a{
            margin: 0 0 20px;
            width: 20%;
        }
    </style>
</head>
<body>
<!--头
-->
<%@include file="common_head.jsp"%>

<div class="section">

    <!--新闻区
    -->
    <div class="news_box">

        <!--左导航
                    -->
        <div class="leftNav">
            <b></b>
            <!--背景灰条
                        -->
            <ul style="margin-top: 120px">
                <li>
                    <a href="newsList.form?moduleType=f18f1f50-c039-11e6-9c1a-00ac7dc2f176&trans=1">
                        <span>学院新闻</span>
                        <b></b>
                    </a>
                </li>
                <li>
                    <a href="newsList.form?moduleType=e3df07f5-c039-11e6-9c1a-00ac7dc2f176&trans=0">
                        <span>通知公告</span>
                        <b></b>
                    </a>
                </li>
                <li>
                    <a href="newsList.form?moduleType=f9f94fe6-c039-11e6-9c1a-00ac7dc2f176&trans=2">
                        <span>学术活动</span>
                        <b></b>
                    </a>
                </li>
                <li>
                    <a href="newsList.form?moduleType=0841f577-c03a-11e6-9c1a-00ac7dc2f176&trans=3">
                        <span>学科建设</span>
                        <b></b>
                    </a>
                </li>
                <li>
                    <a href="newsList.form?moduleType=029d3282-c03a-11e6-9c1a-00ac7dc2f176&trans=4">
                        <span>人才引进</span>
                        <b></b>
                    </a>
                </li>
                <li class="last">
                    <a href="newsList.form?moduleType=0f455850-c03a-11e6-9c1a-00ac7dc2f176&trans=5">
                        <span>活动预告</span>
                        <b></b>
                    </a>
                </li>
            </ul>
        </div>
        <div class="news">
            <p>
                <span id="titleName" style="font-size: 18px">兼职教师</span><span id="isnews"></span>

            </p>
            <!--新闻列表
                    -->
            <div class="newsList">
                <div id="newsContent">
                    <div class="zhaunye">
                        <p class="xiname">兼职教师</p>
                        <div class="teachers">
                            <div class="zhichen">
                                <div style="display: inline-block;"></div>
                                <div id="arcpro" style="padding-top: 5px;">
                                <%--    <a href="#">孙贺</a><a >孙贺</a><a>孙贺</a><a >孙贺</a><a>孙贺</a>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--脚
-->
<%@include file="common_foot.jsp"%>
</body>
</html>
