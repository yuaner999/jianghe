<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/12/15
  Time: 9:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font/css/common.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font/css/common_head.css" />
<%--<script src="<%=request.getContextPath()%>/asset_font/js/jquery-2.1.0.js" type="text/javascript" charset="utf-8"></script>--%>
<script src="<%=request.getContextPath()%>/asset_font/js/respond.js" type="text/javascript" charset="utf-8"></script>

<script>
    $(function(){
        //搜索绑定Enter键
        $("#sqlstr").keyup(function(e){
            if(e.keyCode==13){
                searchSqlstr();
            }
        });
    });
    function searchSqlstr(){
        var sqlStr=$("#sqlstr").val();
        window.location.href="newsList.form?sqlStr="+sqlStr;
    }
</script>
<div class="header">
    <div class="topbox">
        <div class="header_left">
            <img class="first" src="<%=request.getContextPath()%>/asset_font/img/head_seal.png" />
            <img class="last" src="<%=request.getContextPath()%>/asset_font/img/header_solgan.png" />
        </div>
        <div class="header_right">
            <div>
                <span><input id="sqlstr" type="text" /><i onclick="searchSqlstr()"></i></span>
                <a>英文版</a>
            </div>
        </div>
        <b></b>
    </div>
    <div class="banner">
        <b></b>
        <ul id="swiperimage">
            <%--<li class="first"><img src="" onerror="src='/asset_font/images/detailBg_01.png'"/></li>--%>
            <%--<li><img src="" onerror="src='/asset_font/images/detailBg_02.jpg'"/></li>--%>
            <%--<li><img src="" onerror="src='/asset_font/images/detailBg_01.png'"/></li>--%>
            <%--<li><img src="" onerror="src='/asset_font/images/detailBg_01.png'"/></li>--%>
            <%--<li><img src="" onerror="src='/asset_font/images/detailBg_01.png'"/></li>--%>
        </ul>
    </div>
</div>
<ul class="home_items">
    <li class="firstli"></li>
    <li><a href="/views/font/index.form">首页</a></li>


    <li><a href="javascript:void(0)">学院概况</a>
        <ol>
            <li><a href="detail.form?newsId=5fa71abe-c1d1-11e6-956b-00ac7dc2f176">历史沿革</a></li>
            <li><a href="detail.form?newsId=64661991-d32b-11e6-be96-00ac7dc2f176">学院简介</a></li>
            <li><a href="/views/font/schoolLeader.form">学院领导</a></li>
            <li><a href="/views/font/organization.form">组织机构</a></li>
            <li><a href="detail.form?newsId=ddc77760-c1d1-11e6-956b-00ac7dc2f176">大事记</a></li>
        </ol>
    </li>
    <li><a href="/views/font/teachercategorylist.form">师资队伍</a>
        <ol>
            <li><a href="/views/font/teachercategorylist.form">专职教师</a></li>
            <li><a href="/views/font/partteachercategorylist.form?">兼职教师</a></li>
        </ol>
    </li>
    <li><a href="javascript:void(0)">教育教学</a>
        <ol>
            <li><a href="detail.form?newsId=401ed8ea-0bc1-11e7-9b5e-d8cb8ab8c894">学位分委员会</a></li>
            <li><a href="newsList.form?moduleType=fb3e5125-c04d-11e6-9c1a-00ac7dc2f176">专业概况</a></li>
            <li><a href="categoryNewsList.form?parentId=20d06f13-c04e-11e6-9c1a-00ac7dc2f176&parentName=本科生培养">本科生培养</a></li>
            <li><a href="categoryNewsList.form?parentId=3a38fc2b-c04e-11e6-9c1a-00ac7dc2f176&parentName=研究生培养">研究生培养</a></li>
            <li><a href="newsList.form?moduleType=成绩查询&type=2">成绩查询</a></li>
        </ol>
    </li>
    <li><a href="javascript:void(0)">学术研究</a>
        <ol>
            <li><a href="detail.form?newsId=b763a2cb-f265-11e6-827e-005056bf3cd7">学术委员会</a></li>
            <li><a href="categoryNewsList.form?parentId=76880a70-c266-11e6-b526-00ac7dc2f176&parentName=研究机构">研究机构</a></li>
            <li><a href="newsList.form?moduleType=8eafd5ae-c04e-11e6-9c1a-00ac7dc2f176">研究项目</a></li>
            <li><a href="newsList.form?moduleType=9aca0083-c04e-11e6-9c1a-00ac7dc2f176">研究成果</a></li>
        </ol>
    </li>
    <li><a href="javascript:void(0)">党群工作</a>
        <ol>
            <li><a href="newsList.form?moduleType=10ba2215-c10e-11e6-a722-00ac7dc2f176">党委工作</a></li>
            <li><a href="newsList.form?moduleType=172cfc68-c10e-11e6-a722-00ac7dc2f176">工会工作</a></li>
        </ol>
    </li>
    <li><a href="javascript:void(0)">学生工作</a>
        <ol>
            <li><a href="newsList.form?moduleType=1e18a75a-c10e-11e6-a722-00ac7dc2f176">教育管理</a></li>
            <li><a href="newsList.form?moduleType=2e985dcf-c10e-11e6-a722-00ac7dc2f176">素质拓展</a></li>
            <li><a href="newsList.form?moduleType=399ca065-c10e-11e6-a722-00ac7dc2f176">指导服务</a></li>
            <li><a href="newsList.form?moduleType=信息系统&type=2">信息系统</a></li>
        </ol>
    </li>
    <li><a href="javascript:void(0)">交流合作</a>
        <ol>
            <li><a href="newsList.form?moduleType=49471ece-c10e-11e6-a722-00ac7dc2f176">国际交流</a></li>
            <li><a href="newsList.form?moduleType=4fdbcf03-c10e-11e6-a722-00ac7dc2f176">国内交流</a></li>
            <li><a href="newsList.form?moduleType=5c725a25-c10e-11e6-a722-00ac7dc2f176">校友交流</a></li>
        </ol>
    </li>
    <li><a href="javascript:void(0)">下载专区</a>
        <ol>
            <li><a href="newsList.form?moduleType=6920f298-c10e-11e6-a722-00ac7dc2f176&type=1">管理下载</a></li>
            <li><a href="newsList.form?moduleType=78828e95-c10e-11e6-a722-00ac7dc2f176&type=1">学术下载</a></li>
            <li><a href="newsList.form?moduleType=7136725f-c10e-11e6-a722-00ac7dc2f176&type=1">教学下载</a></li>
        </ol>
    </li>
</ul>
<script>
    function nav(){
        $(".home_items>li").hover(function () {
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