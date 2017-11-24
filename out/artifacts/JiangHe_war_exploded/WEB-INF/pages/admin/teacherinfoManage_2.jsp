<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/12/12
  Time: 14:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>教师管理页面</title>
    <%--引入EasyUi--%>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/easyui/themes/icon.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/manage/massage-helper.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/css/easyui_common.css">
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
        var imageUpload = "newsIcon";//图片上传的标识，如果没有图片上传，赋值为空，如果有，赋值为数据库存放图片名称的字段名称，不带_
        var deleteId = "newsId";//用于删除功能的ID参数，赋值为当前数据库表的ID
        var parentmenuid='';
        $(function(){
            //加载modelId
            $('#dg').datagrid('options').queryParams={newsClass:"兼职教师"};
            $('#dg').datagrid('options').url='/jsons/loadTeacher.form';
            $('#dg').datagrid('reload');

        });
        //保存
        function Save(){
            if($("#Form").form('validate')){
                var jsonObject = $("#Form").serializeObject();
                jsonObject["moduleType"] = moduleType;
                jsonObject["isDelete"] = "是";
                jsonObject["isTop"] = "是";
                jsonObject["newsDescribe"] = "已通过";
                jsonObject["newsClass"] = "兼职教师";
                if(editorName &&editorName!="null"){
                    editor.sync();
                    jsonObject[editorName] = $("#"+editorName).val();
                }
                load();
                if(imageUpload==null||imageUpload==""){//如果没有图片上传
                    if(!fileUpload){//如果没有文件上传
                        UploadToDatabase(jsonObject);
                    }else {//有文件上传
                        if($("#"+fileUpload).val()!=null&&$("#"+fileUpload).val()!=""){
                            ajaxFileUpload("/FileUpload/No_Intercept_Upload.form",fileUpload,jsonObject,2);
                        }else {
                            UploadToDatabase(jsonObject);
                        }
                    }
                }else {//有图片上传
                    if($("#"+imageUpload).val()!=null&&$("#"+imageUpload).val()!=""){
                        ajaxFileUpload("/ImageUpload/No_Intercept_Upload.form",imageUpload,jsonObject,1);
                    }else {
                        if(!fileUpload){//如果没有文件上传
                            UploadToDatabase(jsonObject);
                        }else {//有文件上传
                            if($("#"+fileUpload).val()!=null&&$("#"+fileUpload).val()!=""){
                                ajaxFileUpload("/FileUpload/No_Intercept_Upload.form",fileUpload,jsonObject,2);
                            }else {
                                UploadToDatabase(jsonObject);
                            }
                        }
                    }
                }
            }else {
                ShowMsg("请按照要求填写");
            }
        }
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
        <th field="newsTitle" width="100px">名字</th>
        <th field="newsDates" width="100px">日期</th>
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
    <input class="easyui-searchbox" data-options="prompt:'请输入标题',searcher:doSearch" style="width:200px"/>
</div>
<%--对话框--%>
<div id="dlg" class="easyui-dialog hide" title=""
     style="width:620px;height:550px;padding:10px;"
     data-options="iconCls: 'icon-save',buttons: '#dlg-buttons',modal:true" closed="true" >
    <%--5、第五处修改，修改表单信息，与上面的列名称一致--%>
    <form id="Form">
        <div style="margin-bottom:10px;margin-top: 10px;display: none;">
            <div class="word">newsId:</div>
            <input class="easyui-textbox" name="newsId" id="newsId">
        </div>
        <%--<div id="userphoto_box" style="height: 250px; width: 200px; float: right;background-size:100% 100%;">--%>
            <%--<img id="user_photo"  src="<%=request.getContextPath()%>/asset/image/default.jpg" onerror="onerror=null;src='<%=request.getContextPath()%>/asset/image/default.jpg'" style="width: 160px;--%>
                <%--height: 210px;margin-right: 50px;margin-top: 20px">--%>
            <%--<input  id="photo_textbox" name="newsIcon" hidden/>--%>
        <%--</div>--%>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <span class="word"><span style="letter-spacing: 30px">名</span>字:</span>
            <input class="easyui-textbox" data-options="required:true,validType:'length[0,100]'"
                   name="newsTitle" id="newsTitle">
        </div>
        <div style="margin-bottom:10px;margin-top: 10px;" hidden>
            <span class="word"><span style="letter-spacing: 30px">分</span>类:</span>
            <select class="easyui-combobox" name="newsClass" id="newsClass"
                    data-options="required:false,editable:false,panelHeight:'auto'" style="width:175px;!important;height:22px;!important;" >
                <option value="专职教师">专职教师</option>
                <option value="兼职教师">兼职教师</option>
            </select>
        </div>
        <div style="margin-bottom:10px;margin-top: 10px;">
            <span class="word"><span style="letter-spacing: 30px">日</span>期:</span>
            <input class="easyui-datebox" name="newsDate" id="newsDate" data-options="required:true,editable:false" >
        </div>
        <%--<div style="margin-bottom:10px;margin-top: 10px;">--%>
            <%--<span class="word"><span style="letter-spacing: 30px">图</span>片:</span>--%>
            <%--<input  type="file" name="newsicons" id="newsIcon" onchange='preview(this)'/>--%>
        <%--</div>--%>
    </form>
    <div style="margin-bottom:10px;margin-top: 10px;">
        <span class="word"><span style="letter-spacing: 30px">内</span>容:</span>
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