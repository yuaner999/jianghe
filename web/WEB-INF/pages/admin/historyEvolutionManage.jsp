<%--
  Created by IntelliJ IDEA.
  User: gq
  Date: 2016/12/12
  Time: 15:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <%--引入EasyUi--%>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/easyui/themes/icon.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/manage/massage-helper.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/css/easyui_common.css">
    <%--引入kindereditor--%>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/themes/default/default.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/plugins/code/prettify.css" />
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/kindeditor.js"></script>
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/lang/zh_CN.js"></script>
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/plugins/code/prettify.js"></script>

    <%--引入公共JS--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/manage/managecommon.js"></script>
    <%--<script type="text/javascript" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/KindeditorConfig.js"></script>--%>
    <%--引入图片上传--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/ajaxfileupload.js"></script>
    <script>
        var moduleType = GetQueryString("moduleType");//所属模块的ID
        var editor;
        $(function() {
            $("#Board").fadeOut("slow");
            //调用kindeditor
            KindEditor.ready(function(K) {
                var options = {
                    width : '1280px',
                    height : '800px',
                    allowImageUpload:false,
                    allowFileManager : false,
                    afterBlur: function(){
                        this.sync();
                    }
                }
                editor = K.create('#newsContent', options);
                prettyPrint();
            });
            $.ajax({
                url: "/jsons/loadNews.form",
                type: "post",
                data:{moduleType:moduleType},
                datatype: "json",
                success: function (data) {
                    if(data.total>0){
                        var row = data.rows[0];
                        var newsContent = row.newsContent;
                        var newsId=row.newsId;
                        editor.html(newsContent);
                        $("#newsId").val(newsId);
                    }
                }
            })
        })
        function Saveabu(){
            var newsContent = editor.html();
            var newsId=$("#newsId").val();
            $.ajax({
                url:"/jsons/editsingleNews.form",
                type:"post",
                data:{newsContent:newsContent,newsId:newsId ,isDelete:'是'},
                datatype:"json",
                success:function(data){
                    if(data.result){
                        ShowMsg("修改成功");
                    }else{
                        ShowMsg("修改失败");
                    }
                },
                error:function(){
                    ShowMsg("服务器连接失败");
                }
            })
        }
    </script>
    <%--判断是否是登录状态--%>
    <%@include file="../common/CheckLogin.jsp"%>
</head>
<body>
<div id="Board" style="width: calc(100% - 10px);height: 100%;position: fixed;top: 0;left:0;z-index: 99999;background: #fff;"></div>
<input type="hidden" id="newsId">
    <textarea id="newsContent"  style="width: 100%;height: 700px;">
    </textarea>
<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-ok'" onclick="Saveabu()">保存修改</a>
</body>
</html>