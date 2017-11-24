<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/12/15
  Time: 9:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <!--兼容360浏览器，防止布局乱，设置IE的文档模式为最高版本，并且如果存在chrome插件，自动使用Webkit引擎-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title></title>
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset/image/neu.jpg" type="image/x-icon">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font/css/common_head.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font/css/common_foot.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font/css/newsList.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font/css/categoryNewsList.css"/>
    <script src="<%=request.getContextPath()%>/asset_font/js/jquery-2.1.0.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/jquery.dotdotdot.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/common.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/respond.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/index.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/CommonlyFunction.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/newsList.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">
        //获取所属模块id
        var parentId = GetQueryString("parentId");
        //获取所属模块名称
        var parentName = GetQueryString("parentName");
        $(function(){
            $.post("/jsons/statistics.form",{statisticsId:'categoryNewsList'},function(){

            })
        });
        $(function(){
            //隐藏header中的图片
            $(".banner img").hide();
            parentName=parentName.replace("管理","");
           $("#parentName").text(parentName);
            //加载二级菜单名字
            $.ajax({
                url:"/news/loadSecondFloorMenu.form",
                type:"post",
                data:{parentId:parentId},
                async:false,
                dataType:"json",
                success:function(data){
                    if(data.rows&&data.rows.length>0){
                        var str='';
                        $('.newsList').html('');
                        for(var i=0;i<data.rows.length;i++) {
                            var tName=data.rows[i].sysmenu_name;
                            tName=tName.replace("管理","");
                            str = '<ul class="ul' + i + '">'+
                                    '<span>'+tName+'</span></ul>';
                            $('.newsList').append(str);
                            var str1='';
                            //加载3级列表数据
                            if (tName.indexOf("优秀作业")>=0){
                                str1='<li>'+
                                        '<a href="showStuworks.form?moduleType='+data.rows[i].sysmenu_id+'">'+
                                        '<div></div>'+
                                        '<span></span>'+
                                        '<b></b>'+
                                        '<span>点击进入学生作品页</span>'+
                                        '</a>'+
                                        '</li>';
                                console.log(i+str1)
                                $(".ul"+i).append(str1);
                            }else {
                                var parentId=data.rows[i].sysmenu_id;
                                $.ajax({
                                    url:"/news/loadAllNews.form",
                                    type:"post",
                                    data:{moduleType:parentId},
                                    dataType:"json",
                                    async:false,
                                    success:function(data){
                                        var str1='';
                                        if(data.rows&&data.rows.length>0){
                                            for(var j=0;j<data.rows.length;j++){
                                                str1='<li>'+
                                                        '<a href="detail.form?newsId='+data.rows[j].newsId+'">'+
                                                        '<div></div>'+
                                                        '<span>'+data.rows[j].createDates+'</span>'+
                                                        '<b>'+data.rows[j].newsTitle+'</b>'+
                                                        '<span>'+data.rows[j].newsDescribe+'</span>'+
                                                        '</a>'+
                                                        '</li>';
                                                console.log(i+str1)
                                                $(".ul"+i).append(str1);
                                            }
                                        }
                                    }
                                });
                            }
                            var str2='<div><a href="newsList.form?moduleType='+data.rows[i].sysmenu_id+'">[更多]</a></div>';
                            $(".ul"+i).append(str2);
                        }
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
        //获取URL参数
        function GetQueryString(name)
        {
            var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if(r!=null)return  decodeURI(r[2]); return null;
        }
        //跳转到详情页
        function go(val){
            window.location.href="newsList.form?moduleType="+val;
        }
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
            <img class="load" src="<%=request.getContextPath()%>/asset_font/images/img1_07.png" onerror="onerror=null;src='/asset_font/images/img1_07.png'" onclick="go('e3df07f5-c039-11e6-9c1a-00ac7dc2f176')"/>
        </li>
        <li>
            <img class="load" src="<%=request.getContextPath()%>/asset_font/images/img2_07.png" onerror="onerror=null;src='/asset_font/images/img2_07.png'" onclick="go('f18f1f50-c039-11e6-9c1a-00ac7dc2f176')"/>
        </li>
        <li>
            <img class="load" src="<%=request.getContextPath()%>/asset_font/images/img3_07.png" onerror="onerror=null;src='/asset_font/images/img3_07.png'" onclick="go('f9f94fe6-c039-11e6-9c1a-00ac7dc2f176')" />
        </li>
        <a href="newsList.form">
            [更多]
        </a>
    </ul>
    <!--新闻区
    -->
    <div class="news_box">
        <div class="news">
            <p>
                <span id="parentName">新闻</span><span>NEWS</span>
                <img src="<%=request.getContextPath()%>/asset_font/images/imgsound_11.png" />
            </p>
            <!--新闻列表
                    -->
            <div class="newsList">
                <%--<ul>--%>
							<%--<span>--%>
								<%--管理--%>
							<%--</span>--%>
                    <%--<li>--%>
                        <%--<a href="">--%>
                            <%--<div></div>--%>
                            <%--<span>[2016-07-15]</span>--%>
                            <%--<b>dasdnf递归哈哈哈</b>--%>
                            <%--<span>的说法发的什么撒地方了按，萨达 大师傅打算 阿斯蒂芬啊 但是打发阿斯蒂芬水电费但是个但是水电费的个但是</span>--%>
                        <%--</a>--%>
                    <%--</li>--%>
                    <%--<li>--%>
                        <%--<a href="">--%>
                            <%--<div></div>--%>
                            <%--<span>[2016-07-15]</span>--%>
                            <%--<b>dasdnf递归哈哈哈</b>--%>
                            <%--<span>的说法发的什么撒地方了按，萨达 大师傅打算 阿斯蒂芬啊 但是打发阿斯蒂芬水电费但是个但是水电费的个但是</span>--%>
                        <%--</a>--%>
                    <%--</li>--%>
                    <%--<li>--%>
                        <%--<a href="">--%>
                            <%--<div></div>--%>
                            <%--<span>[2016-07-15]</span>--%>
                            <%--<b>dasdnf递归哈哈哈</b>--%>
                            <%--<span>的说法发的什么撒地方了按，萨达 大师傅打算 阿斯蒂芬啊 但是打发阿斯蒂芬水电费但是个但是水电费的个但是</span>--%>
                        <%--</a>--%>
                    <%--</li>--%>
                    <%--<div>--%>
                        <%--<a href="">[更多]</a>--%>
                    <%--</div>--%>
                <%--</ul>--%>
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
                    <a href="newsList.form?moduleType=e3df07f5-c039-11e6-9c1a-00ac7dc2f176">
                        <span>通知公告</span>
                        <b></b>
                    </a>
                </li>
                <li>
                    <a href="newsList.form?moduleType=f18f1f50-c039-11e6-9c1a-00ac7dc2f176">
                        <span>学院新闻</span>
                        <b></b>
                    </a>
                </li>
                <li>
                    <a href="newsList.form?moduleType=f9f94fe6-c039-11e6-9c1a-00ac7dc2f176">
                        <span>学术活动</span>
                        <b></b>
                    </a>
                </li>
                <li>
                    <a href="newsList.form?moduleType=0841f577-c03a-11e6-9c1a-00ac7dc2f176">
                        <span>学科建设</span>
                        <b></b>
                    </a>
                </li>
                <li>
                    <a href="newsList.form?moduleType=029d3282-c03a-11e6-9c1a-00ac7dc2f176">
                        <span>人才引进</span>
                        <b></b>
                    </a>
                </li>
                <li class="last">
                    <a href="newsList.form?moduleType=0f455850-c03a-11e6-9c1a-00ac7dc2f176">
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

