<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/12/15
  Time: 9:33
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <!--兼容360浏览器，防止布局乱，设置IE的文档模式为最高版本，并且如果存在chrome插件，自动使用Webkit引擎-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title></title>
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset_font/images/neu.jpg" type="image/x-icon">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font/css/commonAll.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font/css/home.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font/css/common_head.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font/css/common_foot.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font/css/index.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font/css/swiper-3.4.2.min.css"/>
    <script src="<%=request.getContextPath()%>/asset_font/js/jquery-2.1.0.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/jquery.dotdotdot.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/common.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/common_head.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/respond.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/index.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/CommonlyFunction.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/swiper-3.4.2.jquery.min.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">
        $(function(){
            $.post("/jsons/statistics.form",{statisticsId:'index'},function(){
            })
            //修改导航
            navIndex();
            //搜索绑定Enter键
            $("#sqlstr").keyup(function(e){
                if(e.keyCode==13){
                    searchSqlstr();
                }
            });
            $.post("/jsons/loadbackgroud.form",{},function(data){
//                console.log(data.rows);
                if(data.rows&&data.rows.length>0){
                    var str="<li class='first'><img src='<%=request.getContextPath()%>/Files/Images/"+ data.rows[0].img + "'onerror='src=\'/asset_font/images/detailBg_01.png\''/></li>";
                    for(var i=1;i<data.rows.length;i++){
                        var row=data.rows[i];
                        str+="<li><img src='<%=request.getContextPath()%>/Files/Images/"+ row.img + "'onerror='src=\'/asset_font/images/detailBg_01.png\''/></li>"
                    }
                    $("#swiperimage").html(str);
                }
                <%--if(data.rows&&data.rows.length>0){--%>
                    <%--for(var i=0;i<data.rows.length;i++){--%>
                        <%--var row=data.rows[i];--%>
                        <%--$(".banner img").eq(i).attr("src","<%=request.getContextPath()%>/Files/Images/"+row.img);--%>
                    <%--}--%>
                <%--}--%>
            });
            //Lunbo
            var swiper=new Swiper('.swiper-container',{
                autoplay : 5000,
                loop:true,
                autoplayDisableOnInteraction : false,
                pagination:'.swiperpag',
                paginationClickable:true,
            });
            $('.swiper-container').hover(function () {
                swiper.stopAutoplay();
            },function () {
                swiper.startAutoplay();
            });
        });
        function searchSqlstr(){
            var sqlStr=$("#sqlstr").val();
            window.location.href="newsList.form?sqlStr="+sqlStr;
        }
        //跳转到详情页
        function go(val){
            window.location.href="detail.form?newsId="+val;
        }
        //跳转到列表，需要判断有没有3级列表
        function goto(val,value){
            $.ajax({
                url:"/news/checkThirdList.form",
                type:"post",
                data:{moduleType:val},
                dataType:"json",
                success:function(data){
                    if(data.rows&&data.rows.length>0){
                        var parentName=data.rows[0].sysmenu_name;
                        window.location.href="categoryNewsList.form?parentId="+val+"&parentName="+parentName;
                    }else{
                        window.location.href="newsList.form?moduleType="+value;
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
//        function show(num){
////            $(".news").attr("style","display:none");
////            $(".news").eq(num).attr("style","display:''")
////            $('.swiper-slide-active').removeClass('.swiper-slide-active');
////            $('.swiper-slide').eq(num).addClass('swiper-slide-active');
//        }
        function navIndex(){
            $(".home_items>li ul").hover(function () {
                $(this).find("ol").stop(true).slideDown(300);
                $(this).children("a").css({"background":"#952222"})
                $(this).children("a").css("color","#fff");
            }, function () {
                $(this).find("ol").stop(true).slideUp(300);
                $(this).css({"background":"#ccc"})
                $(this).children("a").css({"background":"transparent"})
                $(this).children("a").css("color","#000");
            })
        }
    </script>
    <style>
        ul{
            display: block;
        }
    </style>
</head>
<body>
<div>
<!--头
-->
<div class="header">
    <div class="topbox">
        <div class="header_left">
            <img class="first" src="<%=request.getContextPath()%>/asset_font/img/head_seal.png" />
            <img class="last" src="<%=request.getContextPath()%>/asset_font/img/header_solgan.png" />
        </div>
        <div class="header_right">
            <div>
                <span><input id="sqlstr" type="text" /><i onclick="searchSqlstr()"></i></span>
                <a href="#">英文版</a>
            </div>
        </div>
        <b></b>
    </div>
    <div class="banner" style="height: 325px;">
        <b></b>
        <ul id="swiperimage">
            <%--<li class="first"><img src="" onerror="src='/asset_font/images/detailBg_01.png'"/></li>--%>
            <%--<li><img src="" onerror="src='/asset_font/images/detailBg_02.jpg'"/></li>--%>
            <%--<li><img src="" onerror="src='/asset_font/images/indexBanner_02.png'"/></li>--%>
            <%--<li><img src="" onerror="src='/asset_font/images/detailBg_01.png'"/></li>--%>
            <%--<li><img src="" onerror="src='/asset_font/images/detailBg_01.png'"/></li>--%>
        </ul>
    </div>
</div>
<ul class="home_items">
    <li class="firstli"><div></div><a href="javascript：void(0);"></a></li>
    <li><div></div><ul><a href="/views/font/index.form">首页</a></ul></li>
    <li><div></div><ul><a href="javascript:void(0)">学院概况</a>
        <ol>
            <li><a href="detail.form?newsId=5fa71abe-c1d1-11e6-956b-00ac7dc2f176">历史沿革</a></li>
            <li><a href="detail.form?newsId=64661991-d32b-11e6-be96-00ac7dc2f176">学院简介</a></li>
            <li><a href="/views/font/schoolLeader.form">学院领导</a></li>
            <li><a href="/views/font/organization.form">组织机构</a></li>
            <li><a href="detail.form?newsId=ddc77760-c1d1-11e6-956b-00ac7dc2f176">大事记</a></li>
        </ol></ul>
    </li>
    <li><div></div><ul><a href="/views/font/teachercategorylist.form">师资队伍</a>
        <ol >
            <li><a href="/views/font/teachercategorylist.form">专职教师</a></li>
            <li><a href="/views/font/partteachercategorylist.form?">兼职教师</a></li>
        </ol></ul>
    </li>
    <li><div></div><ul><a href="javascript:void(0)">教育教学</a>
        <ol>
            <li><a href="detail.form?newsId=401ed8ea-0bc1-11e7-9b5e-d8cb8ab8c894">学位分委员会</a></li>
            <li><a href="newsList.form?moduleType=fb3e5125-c04d-11e6-9c1a-00ac7dc2f176">专业概况</a></li>
            <li><a href="categoryNewsList.form?parentId=20d06f13-c04e-11e6-9c1a-00ac7dc2f176&parentName=本科生培养">本科生培养</a></li>
            <li><a href="categoryNewsList.form?parentId=3a38fc2b-c04e-11e6-9c1a-00ac7dc2f176&parentName=研究生培养">研究生培养</a></li>
            <li><a href="newsList.form?moduleType=成绩查询&type=2">成绩查询</a></li>
        </ol></ul>
    </li>
    <li><div></div><ul><a href="javascript:void(0)">学术研究</a>
        <ol>
            <li><a href="detail.form?newsId=b763a2cb-f265-11e6-827e-005056bf3cd7">学术委员会</a></li>
            <li><a href="categoryNewsList.form?parentId=76880a70-c266-11e6-b526-00ac7dc2f176&parentName=研究机构">研究机构</a></li>
            <li><a href="newsList.form?moduleType=8eafd5ae-c04e-11e6-9c1a-00ac7dc2f176">研究项目</a></li>
            <li><a href="newsList.form?moduleType=9aca0083-c04e-11e6-9c1a-00ac7dc2f176">研究成果</a></li>
        </ol></ul>
    </li>
    <li><div></div><ul><a href="javascript:void(0)">党群工作</a>
        <ol>
            <li><a href="newsList.form?moduleType=10ba2215-c10e-11e6-a722-00ac7dc2f176">党委工作</a></li>
            <li><a href="newsList.form?moduleType=172cfc68-c10e-11e6-a722-00ac7dc2f176">工会工作</a></li>
        </ol></ul>
    </li>
    <li><div></div><ul><a href="javascript:void(0)">学生工作</a>
        <ol>
            <li><a href="newsList.form?moduleType=1e18a75a-c10e-11e6-a722-00ac7dc2f176">教育管理</a></li>
            <li><a href="newsList.form?moduleType=2e985dcf-c10e-11e6-a722-00ac7dc2f176">素质拓展</a></li>
            <li><a href="newsList.form?moduleType=399ca065-c10e-11e6-a722-00ac7dc2f176">指导服务</a></li>
            <li><a href="newsList.form?moduleType=信息系统&type=2">信息系统</a></li>
        </ol></ul>
    </li>
    <li><div></div><ul><a href="javascript:void(0)">交流合作</a>
        <ol>
            <li><a href="newsList.form?moduleType=49471ece-c10e-11e6-a722-00ac7dc2f176">国际交流</a></li>
            <li><a href="newsList.form?moduleType=4fdbcf03-c10e-11e6-a722-00ac7dc2f176">国内交流</a></li>
            <li><a href="newsList.form?moduleType=5c725a25-c10e-11e6-a722-00ac7dc2f176">校友交流</a></li>
        </ol></ul>
    </li>
    <li><div></div><ul><a href="javascript:void(0)">下载专区</a>
        <ol>
            <li><a href="newsList.form?moduleType=6920f298-c10e-11e6-a722-00ac7dc2f176&type=1">管理下载</a></li>
            <li><a href="newsList.form?moduleType=78828e95-c10e-11e6-a722-00ac7dc2f176&type=1">学术下载</a></li>
            <li><a href="newsList.form?moduleType=7136725f-c10e-11e6-a722-00ac7dc2f176&type=1">教学下载</a></li>
        </ol></ul>
    </li>
</ul>
<div class="contentNews">
    <div class="menu">
        <img src="<%=request.getContextPath()%>/asset_font/img/linkBg.png" />
        <div>
            <ul class="swiperpag">
                <%--<li><a href="newsList.form?moduleType=e3df07f5-c039-11e6-9c1a-00ac7dc2f176">通知公告</a><i class="inform"></i></li>--%>
                <%--<li><a href="newsList.form?moduleType=f18f1f50-c039-11e6-9c1a-00ac7dc2f176">学院新闻</a><i class="schoolnews"></i></li>--%>
                <%--<li><a href="newsList.form?moduleType=f9f94fe6-c039-11e6-9c1a-00ac7dc2f176">学术活动</a><i class="collegenews"></i></li>--%>
                <%--<li><a href="newsList.form?moduleType=029d3282-c03a-11e6-9c1a-00ac7dc2f176">人才引进</a><i class="getTalents"></i></li>--%>
                <%--<li><a href="categoryNewsList.form?parentId=20d06f13-c04e-11e6-9c1a-00ac7dc2f176&parentName=本科生培养">本科生网</a><i class="undergraduate"></i></li>--%>
                <%--<li><a href="categoryNewsList.form?parentId=3a38fc2b-c04e-11e6-9c1a-00ac7dc2f176&parentName=研究生培养">研究生网</a><i class="graduate"></i></li>--%>
                <%--<li><a>通知公告</a><i class="inform"></i></li>--%>
                <%--<li><a>学院新闻</a><i class="schoolnews"></i></li>--%>
                <%--<li><a>学术活动</a><i class="collegenews"></i></li>--%>
                <%--<li><a>人才引进</a><i class="getTalents"></i></li>--%>
            </ul>
            <a class="swiperdown" href="categoryNewsList.form?parentId=20d06f13-c04e-11e6-9c1a-00ac7dc2f176&parentName=本科生培养">本科生网</a>
            <a class="swiperdown" href="categoryNewsList.form?parentId=3a38fc2b-c04e-11e6-9c1a-00ac7dc2f176&parentName=研究生培养">研究生网</a>
        </div>
    </div>
    <%--<div  class="news">--%>
    <%--<h3>新闻&nbsp;&nbsp;<span>NEWS</span>&nbsp;&nbsp;<i class="news_wifi"></i></h3>--%>
    <%--<ul>--%>
    <%--<c:forEach items="${news_top5}" var="item">--%>
    <%--<li>--%>
    <%--<div class="newsItem">--%>
    <%--<i></i>--%>
    <%--<span><span>${item.createDates}</span> &nbsp;&nbsp;&nbsp;&nbsp;<span style="cursor: pointer" onclick="go('${item.newsId}')"> ${item.newsTitle}</span></span>--%>
    <%--<a href="#" onclick="goto('${item.parentmenuid}','${item.moduleType}')">[更多]</a>--%>
    <%--</div>--%>
    <%--</li>--%>
    <%--</c:forEach>--%>
    <%--</ul>--%>
    <%--</div>--%>
    <div class="box swiper-container">
        <div class="newscontainer swiper-wrapper">
            <div class="news swiper-slide">
                <h3>学院新闻&nbsp;&nbsp;<span>NEWS</span>&nbsp;&nbsp;<i class="news_wifi"></i></h3>
                <ul>
                    <c:forEach items="${collegenewses}" var="item" begin="0" end="4">
                        <li style="cursor: pointer">
                            <div class="newsItem"  >
                                <i></i>
                                <span onclick="go('${item.newsId}')"><span> ${item.newsTitle}</span>&nbsp;&nbsp;&nbsp;&nbsp;<span>${item.newsDate}</span> &nbsp;&nbsp;&nbsp;&nbsp;<span>${item.newsDescribe}</span></span>
                                <a href="#" onclick="go('${item.newsId}')">[详情]</a>
                            </div>
                        </li>
                    </c:forEach>
                    <a class="more" href="newsList.form?moduleType=f18f1f50-c039-11e6-9c1a-00ac7dc2f176">[更多]</a>
                </ul>
            </div>
            <div class="news swiper-slide">
                <h3>通知公告&nbsp;&nbsp;<span id="isnews"></span>&nbsp;&nbsp;<i class="news_wifi"></i></h3>
                <ul>
                    <c:forEach items="${announcementnewses}" var="item" begin="0" end="4">
                        <li style="cursor: pointer">
                            <div class="newsItem">
                                <i></i>
                                <span onclick="go('${item.newsId}')"><span> ${item.newsTitle}</span>&nbsp;&nbsp;&nbsp;&nbsp;<span>${item.newsDate}</span> &nbsp;&nbsp;&nbsp;&nbsp;<span>${item.newsDescribe}</span></span>
                                <a href="#" onclick="go('${item.newsId}')">[详情]</a>
                            </div>
                        </li>
                    </c:forEach>
                    <a class="more" href="newsList.form?moduleType=e3df07f5-c039-11e6-9c1a-00ac7dc2f176">[更多]</a>
                </ul>
            </div>
            <div class="news swiper-slide">
                <h3>学术活动&nbsp;&nbsp;<span></span>&nbsp;&nbsp;<i class="news_wifi"></i></h3>
                <ul>
                    <c:forEach items="${scienceactivitynewses}" var="item" begin="0" end="4">
                        <li style="cursor: pointer">
                            <div class="newsItem" >
                                <i></i>
                                <span onclick="go('${item.newsId}')"><span> ${item.newsTitle}</span>&nbsp;&nbsp;&nbsp;&nbsp;<span>${item.newsDate}</span> &nbsp;&nbsp;&nbsp;&nbsp;<span>${item.newsDescribe}</span></span>
                                <a href="#" onclick="go('${item.newsId}')">[详情]</a>
                            </div>
                        </li>
                    </c:forEach>
                    <a class="more" href="newsList.form?moduleType=f9f94fe6-c039-11e6-9c1a-00ac7dc2f176">[更多]</a>
                </ul>
            </div>
            <div class="news swiper-slide">
                <h3>人才引进&nbsp;&nbsp;<span></span>&nbsp;&nbsp;<i class="news_wifi"></i></h3>
                <ul>
                    <c:forEach items="${talentintroductiones}" var="item" begin="0" end="4">
                        <li style="cursor: pointer">
                            <div class="newsItem">
                                <i></i>
                                <span  onclick="go('${item.newsId}')"><span> ${item.newsTitle}</span>&nbsp;&nbsp;&nbsp;&nbsp;<span>${item.newsDate}</span> &nbsp;&nbsp;&nbsp;&nbsp;<span>${item.newsDescribe}</span></span>
                                <a href="#" onclick="go('${item.newsId}')">[详情]</a>
                            </div>
                        </li>
                    </c:forEach>
                    <a class="more" href="newsList.form?moduleType=029d3282-c03a-11e6-9c1a-00ac7dc2f176">[更多]</a>
                </ul>
            </div>
        </div>
    </div>
</div>
<!--脚
-->
<%@include file="common_foot.jsp"%>
</body>
<script>
    function nav(){
        $(".home_items>li ul").hover(function () {
            $(this).find("ol").stop(true).slideDown(300);
            $(this).css({"background":"#952222"})
            $(this).children("a").css("color","#fff");
        }, function () {
            $(this).find("ol").stop(true).slideUp(300);
            $(this).css({"background":"#ccc"})
            $(this).children("a").css("color","#000");
        })
    }
    nav()
</script>
</html>
