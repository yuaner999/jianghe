<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/12/15
  Time: 9:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<!--兼容360浏览器，防止布局乱，设置IE的文档模式为最高版本，并且如果存在chrome插件，自动使用Webkit引擎-->
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset_font/css/common_foot.css"/>
<script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js" ></script>
<script>
    <%--加载友情链接--%>
    <%--兼容ie9,走ssm--%>
    $(function(){
        $.ajax({
            url:"/jsons/loadLink.form",
            type:"post",
            data:{linkClass:"友情链接"},
            dataType:"json",
            success:function(data){
                if(data.rows.length>0){
                    $("#blogroll").html("");
                    var str="";
                    for(var i=0;i<data.rows.length;i++){
                        var row=data.rows[i];
                        str+= '<li><a href="'+row.linkName+'">'+row.linkContent+'</a></li>'
                    }
                    $("#blogroll").append(str);
                }
            },
            error:function(){
                layer.alert("服务器连接失败");
            }
        });
    })
    function tipsemail(){
        layer.tips('ddjzxy@mail.neu.edu.cn', '.QQ');
    }
    function tipswechat(){
        layer.tips('ddjz_1928', '.weChat');
    }
    function  closetips(){
        layer.closeAll();
    }
</script>
<div class="foot">
    <div>
        <div class="links">
            <h3>友情链接：</h3>
            <ul id="blogroll">
                <%--<li><a href="#">东北大学官网</a></li>--%>
            </ul>
        </div>
        <div class="focus">
            <h3>关注我们：</h3>
            <ul>
                <li><img class="QQ" onmouseover="tipsemail()" onmouseout="closetips()" style="cursor: pointer;width: 47px;height: 41px" src="<%=request.getContextPath()%>/asset_font/img/email.png" /></li>
                <li><img class="weChat" onmouseover="tipswechat()" onmouseout="closetips()" style="cursor: pointer;" src="<%=request.getContextPath()%>/asset_font/img/logo_weChat.png" /></li>
                <%--<li><img class="Persons" style="cursor: pointer;" src="<%=request.getContextPath()%>/asset_font/img/logo_persons.png"/></li>--%>
                <%--<li class="lastImg"><img class="WIFI" style="cursor: pointer;" src="<%=request.getContextPath()%>/asset_font/img/logo_wifi.png" /></li>--%>
            </ul>
        </div>
    </div>
</div>
<p class="line"></p>
<div class="tail">
    <p>
        <span>@2016  东北大学江河建筑学院 版权所有。</span>
        <span><i></i>|<i></i>地址：辽宁省沈阳市浑南新区创新路195号</span>
        <i></i>
        <span>电话：024-8888888</span>
        <i></i>
        <span>邮箱：999999999@163.com</span>
    </p>
</div>
