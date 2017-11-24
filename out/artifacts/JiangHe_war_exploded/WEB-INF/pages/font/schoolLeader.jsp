<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/12/15
  Time: 9:38
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
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font/css/schoolLeader.css"/>
    <script src="<%=request.getContextPath()%>/asset_font/js/jquery-2.1.0.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/jquery.dotdotdot.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/common.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/respond.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/index.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/CommonlyFunction.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/schoolLeader.js" type="text/javascript" charset="utf-8"></script>
</head>
<script type="text/javascript">
    $(function(){
        $.post("/jsons/statistics.form",{statisticsId:'schoolLeader'},function(){

        })
    });
    $.ajax({
        url:"/jsons/loadNews.form",
        type:"post",
        data:{moduleType:'d6447c13-c037-11e6-9c1a-00ac7dc2f176',rows:5,page:1},
        dataType:"json",
        cache: false,
        success:function(data){
            console.log(data);
            if(data.rows != null){
                for(var i = 0; i < data.rows.length; i++){
                    var row=data.rows[i];
                    //职务位置固定
                    $(".loads").eq(i).attr("src","<%=request.getContextPath()%>/Files/Images/"+row.newsIcon);
                    $(".name").eq(i).text(row.newsTitle+"             "+row.newsClass);
                    $(".hidd").eq(i).text(row.newsId);

                    <%--if(row.newsClass=='党委书记'){--%>
                        <%--$(".load").eq(0).attr("src","<%=request.getContextPath()%>/Files/Images/"+row.newsIcon);--%>
                        <%--$(".name").eq(0).text(row.newsTitle);--%>
                        <%--$(".hidd").eq(0).text(row.newsId);--%>
                    <%--}--%>
                    <%--if(row.newsClass=='执行院长'){--%>
                        <%--$(".load").eq(1).attr("src","<%=request.getContextPath()%>/Files/Images/"+row.newsIcon);--%>
                        <%--$(".name").eq(1).text(row.newsTitle);--%>
                        <%--$(".hidd").eq(1).text(row.newsId);--%>
                    <%--}--%>
                    <%--if(row.newsClass=='副院长'){--%>
                        <%--$(".load").eq(2).attr("src","<%=request.getContextPath()%>/Files/Images/"+row.newsIcon);--%>
                        <%--$(".name").eq(2).text(row.newsTitle);--%>
                        <%--$(".hidd").eq(2).text(row.newsId);--%>
                    <%--}--%>
                    <%--if(row.newsClass=='副书记'){--%>
                        <%--$(".load").eq(3).attr("src","<%=request.getContextPath()%>/Files/Images/"+row.newsIcon);--%>
                        <%--$(".name").eq(3).text(row.newsTitle);--%>
                        <%--$(".hidd").eq(3).text(row.newsId);--%>
                    <%--}--%>
                    <%--if(row.newsClass=='院长助理'){--%>
                        <%--$(".load").eq(4).attr("src","<%=request.getContextPath()%>/Files/Images/"+row.newsIcon);--%>
                        <%--$(".name").eq(4).text(row.newsTitle);--%>
                        <%--$(".hidd").eq(4).text(row.newsId);--%>
                    <%--}--%>
                }
            }
            //点击图片 进入详情页
            $("img").each(function(){
                $(this).click(function(){
                    var text= $(this).parent().parent().children("p").children("span").eq(2).text();
                    window.location.href="detail.form?newsId="+text;
                })

            });
        },
        error:function(){
            layer.alert("服务器连接失败");
        }
    });
</script>
<body>
<!--头
-->
<%@include file="common_head.jsp"%>
<!--身
-->
<div class="sectionBox">
    <div class="section">
        <!--左边
        -->
        <div class="left">
            <ul>
                <li class="first">
                    <div>
                        <a href="javascript:void(0)">学院概况</a>
                    </div>
                    <div>
                        <a href="javascript:history.go(-1);">返回</a>
                    </div>
                </li>
                <li>
                    <div>
                        <a  href="detail.form?newsId=5fa71abe-c1d1-11e6-956b-00ac7dc2f176">历史沿革</a>
                    </div>
                </li>
                <li>
                    <div>
                        <a href="detail.form?newsId=64661991-d32b-11e6-be96-00ac7dc2f176">学院简介</a>
                    </div>
                </li>
                <li class="sele">
                    <div>
                        <a href="/views/font/schoolLeader.form">学院领导</a>
                    </div>
                </li>
                <li>
                    <div>
                        <a href="/views/font/organization.form">组织机构</a>
                    </div>
                </li>
                <li class="last">
                    <div>
                        <a href="detail.form?newsId=ddc77760-c1d1-11e6-956b-00ac7dc2f176">大事记</a>
                    </div>
                </li>
            </ul>
        </div>
        <div class="right">
            <div class="topNav">
	        			<span>
	        				当前位置：
	        			</span>
                <ul>
                    <li>
                        <a href="javascript:void(0)">学院概况</a>
                    </li>
                    <span>></span>
                    <li>
                        <a href="/views/font/schoolLeader.form">学院领导</a>
                    </li>
                </ul>
            </div>
            <div class="leaderPhoto">
                <p>学院领导</p>
                <ul class="first">
                    <li>
                        <div><img class="loads" src="" onerror="onerror=null;" style="cursor: pointer;"/></div>
                        <p>
                            <span class="level"></span>
                            <span class="name"></span>
                            <span class="hidd" style="display: none"></span>
                        </p>
                    </li>
                    <li>
                        <div><img class="loads" src="" onerror="onerror=null;" style="cursor: pointer;"/></div>
                        <p>
                            <span class="level"></span>
                            <span class="name"></span>
                            <span class="hidd" style="display: none"></span>
                        </p>
                    </li>
                </ul>
                <!--上下两排
                -->
                <ul class="secound">
                    <li>
                        <div><img class="loads" src=""  onerror="onerror=null;" style="cursor: pointer;"/></div>
                        <p>
                            <span class="level"></span>
                            <span class="name"></span>
                            <span class="hidd" style="display: none"></span>
                        </p>
                    </li>
                    <li>
                        <div><img class="loads" src="" onerror="onerror=null;"style="cursor: pointer;"/></div>
                        <p>
                            <span class="level"></span>
                            <span class="name"></span>
                            <span class="hidd" style="display: none"></span>
                        </p>
                    </li>
                    <li>
                        <div><img class="loads" src="" onerror="onerror=null;"style="cursor: pointer;"/></div>
                        <p>
                            <span class="level"></span>
                            <span class="name"></span>
                            <span class="hidd" style="display: none"></span>
                        </p>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
<!--脚
-->
<%@include file="common_foot.jsp"%>
</body>
</html>

