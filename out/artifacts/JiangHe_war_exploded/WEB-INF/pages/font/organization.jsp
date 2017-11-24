<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/12/15
  Time: 9:42
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
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font/css/organization.css"/>
    <script src="<%=request.getContextPath()%>/asset_font/js/jquery-2.1.0.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/jquery.dotdotdot.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/common.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/respond.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/index.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/CommonlyFunction.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/organization.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/organizationTree.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset/layer/layer.js" type="text/javascript" charset="utf-8"></script>
    <style type="text/css">
        #orgBox{
            /*border:#ff0000 solid 1px;*/
            /*width: 700px;*/
            /*height: 800px;*/
            margin:0 auto;
            position:relative;
        }
        .OrgBox{
            position:absolute;
            /*height: 260px;*/
            line-height: 260px;
            font-size: 22px;
            color: #fff;
            background: #848383;
            border: 1px solid #000;
            width: 45px;
            text-align: center;
            margin: 0 auto;
            padding: 5px 0;
        }
        .OrgBox span{
            vertical-align: middle;
            display: inline-block;
            line-height: 26px;
            width: 38px;
        }
        .section{
            width: 83%;
        }
    </style>
    <script type="text/javascript">
        $(function(){
            $.post("/jsons/statistics.form",{statisticsId:'organization'},function(){

            })
        });
        $(function(){
            getData();
        });
        function getData(){
            $.ajax({
                url: "/organization/getParentMenu.form",
                type: "post",
                dataTye: "json",
                success: function (data) {
                    if (data != null && data.length > 0) {
                        genner(data);
                    } else {
                        layer.msg("未查询到相关数据");
                    }
                },
                error: function () {
                    layer.msg("服务器连接失败，请稍后再试");
                }
            });
        }
        //生成组织结构图入口
        function genner(data){
            var root=gennerChild(data[0]);
            var OrgShows=new OrgShow(root);
            OrgShows.Top=-160;
            OrgShows.Left=20;
            OrgShows.IntervalWidth=60;
            OrgShows.IntervalHeight=60;
            OrgShows.LineSize=1;
            OrgShows.parentBoxId="orgBox";
            OrgShows.BoxTemplet="<div id=\"{Id}\" class=\"OrgBox\"><span>{Name}</span></div>";
            OrgShows.Run();
            reSetRootNodeCss();
        }
        //组织结构图内部的生成方法
        function gennerChild(child){
            var note=new OrgNode();
            note.customParam.Name=child.text;
//            note.Id=child.id;
            var childs=child.children;
            if(childs!=null && childs.length>0) {
                for (var i = 0; i < childs.length; i++) {
                    var childEle = gennerChild(childs[i]);
                    note.Nodes.Add(childEle);
                }
            }
            return note;
        }
        function reSetRootNodeCss(){
            var $node=$("#orgBox>div:first-of-type>div");
            var width=$node.width();
            var height=$node.height();
            $("#orgBox>div:first-of-type>div").css({"width":"235px","height":"45px","font-size":"26px","line-height":"45px","text-align":"center"});
            $("#orgBox>div:first-of-type>div span").css({"width":"235px","height":"45px","font-size":"26px","line-height":"24px","text-align":"center"});
            var width2=$node.width();
            var height2=$node.height();
            var top=$node.css("top");
            var left=$node.css("left");
            var top_n=height-height2+(parseInt(top.replace("px","")));
            var left_n=(parseInt(left.replace("px","")))-(width2/2-width/2);
            $node.css({"top":top_n+"px","left":left_n+"px"});
        }
    </script>
</head>
<body>
<!--头
-->
<%@include file="common_head.jsp"%>
<!--身
-->
<div class="section_box">
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
                <li>
                    <div>
                        <a href="/views/font/schoolLeader.form">学院领导</a>
                    </div>
                </li>
                <li class="sele">
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
                        <a href="/views/font/organization.form">组织机构</a>
                    </li>
                </ul>
            </div>
            <!--
                作者：neunavylws@139.com
                时间：2016-12-13
                描述：组织结构图
            -->
            <div class="organization">
                <%--<p>组织机构</p>--%>
                <div id="orgBox"></div>
            </div>
        </div>
    </div>
</div>
<div style="clear: both;"></div>
<!--脚
-->
<%@include file="common_foot.jsp"%>
</body>
</html>

