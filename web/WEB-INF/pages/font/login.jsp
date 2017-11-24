<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/12/15
  Time: 9:33
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
"http://www.w3.org/TR/html4/strict.dtd">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<!--兼容360浏览器，防止布局乱，设置IE的文档模式为最高版本，并且如果存在chrome插件，自动使用Webkit引擎-->
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title>江河建筑学院登陆界面</title>
		<link rel="Shortcut Icon" href="<%=request.getContextPath()%>/asset_font/images/neu.jpg" type="image/x-icon">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font/css/commonAll.css"/>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font/css/login.css"/>
		<script src="<%=request.getContextPath()%>/asset_font/js/login.js" type="text/javascript" charset="utf-8"></script>
		<script src="<%=request.getContextPath()%>/asset_font/js/jquery-2.1.0.js" type="text/javascript" charset="utf-8"></script>

		<script type="text/javascript">
			var url=location.href.split('#')[0];
			var index=url.indexOf("/views");
			var domainName=url.substring(0,index);
			$(function(){
				$("#cn_page").click(function(){
					window.location=domainName+'/views/font/index.form';
				});
				/*$("#en_page").click(function(){
					window.location='/views/font/index.form';
				})*/
			})
			$(function(){
				$.post("/jsons/statistics.form",{statisticsId:'login'},function(){

				})
			});
		</script>
	</head>
	<body>
		<div class="content">
			<div>
				<div class="banner">
					<div class="bg">
						<img src="<%=request.getContextPath()%>/asset_font/img/login_bg.png" />
					</div>
					<div class="logo">
						<img src="<%=request.getContextPath()%>/asset_font/img/login_title.png" />
						<p>
							<span id="cn_page">中文版</span>
							<span id="en_page">ENGLISH</span>
						</p>
					</div>
				</div>
				<p class="bottom_title">copyright 2015(c) 东北大学江河建筑学院 all rights reserved.</p>
			</div>
		</div>
	</body>
</html>
