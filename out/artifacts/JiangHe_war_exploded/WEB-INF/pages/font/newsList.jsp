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
    <script src="<%=request.getContextPath()%>/asset_font/js/common.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/respond.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/index.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/CommonlyFunction.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/newsList.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset/layer/layer.js" type="text/javascript"></script>
    <script type="text/javascript">
        //获取所属模块id
        var moduleType = GetQueryString("moduleType");
        var newsClass = GetQueryString("newsClass");
        var type = GetQueryString("type");
        var sqlStr = GetQueryString("sqlStr");
        var newsDescribe = GetQueryString("newsDescribe");
        var totalNUm=5;
        var page=1;
        var rows=5;
        $(function(){
            $.post("/jsons/statistics.form",{statisticsId:'newsList'},function(){

            })
        });
        $(function(){
            //隐藏header中的图片
            $(".banner img").hide();
            //类型为特殊集合页的需要单独处理
            if(type==1){
                reload_1();
            }else if(type==2){
                reload_2();
            }else if(type==3){
                reload_3();
            }else{
                reload_4();
            }
            //绑定翻页搜索框输入的回车时间
            $(".currentPageNum").keyup(function(e){
                if(e.keyCode==13){
                    try{
                        var newpage= parseInt($(".currentPageNum").val());
                        if(newpage<=1){
                            page=1;
                            $(".currentPageNum").val(1);
                        }else if(newpage>=Math.ceil(totalNUm/rows)){
                            page=Math.ceil(totalNUm/rows);
                            $(".currentPageNum").val(page);
                        }else{
                            page=newpage;
                        }
                        if(type==1){
                            reload_1();
                        }else if(type==2){
                            reload_2();
                        }else if(type==3){
                            reload_3();
                        }else{
                            reload_4();
                        }
                    }catch (e){
                        layer.msg("您输入的页码，不符合规定");
                    }
                }
            });
            //加载新闻图片
            $.ajax({
                url:"/jsons/loadNewsimg.form",
                type:"post",
                data:{rows:3,page:1},
                dataType:"json",
                cache: false,
                success:function(data){
                    if(data.rows != null){
                        for(var i = 0; i < data.rows.length; i++){
                            var row=data.rows[i];
                            $(".load").eq(i).attr("src","<%=request.getContextPath()%>/Files/Images/"+row.imgLink);
                            $(".load").eq(i).attr("title",row.imgName);
                        }
                    }
                },
                error:function(){
                    layer.alert("服务器连接失败");
                }
            });
        });
        //特殊处理文件下载
        function Download(val){
            window.open("<%=request.getContextPath()%>/Files/Files/"+val);
        }
        function reload_1(){
            //根据页码加载数据
            $.ajax({
                url:"/news/loadAllNews.form",
                type:"post",
                data:{moduleType:moduleType,page:page,rows:rows,newsClass:newsClass,sqlStr:sqlStr,newsDescribe:newsDescribe},
                dataType:"json",
                success:function(data){
                    $("#newsContent").html('');
                    var str='';
                    if(data.rows&&data.rows.length>0){
                        totalNUm=data.total;
                        var titleName=data.rows[0].sysmenu_name.replace("管理","");
                        $("#titleName").html(titleName);
                        for(var i=0;i<data.rows.length;i++){
                            var row=data.rows[i];
                            str='<li>'+
                                    '<a href="javascript:void(0)" onclick="Download(\''+row.newsFile+'\');">'+
                                    '<div></div>'+
                                    '<span>'+row.createDates+'</span>'+
                                    '<b>'+row.newsTitle+'</b>'+
                                    '<span>'+row.newsDescribe+'</span>'+
                                    '</a>'+
                                    '</li>';
                            str=str.replace(/null/,"");
                            $("#newsContent").append(str);
                        }
                    }else{
                        totalNUm=0;
                    }
                }
            });
        }
        function reload_2(){
            //根据页码加载数据
            $.ajax({
                url:"/jsons/loadLink.form",
                type:"post",
                data:{linkClass:moduleType,page:page,rows:rows,newsClass:newsClass,sqlStr:sqlStr,newsDescribe:newsDescribe},
                dataType:"json",
                success:function(data){
                    $("#newsContent").html('');
                    var str='';
                    if(data.rows&&data.rows.length>0){
                        totalNUm=data.total;
                        $("#titleName").html(moduleType);
                        for(var i=0;i<data.rows.length;i++){
                            var row=data.rows[i];
                            str='<li>'+
                                    '<a href="http://'+row.linkName+'" target="_blank">'+
                                    '<div></div>'+
                                    '<b>'+row.linkContent+'</b>'+
                                    '</a>'+
                                    '</li>';
                            str=str.replace(/null/,"");
                            $("#newsContent").append(str);
                        }
                    }else{
                        totalNUm=0;
                    }
                }
            });
        }
        //根据页码加载数据
        function reload_3(){
            //根据页码加载数据
            $.ajax({
                url:"/news/loadAllNews.form",
                type:"post",
                data:{moduleType:moduleType,page:page,rows:rows,newsClass:newsClass,sqlStr:sqlStr,newsDescribe:newsDescribe},
                dataType:"json",
                success:function(data){
                    $("#newsContent").html('');
                    var str='';
                    if(data.rows&&data.rows.length>0){
                        totalNUm=data.total;
                        $("#titleName").html(newsClass);
                        for(var i=0;i<data.rows.length;i++){
                            var row=data.rows[i];
                            str='<li>'+
                                    '<a href="detail.form?newsId='+data.rows[i].newsId+'&type=1&newsClass='+newsClass+'">'+
                                    '<div></div>'+
                                    '<span></span>'+
                                    '<b>'+data.rows[i].newsTitle+'</b>'+
                                    '<span></span>'+
                                    '</a>'+
                                    '</li>';
                            str=str.replace(/null/,"");
                            $("#newsContent").append(str);
                        }
                    }else{
                        totalNUm=0;
                    }
                }
            });
        }
        function reload_4(){
            $.ajax({
                url:"/news/loadAllNews.form",
                type:"post",
                data:{moduleType:moduleType,page:page,rows:rows,newsClass:newsClass,sqlStr:sqlStr,newsDescribe:newsDescribe},
                dataType:"json",
                success:function(data){
                    $("#newsContent").html('');
                    var str='';
                    if(data.rows&&data.rows.length>0){
                        totalNUm=data.total;
                        var titleName=data.rows[0].sysmenu_name.replace("管理","");
                        $("#titleName").html(titleName);
                        for(var i=0;i<data.rows.length;i++){
                            str='<li>'+
                                    '<a href="detail.form?newsId='+data.rows[i].newsId+'">'+
                                    '<div></div>'+
                                    '<span>'+data.rows[i].createDates+'</span>'+
                                    '<b>'+data.rows[i].newsTitle+'</b>'+
                                    '<span>'+data.rows[i].newsDescribe+'</span>'+
                                    '</a>'+
                                    '</li>';
                            str=str.replace(/null/,"");
                            $("#newsContent").append(str);
                        }
                    }else{
                        totalNUm=0;
                    }
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
        //上一页
        function turn_left(){
            var newpage= parseInt($(".currentPageNum").val());
            if(newpage<=1){
                newpage=1;
                $(".currentPageNum").val(1);
            }else{
                newpage=newpage-1;
                $(".currentPageNum").val(newpage);
            }
            page=newpage;
            if(type==1){
                reload_1();
            }else if(type==2){
                reload_2();
            }else if(type==3){
                reload_3();
            }else{
                reload_4();
            };
        }
        //下一页
        function turn_right(){
            var newpage= parseInt($(".currentPageNum").val());

            if(newpage>=Math.ceil(totalNUm/rows)){
                newpage=Math.ceil(totalNUm/rows);
                $(".currentPageNum").val(newpage);
            }else{
                newpage=newpage+1;
                $(".currentPageNum").val(newpage);
            }
            page=newpage;
            if(type==1){
                reload_1();
            }else if(type==2){
                reload_2();
            }else if(type==3){
                reload_3();
            }else{
                reload_4();
            }
        }
        //跳转到详情页
        function go(val){
            window.location.href="newsList.form?moduleType="+val;
        }
//        function newsimgerr(btn,i){
//            if(i==1)
//                $(btn).attr("src","'/asset_font/images/img1_07.png'");
//            if(i==2)
//                $(btn).attr("src","'/asset_font/images/img2_07.png'");
//            if(i==3)
//                $(btn).attr("src","'/asset_font/images/img3_07.png'");
//        }
    </script>

</head>
<body>
<!--头
-->
<%@include file="common_head.jsp"%>

<div class="section">
    <!--图片区
    -->
    <ul class="imgBox">
        <li>
            <img class="load" src=""  onerror="src='/asset_font/images/img1_07.png'" onclick="go('e3df07f5-c039-11e6-9c1a-00ac7dc2f176')"/>
        </li>
        <li>
            <img class="load" src=""  onerror="src='/asset_font/images/img2_07.png'" onclick="go('f18f1f50-c039-11e6-9c1a-00ac7dc2f176')"/>
        </li>
        <li>
            <img class="load" src=""  onerror="src='/asset_font/images/img3_07.png'" onclick="go('f9f94fe6-c039-11e6-9c1a-00ac7dc2f176')" />
        </li>
        <a href="<%=request.getContextPath()%>/views/font/index.form">
            [更多]
        </a>
    </ul>
    <!--新闻区
    -->
    <div class="news_box">
        <div class="news">
            <p>
                <span id="titleName" style="font-size: 18px">新闻</span><span>NEWS</span>
                <img src="<%=request.getContextPath()%>/asset_font/images/imgsound_11.png" />
            </p>
            <!--新闻列表
                    -->
            <div class="newsList">
                <ul id="newsContent">
                    <%--<li>--%>
                        <%--<a href="">--%>
                            <%--<div></div>--%>
                            <%--<span>[2016-07-15]</span>--%>
                            <%--<b>dasdnf递归哈哈哈</b>--%>
                            <%--<span>的说法发的什么撒地方了按，萨达 大师傅打算 阿斯蒂芬啊 但是打发阿斯蒂芬水电费但是个但是水电费的个但是</span>--%>
                        <%--</a>--%>
                    <%--</li>--%>
                </ul>
                <ol>
                    <ol>
                        <b class="first" onclick="turn_left()"></b>
                        <li><input class="currentPageNum" value="1" style="width: 26px;text-align: center;"/></li>
                        <%--<li>2</li>--%>
                        <%--<li>3</li>--%>
                        <b class="last" onclick="turn_right()"></b>
                    </ol>
                </ol>
            </div>
        </div>
        <!--左导航
                    -->
        <div class="leftNav">
            <b></b>
            <!--背景灰条
                        -->
            <ul>
                <li>
                    <a href="newsList.form?moduleType=e3df07f5-c039-11e6-9c1a-00ac7dc2f176&trans=0">
                        <span>通知公告</span>
                        <b></b>
                    </a>
                </li>
                <li>
                    <a href="newsList.form?moduleType=f18f1f50-c039-11e6-9c1a-00ac7dc2f176&trans=1">
                        <span>学院新闻</span>
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
    </div>
</div>
<!--脚
-->
<%@include file="common_foot.jsp"%>
</body>
</html>
