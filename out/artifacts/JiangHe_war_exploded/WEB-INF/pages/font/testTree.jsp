<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/12/15
  Time: 17:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <!--兼容360浏览器，防止布局乱，设置IE的文档模式为最高版本，并且如果存在chrome插件，自动使用Webkit引擎-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title></title>
    <script src="<%=request.getContextPath()%>/asset_font/js/jquery-2.1.0.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/organizationTree.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset/layer/layer.js" type="text/javascript" charset="utf-8"></script>
    <style type="text/css">
        #test{
            margin:0 auto;
            position:relative;
        }
        .OrgBox{
            position:absolute;
            height: 260px;
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
    </style>
    <script type="text/javascript">
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
            OrgShows.Top=-200;
            OrgShows.Left=0;
            OrgShows.IntervalWidth=60;
            OrgShows.IntervalHeight=60;
            OrgShows.LineSize=1;
            OrgShows.parentBoxId="test";
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
        //重设根元素的样式
        function reSetRootNodeCss(){
            var $node=$("#test>div:first-of-type>div");
            var width=$node.width();
            var height=$node.height();
            $("#test>div:first-of-type>div").css({"width":"235px","height":"45px","font-size":"26px","line-height":"45px","text-align":"center"});
            $("#test>div:first-of-type>div span").css({"width":"235px","height":"45px","font-size":"26px","line-height":"45px","text-align":"center"});
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
<div id="test"></div>
</body>
</html>
<!--测试数据
[{"id":"2c659331-0d1a-11e6-b867-0025b6dd0800","text":"江河建筑学院","parentId":"","children":[{"id":"4c3ac8c8-c290-11e6-b526-00ac7dc2f176","text":"学院机关","parentId":"2c659331-0d1a-11e6-b867-0025b6dd0800","children":[{"id":"f77413fa-c296-11e6-b526-00ac7dc2f176","text":"综合办公室","parentId":"4c3ac8c8-c290-11e6-b526-00ac7dc2f176","children":[]},{"id":"fd1e8917-c296-11e6-b526-00ac7dc2f176","text":"学生工作办公室","parentId":"4c3ac8c8-c290-11e6-b526-00ac7dc2f176","children":[]}]},{"id":"cc63fb12-c279-11e6-b526-00ac7dc2f176","text":"基层学术组织","parentId":"2c659331-0d1a-11e6-b867-0025b6dd0800","children":[{"id":"00a63365-c297-11e6-b526-00ac7dc2f176","text":"建筑系","parentId":"cc63fb12-c279-11e6-b526-00ac7dc2f176","children":[]},{"id":"045104b9-c297-11e6-b526-00ac7dc2f176","text":"城乡规划系","parentId":"cc63fb12-c279-11e6-b526-00ac7dc2f176","children":[]},{"id":"081938cf-c297-11e6-b526-00ac7dc2f176","text":"实验中心","parentId":"cc63fb12-c279-11e6-b526-00ac7dc2f176","children":[]}]},{"id":"ee3fe800-c279-11e6-b526-00ac7dc2f176","text":"科研机构","parentId":"2c659331-0d1a-11e6-b867-0025b6dd0800","children":[{"id":"0b458454-c297-11e6-b526-00ac7dc2f176","text":"东亚城市与建筑研究中心","parentId":"ee3fe800-c279-11e6-b526-00ac7dc2f176","children":[]},{"id":"0e35d086-c297-11e6-b526-00ac7dc2f176","text":"生态城镇与绿色建筑研究中心","parentId":"ee3fe800-c279-11e6-b526-00ac7dc2f176","children":[]}]}]}]
-->