<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/12/15
  Time: 9:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
"http://www.w3.org/TR/html4/strict.dtd">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!--兼容360浏览器，防止布局乱，设置IE的文档模式为最高版本，并且如果存在chrome插件，自动使用Webkit引擎-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>学生作品展示</title>
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset_font/images/neu.jpg" type="image/x-icon">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font/css/commonAll.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font/css/showStuworks.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font/css/common_head.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font/css/common_foot.css"/>
    <script src="<%=request.getContextPath()%>/asset_font/js/jquery-2.1.0.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/jquery.dotdotdot.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/asset_font/js/showStuworks.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js" ></script>
    <script type="text/javascript">
        var moduleType = GetQueryString("moduleType");
        var totalNUm;
        var page=1;
        var rows=8;
        var type;
        $(function(){
            $.post("/jsons/statistics.form",{statisticsId:'showStuworks'},function(){

            })
        });
        $(function(){
            //向左向右图片的悬事件
            $('.pictures').bind('mousemove', function(e){
                //获取当前图片容器div.pictrues的宽度
                var div_width = $('.pictures').width();
                //获取鼠标在当前div.pictrues的位置
                var mouse_width = e.pageX;
                //当鼠标距离左右两边界都小于200px时，显示向左向右的小图标
                if(mouse_width < 300){
                    $('.pictures .turn_left').stop().fadeIn(600);
                }else if((div_width-mouse_width) < 300){
                    $('.pictures .turn_right').stop().fadeIn(600);
                }else{
                    $('.pictures .turn_left').stop().fadeOut(600);
                    $('.pictures .turn_right').stop().fadeOut(600);
                }
            });
            //隐藏header中的图片
            $(".banner img").hide();
            //加载学生作品 默认无条件加载
            loadMsg("");
        });
        function loadMsg(type1){
            type =type1;
         //   $(".pictures img").attr("src","");
//            $(".imgText").text("文字说明");
            $.ajax({
                url:"/jsons/loadProduction.form",
                type:"post",
                data:{productionClass:type,rows:rows,page:page,moduleType:moduleType},
                dataType:"json",
//                cache: false,
                success:function(data){
                    totalNUm =  data.total;
                    if(data.rows != null){
                        for(var i = 0; i < data.rows.length; i++){
                            var row=data.rows[i];
                            $(".pictures img").eq(i).attr("src","<%=request.getContextPath()%>/Files/Images/"+row.productionLink);
                            $(".imgText").eq(i).text(row.productionName);
                        }
                    }
                },
                error:function(){
                    layer.alert("服务器连接失败");
                }
            });
        }
        function trunleft(){
            var newpage= parseInt($(".currentPageNum").val());
            if(newpage<=1){
                newpage=1;
                $(".currentPageNum").val(1);
                layer.msg("已经到第一页了！");
            }else{
                newpage=newpage-1;
                $(".currentPageNum").val(newpage);
            }
            page=newpage;
            loadMsg();
        }

        function trunright(){
            var newpage= parseInt($(".currentPageNum").val());

            if(newpage>=Math.ceil(totalNUm/rows)){
                newpage=Math.ceil(totalNUm/rows);
                $(".currentPageNum").val(newpage);
                layer.msg("已经到最后一页了！");
            }else{
                newpage=newpage+1;
                $(".currentPageNum").val(newpage);
            }
            page=newpage;
            loadMsg();
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

<div class="workSubject">
    <p>学生作品展示</p>
    <div class="workMsg">
        <div>
            <ul>
                <li onclick="loadMsg('设计')" style="cursor: pointer;"><span>设计作品</span>|<span class="engish">Design works</span></li>
                <li onclick="loadMsg('摄影')" style="cursor: pointer;"><span>摄影</span>|<span class="engish">Photography</span></li>
                <li onclick="loadMsg('绘画')" style="cursor: pointer;"><span>绘画</span>|<span class="engish">Painting</span></li>
                <li onclick="loadMsg('测绘')" style="cursor: pointer;"><span>测绘</span>|<span class="engish">Mapping</span></li>
            </ul>
            <b onclick="loadMsg('摄影')"></b>
            <a onclick="loadMsg('绘画')"></a>
        </div>
    </div>
    <div class="banners">
        <img src="<%=request.getContextPath()%>/asset_font/img/stuworks_banner.jpg" />
    </div>
    <div class="pictures">
        <ol>
            <li>
        <span class="direction turn_left" onclick="trunleft()">
        </span>
        <span class="direction turn_right" onclick="trunright()">
        </span>

				<span class="pictures_left">
					<div class="top imgB">
                        <img src=""  onerror="src='/asset_font/img/stuworks_big1.png'" />
                        <div class="imgText imgText_big imgText_left"></div>
                    </div>
					<div class="bottom">
						<span class="imgB">
							<img src=""  onerror="src='/asset_font/img/stuworks_small3.png'"/>
							<div class="imgText imgText_left"></div>
						</span>
						<span class="img_right img_small imgB">
							<img src=""  onerror="src='/asset_font/img/stuworks_small2.png'" />
							<div class="imgText imgText_right"></div>
						</span>
                    </div>
				</span>
				<span class="pictures_right">
					<div class="top">
						<span class="imgB">
                            <img src=""  onerror="src='/asset_font/img/stuworks_small1.png'"/>
							<div class="imgText imgText_right"></div>
						</span>
						<span class="imgB">
							<img src=""  onerror="src='/asset_font/img/stuworks_small5.png'"/>
							<div class="imgText imgText_right"></div>
						</span>
                    </div>
					<div class="bottom">
						<span class="img_big imgB">
							<img src=""  onerror="src='/asset_font/img/stuworks_bog2.png'" />
							<div class="imgText imgText_big imgText_right"></div>
						</span>
                    </div>
				</span>
                <div class="lastrect">
                    <div class="top">
                                <span class=" imgB">
                                    <img src="" onerror="src='/asset_font/img/stuworks_small1.png'" />
                                    <div class="imgText imgText_right"></div>
                                </span>
                    </div>
                    <div class="bottom">
                                <span id="heightImg" class="img_big imgB">
                                    <img src=""   onerror="src='/asset_font/img/stuworks_long1.png'"/>
                                    <div class="imgText imgText_big imgText_right"></div>
                                </span>
                    </div>
                </div>
            </li>
        </ol>
    </div>
</div>
<!--脚
-->
<%@include file="common_foot.jsp"%>

<!--显示大图片的弹窗-->
<div class="window">
    <div>
        <b>X</b></div>
</div>
<div class="black">

</div>
</body>
</html>

