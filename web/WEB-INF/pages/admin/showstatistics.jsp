<%--
  Created by IntelliJ IDEA.
  User: gq
  Date: 2016/12/12
  Time: 15:15
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
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/KindeditorConfig.js"></script>
    <%--引入图片上传--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/ajaxfileupload.js"></script>
    <script>
        var moduleType = GetQueryString("moduleType");//所属模块的ID
        //1、第一处修改，修改增删改的请求地址
        var addUrl = "";
        var editUrl = "";
        var deleteUrl = "";
        var editorName = "null";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "";//用于删除功能的ID参数，赋值为当前数据库表的ID
        var parentmenuid='';
        $(function(){
            //加载modelId
            $('#dg').datagrid('options').queryParams={};
            $('#dg').datagrid('options').url='/jsons/loadStatistics.form';
            $('#dg').datagrid('reload');

        });
    </script>
    <%--判断是否是登录状态--%>
    <%@include file="../common/CheckLogin.jsp"%>
</head>
<body>
<%--数据表格--%>
<table id="dg" class="easyui-datagrid" style="width:100%;min-height:556px;max-height: 100%;"
       data-options="pagination:true,
               rownumbers:true,
               singleSelect:true,
               method:'post',
               autoRowHeight:false,
               toolbar:'#tb',
               fitColumns:true,
               queryParams:{},
               <%--2、第二处修改，修改此处的Json服务，用于加载数据--%>
               url:''">
    <thead>
    <tr>
        <%--3、第三处修改，修改此处的列名称，与数据库一致，显示有必要的--%>
        <th field="statisticsId" hidden >页面ID</th>
        <th field="statisticsName" width="100px">中文名称</th>
        <th field="count" width="100px">访问次数</th>
    </tr>
    </thead>
</table>
</body>
</html>
