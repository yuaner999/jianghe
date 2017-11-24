<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/12/15
  Time: 9:32
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
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font/css/detail.css"/>
    <script src="<%=request.getContextPath()%>/asset_font/js/jquery-2.1.0.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/jquery.dotdotdot.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/common_head.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/common.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/respond.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/index.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/CommonlyFunction.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset/layer/layer.js" type="text/javascript"></script>
    <script type="text/javascript">
        //获取新闻id
        var newsId = GetQueryString("newsId");
        var type = GetQueryString("type");
        var newsClass = GetQueryString("newsClass");
        var teacher1="bb81e35a-02eb-11e7-9b3c-d8cb8ab8c894";
        var teacher2="47ffc8b3-02eb-11e7-9b3c-d8cb8ab8c894";
        var teacher3="27f9b203-02eb-11e7-9b3c-d8cb8ab8c894";
        var teacher4="120be153-02eb-11e7-9b3c-d8cb8ab8c894";
        var teacher5="f190764f-02ea-11e7-9b3c-d8cb8ab8c894";
        var teacher6="d8c88b88-02ea-11e7-9b3c-d8cb8ab8c894";
        var teacher7="c07f12b3-02ea-11e7-9b3c-d8cb8ab8c894";
        $(function(){
            $.post("/jsons/statistics.form",{statisticsId:'detail'},function(){

            })
        });
        $(function(){
            $(".navga").html('');
            if(type==1){
                var str='<li class="first">'+
                        '<div>'+
                            '<a href="">师资队伍</a>'+
                        '</div>'+
                        '<div>'+
                            '<a href="#" onClick="javascript:history.back(-1);">返回</a>'+
                        '</div>'+
                        '</li>'+
                        '<li>'+
                        '<div>'+
                        '<a href="teachercategorylist.form?">专职教师</a>'+
                        '</div>'+
                        '</li>'+
                        '<li>'+
                        '<div>'+
                        '<a href="partteachercategorylist.form?">兼职教师</a>'+
                        '</div>'+
                        '</li>';
                $(".navga").append(str);
                $("#link_father").html('<a href="">师资队伍</a>');
                $("#link_son").html('<a href="">专职教师</a>');
                //具体数据
                $.ajax({
                    url:"/news/loadNewsByNewsID.form",
                    type:"post",
                    data:{newsId:newsId},
                    dataType:"json",
                    async:false,
                    success:function(data){
                        if(data.rows != null&&data.rows.length>0){
                            $(".contTxt").html('');
                            var row=data.rows[0];
                            var str= '<p>'+row.newsTitle+'</p><div class="writer">'+
                                     '<span></span><span>'+(row.newsAuthor?row.newsAuthor:'')+'</span> <span>'+(row.newsDates.toString()?row.newsDates.toString():'')+'</span></div>'+
                            '<div class="muchTxt">'+(row.newsContent?row.newsContent:'') +'</div>';
                            $(".contTxt").append(str);
                        }
                    },
                    error:function(){
                        layer.alert("服务器连接失败");
                    }
                });
                $(".navga li:last").addClass("last");
                $('.navga li').each(function(){
                    if($(this).text()==newsClass){
                        $(this).addClass('sele');
                    }
                });
            }
            else {
                //左上导航
                $.ajax({
                    url:"/news/loadNavigation.form",
                    type:"post",
                    data:{newsId:newsId},
                    dataType:"json",
                    async:false,
                    success:function(data){
                        if(data.rows != null&&data.rows.length>0){
                            var str='';
                            for(var i = 0; i < data.rows.length; i++){
                                if(data.rows[i].sysmenu_name!="基层组织介绍")
                                {
                                    var sysmenu_name=data.rows[i].sysmenu_name.replace("管理",'');
                                    var row=data.rows[i];
                                    str= '<li>'+
                                            '<div>'+
                                            '<a href="javascript:void(0)" onclick="going(\''+data.rows[i].sysmenu_id+'\')">'+sysmenu_name+'</a>'+
                                            '</div>'+
                                            '</li>';
                                    $(".navga").append(str);
                                }
                            }
                        }
                    },
                    error:function(){
                        layer.alert("服务器连接失败");
                    }
                });
                //具体数据
                $.ajax({
                    url:"/news/loadNewsByNewsID.form",
                    type:"post",
                    data:{newsId:newsId},
                    dataType:"json",
                    async:false,
                    success:function(data){
                        if(data.rows != null&&data.rows.length>0){
                            $(".contTxt").html('');
                            var parentName=data.rows[0].parentName.replace("管理",'');
                            var sonName=data.rows[0].newsTitle;
                            $("#link_father").html('<a >'+parentName+'</a>');
                            $("#link_son").html('<a >'+sonName+'</a>');
                            var str1='';
                            var str2='';
                            for(var i = 0; i < data.rows.length; i++){
                                var row=data.rows[i];
                                str1= '<li class="first">'+
                                        '<div>'+
                                        '<a href="">'+(row.parentName?row.parentName:'')+'</a>'+
                                        '</div>'+
                                        '<div>'+
                                        '<a href="#" onClick="javascript:history.back(-1);">返回</a>'+
                                        '</div>'+
                                        '</li>';
                                str1=str1.replace("管理",'');
                                $(".navga").prepend(str1);
                                str2=   '<p id="sonName">'+(sonName?sonName:'')+'</p>'+
                                        '<div class="writer">'+
                                        '<span>发布人：</span>'+
                                        '<span>'+(row.newsAuthor?row.newsAuthor:'')+
                                        '</span>&nbsp;&nbsp;&nbsp;'+
                                        '<span>'+(row.newsDates.toString()?row.newsDates.toString():'')+
                                        '</span>'+
                                        '</div>'+
                                        '<div class="muchTxt">'+
                                        '<p style="text-align: center">'+(row.newsClass?row.newsClass:'')+'</p>'+
                                        (row.newsContent?row.newsContent:'')+
                                        '</div>';
                                str2=str2.replace("管理",'');
                                $(".contTxt").append(str2);
                            }
                        }
                    },
                    error:function(){
                        layer.alert("服务器连接失败");
                    },
                    complete:function(){
                        //左侧导航动态增加样式
                        $(".navga li:last").addClass("last");
                        var sonName=$("#sonName").text();

                        $('.navga li').each(function(){
                            if($(this).text()==sonName){
                                $(this).addClass('sele');
                            }
                        })
                    }
                });
            }
        });
        //点击左侧导航事件
        function going(value){
           if(value=='d6447c13-c037-11e6-9c1a-00ac7dc2f176'){
                window.location.href="schoolLeader.form";
            }
            else  if(value=='e4c2f87e-c037-11e6-9c1a-00ac7dc2f176'){
                window.location.href="organization.form";
            }
            else  if(value=='f51a61c8-c037-11e6-9c1a-00ac7dc2f176'){
                window.location.href="detail.form?newsId=ddc77760-c1d1-11e6-956b-00ac7dc2f176";
            }
            else if(value=='bd8ed368-c037-11e6-9c1a-00ac7dc2f176'){
                window.location.href="detail.form?newsId=64661991-d32b-11e6-be96-00ac7dc2f176";
            }
            else if(value=='a36caad6-c037-11e6-9c1a-00ac7dc2f176'){
                window.location.href="detail.form?newsId=5fa71abe-c1d1-11e6-956b-00ac7dc2f176";
            }
           else if(value==teacher1||value==teacher2||value==teacher3||value==teacher4||value==teacher5||value==teacher6||value==teacher7){
               window.location.href="teachercategorylist.form";
           }
           else if(value=='7386cd02-c04e-11e6-9c1a-00ac7dc2f176'){
               window.location.href="detail.form?newsId=b763a2cb-f265-11e6-827e-005056bf3cd7";
           }
           else if(value=='e91e9e81-c04d-11e6-9c1a-00ac7dc2f176'){
               window.location.href="detail.form?newsId=401ed8ea-0bc1-11e7-9b5e-d8cb8ab8c894";
           }
            else {
                window.location.href="newsList.form?moduleType="+value;
            }
        }
        //获取URL参数
        function GetQueryString(name)
        {
            var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if(r!=null)return  decodeURI(r[2]); return null;
        }
    </script>
</head>
<body>
<!--头
-->
<%@include file="common_head.jsp"%>
<!--身
-->
<div class="section">
    <!--左边
    -->
    <div class="left">
        <ul class="navga">
            <%--<li class="first">--%>
                <%--<div>--%>
                    <%--<a href="">学院概况</a>--%>
                <%--</div>--%>
                <%--<div>--%>
                    <%--<a href="">返回</a>--%>
                <%--</div>--%>
            <%--</li>--%>
            <%--<li class="sele">--%>
                <%--<div>--%>
                    <%--<a href="">历史沿革</a>--%>
                <%--</div>--%>
            <%--</li>--%>
            <%--<li>--%>
                <%--<div>--%>
                    <%--<a href="">学院简介</a>--%>
                <%--</div>--%>
            <%--</li>--%>
            <%--<li>--%>
                <%--<div>--%>
                    <%--<a href="">学院领导</a>--%>
                <%--</div>--%>
            <%--</li>--%>
            <%--<li>--%>
                <%--<div>--%>
                    <%--<a href="">组织机构</a>--%>
                <%--</div>--%>
            <%--</li>--%>
            <%--<li class="last">--%>
                <%--<div>--%>
                    <%--<a href="">大事记</a>--%>
                <%--</div>--%>
            <%--</li>--%>
        </ul>
    </div>
    <div class="right">
        <div class="topNav">
        			<span>
        				当前位置：
        			</span>
            <ul>
                <li id="link_father">
                    <%--<a href="">学院概况</a>--%>
                </li>
                <span>></span>
                <li id="link_son">
                    <%--<a href="">历史沿革</a>--%>
                </li>
            </ul>
        </div>
        <div class="contTxt">
            <%--<p>历史沿革</p>--%>
            <%--<div class="writer">--%>
                <%--<span>发布人：</span>--%>
        				<%--<span>--%>
        					<%--呵呵呵--%>
        				<%--</span>--%>
        				<%--<span>--%>
        					<%--02:58--%>
        				<%--</span>--%>
            <%--</div>--%>
            <%--<div class="muchTxt">--%>
                <%--<p>1923年，东北大学成立</p>--%>
                <%--<p>1923年，东北大学呵呵成立</p>--%>
                <%--<p>1923年，东北年，东北大学呵呵呵呵呵成立</p>--%>
                <%--<p>1923年，东北大学呵北大学成立</p>--%>
                <%--<p>1923年，东北大北大学呵学成立</p>--%>
                <%--<p>1923年，东北年，东北大北大学呵学成立</p>--%>
                <%--<p>19年，东北23年，东北大北大学呵学成立</p>--%>
                <%--<p>1923年，东北大年，东北北大学呵学成立</p>--%>
                <%--<p>1923年，东北大北大学呵学成立</p>--%>
                <%--<p>1923年年，东北，东北大北大年，东北学呵学成立</p>--%>
                <%--<p>1923年，东北大北大学呵学成立</p>--%>
                <%--<p>1923年，东北年，东北大北年，东北大学呵学成立</p>--%>
            <%--</div>--%>
        </div>
    </div>
</div>
<!--脚
-->
<%@include file="common_foot.jsp"%>
</body>
</html>
