<%--
  Created by IntelliJ IDEA.
  User: shaowen
  Date: 2016/8/25
  Time: 11:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>友情链接的创建与修改</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/easyui/themes/icon.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/manage/massage-helper.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/css/easyui_common.css">

    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/themes/default/default.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/plugins/code/prettify.css"/>
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/kindeditor.js"></script>
    <script charset="utf-8" src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/lang/zh_CN.js"></script>
    <script charset="utf-8"
            src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/plugins/code/prettify.js"></script>

    <%--引入公共JS--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/manage/managecommon.js"></script>
    <script type="text/javascript"
            src="<%=request.getContextPath()%>/asset/kindeditor-4.1.10/KindeditorConfig.js"></script>
    <script>
        var moduleType = GetQueryString("moduleType");//所属模块的ID，不可以删除
        //1、第一处修改，修改增删改的请求地址
        var addUrl = "/jsons/addLink.form";
        var editUrl = "/jsons/updateLink.form";
        var deleteUrl = "/jsons/deleteLink.form";
        var editorName = "null";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "linkId";//用于删除功能的ID参数，赋值为当前数据库表的ID
        var flag=false;
        $(function(){
            $("#Board").fadeOut("slow");
            $('#dg').datagrid('options').queryParams={linkClass:"成绩查询"};
            $('#dg').datagrid('options').url='/jsons/loadLink.form';
            $('#dg').datagrid('reload');
        });
        //保存
        function Save() {
            if ($("#Form").form('validate')) {
                var jsonObject = $("#Form").serializeObject();
                jsonObject["moduleType"] = moduleType;
                jsonObject["linkClass"] = "成绩查询";
                load();
                UploadToDatabase(jsonObject);
            }
        }
    </script>
    <style>
        .datagrid-body {
            overflow: hidden;
        }
    </style>
</head>
<body>
<div id="Board" style="width: calc(100% - 10px);height: 100%;position: fixed;top: 0;left:0;z-index: 99999;background: #fff;"></div>
<%--数据表格--%>
<table id="dg" class="easyui-datagrid" style="width:100%;height: 100%;"
       data-options="pagination:true,
               rownumbers:true,
               singleSelect:true,
               method:'post',
               autoRowHeight:false,
               toolbar:'#tb',
               fitColumns:true,
               <%--2、第二处修改，修改此处的Json服务，用于加载数据--%>
               url:''">
    <thead>
    <tr>
        <%--3、第三处修改，修改此处的列名称，与数据库一致，显示有必要的--%>
        <th field="linkName" style="width: 40%" >成绩单地址</th>
        <th field="linkContent" style="width: 30%" >成绩单名称</th>
        <th field="updatetime" style="width: 30%" >更新的时间</th>
    </tr>
    </thead>
</table>
<%--表格头部按钮--%>
<div id="tb" style="height:auto">
    <%--4、第四处修改，修改菜单按钮，选择哪些按钮需要--%>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="Add();">新建</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="Edit();">修改</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="Delete()">删除</a>
</div>
<%--对话框--%>
<div id="dlg" class="easyui-dialog hide" title=""
     style="width:500px;height:300px;padding:10px;"
     data-options="iconCls: 'icon-save',buttons: '#dlg-buttons',modal:true" closed="true" >
    <%--5、第五处修改，修改表单信息，与上面的列名称一致--%>
    <form id="Form">
        <div style="margin-bottom:10px;margin-top: 10px;" id="parent_div" hidden>
            <input  class="easyui-textbox" name="linkId" id="linkId">
        </div>
        <div style="margin-bottom:10px;margin-top: 10px;text-align:right;margin-right: 100px">
            <span class="word">成绩单地址</span>
            <input class="easyui-textbox"  name="linkName" id="linkName"data-options="required:true,validType:'length[1,500]'"
                   style="width:200px;height:32px">
        </div>
        <div style="margin-bottom:10px;margin-top: 10px;text-align:right;margin-right: 100px">
            <span class="word">成绩单名称</span>
            <input class="easyui-textbox"  name="linkContent" id="linkContent" data-options="required:true,validType:'length[1,20]'"
                   style="width:200px;height:32px">
        </div>
    </form>
</div>
<%--对话框保存、取消按钮--%>
<div id="dlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-ok'" onclick="Save()">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-cancel'" onclick="javascript:$('#dlg').dialog('close')">取消</a>
</div>

</body>
</html>
