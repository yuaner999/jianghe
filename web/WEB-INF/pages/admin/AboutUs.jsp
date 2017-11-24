<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/8/17
  Time: 9:25
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
        var moduleType = GetQueryString("moduleType");//所属模块的ID，不可以删除
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
                editor = K.create('#aboutus', options);
                prettyPrint();
        });
            $.ajax({
                url: "/jsons/loadAboutUs.form",
                type: "post",
                datatype: "json",
                success: function (data) {
                    var row = data.rows[0];
                    var abu = row.aboutus;
                    editor.html(abu);
                }
            })
        })
        function Saveabu(){
            var aboutus = editor.html();
            $.ajax({
                url:"/jsons/editAboutUs.form",
                type:"post",
                data:{aboutus:aboutus},
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
</head>
<body>
<div id="Board" style="width: calc(100% - 10px);height: 100%;position: fixed;top: 0;left:0;z-index: 99999;background: #fff;"></div>
    <textarea id="aboutus">
    </textarea>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-ok'" onclick="Saveabu()">保存修改</a>
</body>
</html>
