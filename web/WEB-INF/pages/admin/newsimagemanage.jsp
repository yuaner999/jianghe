<%--
  Created by IntelliJ IDEA.
  User: shaowen
  Date: 2016/12/16
  Time: 17:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!--兼容360浏览器，防止布局乱-->
    <meta http-equiv=X-UA-Compatible content="IE=edge,chrome=1">
    <title>新闻图片管理</title>
    <meta charset="UTF-8">
    <meta http-equiv="content-type" content="text/html;charset=UTF-8"/>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery-1.8.3.min.js"></script>
    <!--使用Cookie-->
    <script type="text/javascript" src="${pageContext.request.contextPath}/asset/js/JSCookie.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/asset/js/FromSerialize.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/asset/layer/layer.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/ajaxfileupload.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/manage/managecommon.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/css/easyui_common.css">
    <%--引入EasyUi--%>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/easyui/themes/icon.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript"
            src="<%=request.getContextPath()%>/asset/easyui/locale/easyui-lang-zh_CN.js"></script>
    <%--引入公共JS--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/manage/massage-helper.js"></script>

    <script>
        var moduleType = GetQueryString("moduleType");
        var editorName = "null";//KindEditor的Textarea的ID，如果没用到，赋值为null
        var imageUpload = "file_upload_input";
        $(function () {
            $("#Board").fadeOut("slow");
            $("#fontindexconfig_list").datagrid({
                url: "/jsons/loadNewsimg.form",
                method: 'post',
                toolbar: '#toolbar',
                rownumbers: true,
                singleSelect:true,
                idField: 'id',
                loadMsg: "正在拼命加载中。。",
                fitcolumns:true,
                columns: [
                    [
                        {field: 'id', title: '', hidden: true},
                        {field: 'imgName', title: '图片名字'},
                        {field: 'imgSort', title: '图片位置'},
                        {field: 'imgLink', title: '预览图',
                            formatter:function(value){
                                return "<img style='width: 100px;height:50px;' src='/Files/Images/"+value+"'>";
                            }
                        },
                        {field: 'updatetime', title: '更新日期'}
                    ]
                ]
            });
        });
        //修改
        function update_item() {
            var row=$("#fontindexconfig_list").datagrid("getSelected");
            if(!row){
                ShowMsg("请选择要修改的数据!");
                return;
            }
            $(".preview_div").attr("src","/Files/Images/"+row.imgLink);
            $('#dlg').dialog({
                title: '修改',
                buttons: '#dlg-buttons',
                closed: true,
                resizable: true,
                modal: true,
                onResize: function () {
                    $(this).dialog('center');
                }
            }).dialog('open');
        }

        //保存
        function SaveItem() {
            var row=$("#fontindexconfig_list").datagrid("getSelected");
            if(!row){
                ShowMsg("请选择要修改的数据!");
                return;
            }
//            var index = layer.load(1, {
//                shade: [0.1,'#000'] //0.1透明度的白色背景
//            });
            var jsonObject = $("#Form").serializeObject();
            jsonObject.id=row.id;
            jsonObject.imgLink=$("#file_upload_input").val();
            jsonObject.imgSort=row.imgSort;
            if($("#file_upload_input").val()!=null&&$("#file_upload_input").val()!=""){
                ajaxFileUpload("/ImageUpload/No_Intercept_Upload.form",imageUpload,jsonObject,2);
            }else {
                UploadToDatabase(jsonObject);
            }

        }
        //预览图片
        function preview(file) {
            var prevDiv = $(".preview_div");
            if (file.files && file.files[0])
            {
                var reader = new FileReader();
                reader.onload = function(evt){
                    prevDiv.html('<img style="width: 300px; height: 140px;" src="' + evt.target.result + '" />');
                }
                reader.readAsDataURL(file.files[0]);
            }
            else
            {
                prevDiv.html('<div class="img" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src=\'' + file.value + '\'"></div>');
            }
        }
        //图片的上传
        function ajaxFileUpload(url,id,jsonObject,time){
            $.ajaxFileUpload({
                url: url, //用于文件上传的服务器端请求地址
                secureuri: false, //一般设置为false
                fileElementId: id, //文件上传空间的id属性
                dataType: 'String', //返回值类型 一般设置为String
                success: function (data, status)  //服务器成功响应处理函数
                {
                    if(data!=""||data!=null){
                        var data = eval("(" + data + ")");
                        if(typeof(data.error) != 'undefined') {
                            if (data.error == 0) {
                                jsonObject.imgLink = data.filename;
                                UploadToDatabase(jsonObject);

                            } else {
                                layer.msg("上传文件出错："+data.message);
                                disLoad();
                            }
                        }else{
                            layer.msg("上传文件出错："+data.message);
                            disLoad();
                        }
                    }else {
                        layer.msg("保存文件失败，请重新上传");
                        disLoad();
                    }
                },
                error: function (data, status, e)//服务器响应失败处理函数
                {
                    layer.msg("上传文件失败，请重新上传");
                    disLoad();
                }
            });
        }
        //上传数据到数据库
        function UploadToDatabase(jsonObject) {
            $.ajax({
                url: "/jsons/updateNewsimg.form",
                type: "post",
                dataType: "json",
                async: false,
                data:{
                    "imgLink": jsonObject.imgLink,
                    "id":jsonObject.id
                },
                success: function (data) {
                    disLoad();
                    if (data.result) {
                        ShowMsg("修改成功！");
                        reload();
                        $('#dlg').dialog("close");
                        layer.closeAll();
                    }
                },
                error:function(){
                    ShowMsg("服务器连接失败");
                    layer.closeAll();
                }
            });

        }
        //刷新
        function reload(){
            $("#fontindexconfig_list").datagrid('reload', { datetime: encodeURI("" + new Date().toString()) });
        }
        //序列化
        $.fn.serializeObject = function()
        {
            var o = {};
            var a = this.serializeArray();
            $.each(a, function() {
                if (o[this.name]) {
                    if (!o[this.name].push) {
                        o[this.name] = [o[this.name]];
                    }
                    o[this.name].push(this.value || '');
                } else {
                    o[this.name] = this.value || '';
                }
            });
            return o;
        };

    </script>

</head>
<body>
<div id="Board" style="width: calc(100% - 10px);height: 100%;position: fixed;top: 0;left:0;z-index: 99999;background: #fff;"></div>
<div id="toolbar">
    <a data-options="iconCls:'icon-reload',plain:true" href="javascript:void(0)" class="easyui-linkbutton"
       onclick="reload()">刷新</a>
    &nbsp;&nbsp;
    <a data-options="iconCls:'icon-add',plain:true" href="javascript:void(0)"
       class="easyui-linkbutton" onclick="update_item()">修改</a>
    <%--<a href="javascript:void(0)"class="easyui-linkbutton"data-options="iconCls:'icon-redo',plain:true"--%>
    <%--onclick="exportexcel('#fontindexconfig_list')">导出报表</a>--%>
</div>

<table id="fontindexconfig_list" title="新闻图片" class="easyui-datagrid">
</table>

<div data-options="buttons:'#dlg-buttons',closed: true" id="dlg" class="easyui-dialog"
     style="width: 450px; height: 290px; padding: 20px 20px" title="对话框">
    <form id="Form">

        <div id="div_advertisingconfig_id" class="fitem">
            <label>
                上传图片:</label>
            <input type="file" id="file_upload_input" name='productimg' onchange='preview(this)'/>
        </div>
        <div id="div_advertisingconfig_" class="fitem">
            <div class="preview_div" style="width: 300px;height: 140px;overflow: hidden;"></div>
        </div>

    </form>
</div>
<div id="dlg-buttons">
    <a data-options="iconCls:'icon-ok'" href="javascript:void(0)" class="easyui-linkbutton"    onclick="SaveItem()">保存</a>
    <a data-options="iconCls:'icon-cancel'" href="javascript:void(0)"    class="easyui-linkbutton"   onclick="javascript:$('#dlg').dialog('close')">关闭</a>
</div>

</body>
</html>
