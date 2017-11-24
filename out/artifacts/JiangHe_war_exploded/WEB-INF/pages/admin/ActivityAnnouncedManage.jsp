<%--
  Created by IntelliJ IDEA.
  User: gq
  Date: 2016/12/12
  Time: 15:19
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
        var addUrl = "/jsons/addNews.form";
        var editUrl = "/jsons/editNews.form";
        var deleteUrl = "/jsons/deleteNews.form";
        var editorName = "newsContent";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "newsId";//用于删除功能的ID参数，赋值为当前数据库表的ID
        var parentmenuid='';
        $(function(){
            //加载modelId
            $('#dg').datagrid('options').queryParams={moduleType:moduleType};
            $('#dg').datagrid('options').url='/jsons/loadNews.form';
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
        <th field="newsId" hidden >ID</th>
        <th field="newsTitle" width="100px">标题</th>
        <th field="newsDates" width="100px">日期</th>
        <th field="newsAuthor" width="100px">作者</th>
        <th field="createMan" width="100px">创建人</th>
        <th field="createDates" width="100px">创建日期</th>
        <th field="updateMan" width="100px">更新人</th>
        <th field="updateDates" width="100px">更新日期</th>
    </tr>
    </thead>
</table>
<%--表格头部按钮--%>
<div id="tb" style="height:auto">
    <%--4、第四处修改，修改菜单按钮，选择哪些按钮需要--%>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="Add()">新建</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="Edit()">修改</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="Delete()">删除</a>
    <input class="easyui-searchbox" data-options="prompt:'请输入新闻标题',searcher:doSearch" style="width:200px"/>
</div>
<%--对话框--%>
<div id="dlg" class="easyui-dialog hide" title=""
     style="width:500px;height:500px;padding:10px;"
     data-options="iconCls: 'icon-save',buttons: '#dlg-buttons',modal:true" closed="true" >
    <%--5、第五处修改，修改表单信息，与上面的列名称一致--%>
    <form id="Form">
        <div style="margin-bottom:10px;margin-top: 10px;display: none;">
            <div class="word">newsId:</div>
            <input class="easyui-textbox" name="newsId" id="newsId">
        </div>
        <%--<div id="userphoto_box" style="height: 190px; width: 290px; float: right;background-size:100% 100%;">--%>
            <%--<img id="user_photo"  src="<%=request.getContextPath()%>/asset/image/dangwei.jpg" onerror="onerror=null;src='/asset/image/dangwei.jpg'" style="width: 280px;--%>
                <%--height: 180px;margin-top: 20px">--%>
            <%--<input  id="photo_textbox" name="newsIcon" hidden/>--%>
        <%--</div>--%>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <span class="word"><span style="letter-spacing: 30px">标</span>题:</span>
            <input class="easyui-textbox" data-options="required:true,validType:'length[0,100]'"
                   name="newsTitle" id="newsTitle">
        </div>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <span class="word"><span style="letter-spacing: 30px">日</span>期:</span>
            <input class="easyui-datetimebox" name="newsDate" id="newsDate" data-options="required:true,editable:false" >
        </div>
        <%--<div style="margin-bottom:10px;margin-top: 10px;">--%>
            <%--<span class="word"><span style="letter-spacing: 30px">图</span>片:</span>--%>
            <%--<input  type="file" name="newsicons" id="newsIcon" onchange='preview(this)'/>--%>
        <%--</div>--%>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <span class="word"><span style="letter-spacing: 30px">作</span>者:</span>
            <input class="easyui-textbox" data-options="validType:'length[0,45]'"
                   name="newsAuthor" id="newsAuthor" >
        </div>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <span class="word"><span style="letter-spacing: 30px">描</span>述:</span>
            <input class="easyui-textbox" data-options="multiline:true,validType:'length[0,200]'"
                   name="newsDescribe" id="newsDescribe" style="height: 50px;width: 172px;">
        </div>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <span class="word">是否置顶:</span>
            <label style="margin-left: 10px"><input name="isTop" type="radio" value="是" />是</label>
            <label style="margin-left: 10px"><input name="isTop" type="radio" value="否" />否</label>
        </div>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <span class="word">是否启用:</span>
            <label style="margin-left: 10px"><input name="isDelete" type="radio" value="是" />是</label>
            <label style="margin-left: 10px"><input name="isDelete" type="radio" value="否" />否</label>
        </div>
        <%--<div style="margin-bottom:10px;margin-top: 10px;">--%>
        <%--<span class="word">新闻级别:</span>--%>
        <%--<input class="easyui-textbox" data-options="validType:'length[0,45]'"--%>
        <%--name="newsLevel" id="newsLevel">--%>
        <%--</div>--%>
        <%--<div style="margin-bottom:10px;margin-top: 10px;">--%>
            <%--<span class="word">下载文件:</span>--%>
            <%--<input class="easyui-textbox" data-options="multiline:true,validType:'length[0,2000]'"--%>
                   <%--name="newsFile" id="newsFile" style="height: 80px;width: 172px">--%>
        <%--</div>--%>
    </form>
    <div style="margin-bottom:10px;margin-top: 10px;">
        <div class="word" style="letter-spacing: 3px;">内容:</div>
        <textarea id="newsContent" name="newsContent" style="width:100%;height:300px;"></textarea>
    </div>
</div>
<%--对话框保存、取消按钮--%>
<div id="dlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-ok'" onclick="Save()">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls: 'icon-cancel'" onclick="javascript:$('#dlg').dialog('close')">取消</a>
</div>
</body>
</html>