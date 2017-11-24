<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/7/20
  Time: 17:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
"http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">


<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!--兼容360浏览器，防止布局乱-->
    <meta http-equiv=X-UA-Compatible content="IE=edge,chrome=1">
    <title>教师信息填写</title>
    <%--引入EasyUi--%>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/easyui/themes/icon.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/manage/massage-helper.js"></script>
    <%--引入公共JS--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/manage/managecommon.js"></script>
    <%--引入图片上传--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/js/ajaxfileupload.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/css/common.css" />
    <script type="text/javascript" src="<%=request.getContextPath()%>/asset/layer/layer.js"></script>
<script>
    var moduleType = GetQueryString("moduleType");
    var editorName = "null";//KindEditor的Textarea的ID，如果没用到，赋值为null
    var imageUpload = "studentPhoto";
    var editUrl = "/jsons/editStudent.form";
    var fileUpload="";
    $(document).ready( function() {
       $(".create").eq(0).click(function(){
           $("#educations_box").append('<input  class="educations_date"    type="text"/>');
           $("#educations_box").append('<input  class="educations_school"  type="text"/>');
           $("#educations_box").append('<input  class="educations_highest" type="text"/>');
           $("#educations_box").append('<input  class="educations_major"   type="text"/>');
       });
        $(".remove").eq(0).click(function(){
            if($(".educations_date").length==1){
                return;
            }
            $(".educations_date:last").remove();
            $(".educations_school:last").remove();
            $(".educations_highest:last").remove();
            $(".educations_major:last").remove();
        });
        $(".create").eq(1).click(function(){
            $("#works_box").append('<input  class="works_date"    type="text"/>');
            $("#works_box").append('<input  class="works_major"  type="text"/>');
            $("#works_box").append('<input  class="works_unit" type="text"/>');
            $("#works_box").append('<input  class="works_position"   type="text"/>');
        });
        $(".remove").eq(1).click(function(){
            if($(".works_date").length==1){
                return;
            }
            $(".works_date:last").remove();
            $(".works_major:last").remove();
            $(".works_unit:last").remove();
            $(".works_position:last").remove();
        });
        $(".create").eq(2).click(function(){
            $("#thesis_box").append('<input  class="thesis_date"    type="text"/>');
            $("#thesis_box").append('<input  class="thesis_place"  type="text"/>');
            $("#thesis_box").append('<input  class="thesis_title" type="text"/>');
            $("#thesis_box").append('<input  class="thesis_class"   type="text"/>');
        });
        $(".remove").eq(2).click(function(){
            if($(".thesis_date").length==1){
                return;
            }
            $(".thesis_date:last").remove();
            $(".thesis_place:last").remove();
            $(".thesis_title:last").remove();
            $(".thesis_class:last").remove();
        });
        $(".create").eq(3).click(function(){
            $("#writings_box").append('<input  class="writings_date"    type="text"/>');
            $("#writings_box").append('<input  class="writings_place"  type="text"/>');
            $("#writings_box").append('<input  class="writings_title" type="text"/>');
            $("#writings_box").append('<input  class="writings_class"   type="text"/>');
        });
        $(".remove").eq(3).click(function(){
            if($(".writings_date").length==1){
                return;
            }
            $(".writings_date:last").remove();
            $(".writings_place:last").remove();
            $(".writings_title:last").remove();
            $(".writings_class:last").remove();
        });
        $(".create").eq(4).click(function(){
            $("#achievements_box").append('<input  class="achievements_date"    type="text"/>');
            $("#achievements_box").append('<input  class="achievements_place"  type="text"/>');
            $("#achievements_box").append('<input  class="achievements_title" type="text"/>');
            $("#achievements_box").append('<input  class="achievements_class"   type="text"/>');
        });
        $(".remove").eq(4).click(function(){
            if($(".achievements_date").length==1){
                return;
            }
            $(".achievements_date:last").remove();
            $(".achievements_place:last").remove();
            $(".achievements_title:last").remove();
            $(".achievements_class:last").remove();
        });
        $(".create").eq(5).click(function(){
            $("#award_box").append('<input  class="award_date"    type="text"/>');
            $("#award_box").append('<input  class="award_place"  type="text"/>');
            $("#award_box").append('<input  class="award_title" type="text"/>');
            $("#award_box").append('<input  class="award_class"   type="text"/>');
        });
        $(".remove").eq(5).click(function(){
            if($(".award_date").length==1){
                return;
            }
            $(".award_date:last").remove();
            $(".award_place:last").remove();
            $(".award_title:last").remove();
            $(".award_class:last").remove();
        });

        $(".create").eq(6).click(function(){
            $("#exchange_box").append('<input  class="exchange_date"    type="text"/>');
            $("#exchange_box").append('<input  class="exchange_place"  type="text"/>');
            $("#exchange_box").append('<input  class="exchange_title" type="text"/>');
            $("#exchange_box").append('<input  class="exchange_class"   type="text"/>');
        });
        $(".remove").eq(6).click(function(){
            if($(".exchange_date").length==1){
                return;
            }
            $(".exchange_date:last").remove();
            $(".exchange_place:last").remove();
            $(".exchange_title:last").remove();
            $(".exchange_class:last").remove();
        });

        $(".create").eq(7).click(function(){
            $("#parttime_box").append('<input  class="parttime_date"    type="text"/>');
            $("#parttime_box").append('<input  class="parttime_place"  type="text"/>');
            $("#parttime_box").append('<input  class="parttime_title" type="text"/>');
            $("#parttime_box").append('<input  class="parttime_class"   type="text"/>');
        });
        $(".remove").eq(7).click(function(){
            if($(".parttime_date").length==1){
                return;
            }
            $(".parttime_date:last").remove();
            $(".parttime_place:last").remove();
            $(".parttime_title:last").remove();
            $(".parttime_class:last").remove();
        });
   })
</script>
    <style type="text/css">
        .title{
            text-align: center;
            margin-left: 34%;
        }
        .lable_one{
            text-align: right;
            display: inline-block;
            width: 238px;
            padding-right: 10px;
            padding-left: 10px;
        }
        .input_area{
            height: 100px;
            min-width: 202px;
            min-height: 100px;
            max-width: 400px;
            max-height: 100px;
            border: 1px solid #95B8E7;
            border-radius: 6px;
        }
    </style>
</head>
<body >
<!--内容-->
<div id="dlg" title=""
     style="width:750px;height:620px;padding:10px;margin:auto;"
     data-options="iconCls: 'icon-save',buttons: '#dlg-buttons',modal:true,top:'10%'" closed="false" >
    <%--5、第五处修改，修改表单信息，与上面的列名称一致--%>
    <form id="Form">
        <div id="userphoto_box" >
            <img id="user_photo" src="<%=request.getContextPath()%>/asset/image/default.jpg" style="width: 142px;height: 200px;margin-right: 130px;">
        </div>
        <div id="studentName_box" class="fitem">
            <label>姓名:</label>
            <input id="name" class="easyui-validatebox easyui-textbox input_ele" name="name" data-options="required:true,validType:'length[0,20]'"/>
        </div>
        <div id="studentUsedName_box" class="fitem">
            <label>职称:</label>
            <input id="level" class="easyui-validatebox easyui-textbox input_ele" name="level" data-options="validType:'length[0,20]'"/>
        </div>
        <div id="studentPhoto_box" class="fitem">
            <label>照片:</label>
            <input type="file" id="photo" name="phot" onchange='preview(this)'/>
        </div>
        <div id="studentNation_box" class="fitem">
            <label>电话:</label>
            <input id="tel" class="easyui-validatebox easyui-textbox input_ele" name="tel" data-options="validType:'length[0,100]'"/>
        </div>
        <div id="studentBirthday_box" class="fitem">
            <label>传真:</label>
            <input id="fax" class="easyui-validatebox easyui-textbox input_ele" name="fax"  data-options="validType:'length[0,100]'" />
        </div>
        <div id="studentNativePlace_box" class="fitem">
            <label>生日:</label>
            <input id="brith" class="easyui-validatebox easyui-datebox input_ele" name="brith" data-options="editable:false"/>
        </div>
        <div id="studentFamilyPostcode_box" class="fitem">
            <label>研究和教学方向:</label>
            <input id="teaching" class="easyui-validatebox easyui-textbox input_ele" name="teaching" data-options="validType:'length[0,100]'"/>
            <label>课程教学:</label>
            <input id="course" class="easyui-validatebox easyui-textbox input_ele" name="course"      data-options="validType:'length[0,100]'"/>
        </div>
        <div id="studentLeader_box" class="fitem">
            <label style="vertical-align: top">本科生教学:</label>
            <textarea id="benKe" class="input_area" name="benKe" >

            </textarea>
            <label style="vertical-align: top">研究生教学:</label>
            <textarea id="yanJiu" class="input_area" name="yanJiu" >

            </textarea>
        </div>
        <div class="fitem">
            <label class="title">教育背景</label>
        </div>
        <div i class="fitem">
            <label class="lable_one">毕业日期</label>
            <label class="lable_one">毕业院校</label>
            <label class="lable_one">最高学历</label>
            <label class="lable_one">所学专业</label>
        </div>
        <div id="educations_box" class="fitem">
            <input  class="educations_date"    type="text"/>
            <input  class="educations_school"  type="text"/>
            <input  class="educations_highest" type="text" />
            <input  class="educations_major"   type="text" />
             &nbsp;
            <a href="javascript:void(0);"  class="remove">移除</a>
            <a href="javascript:void(0);"  class="create">添加</a>
        </div>
        <div  class="fitem">
            <label class="title">工作经历</label>
        </div>
        <div  class="fitem">
            <label class="lable_one">工作时间</label>
            <label class="lable_one">工作单位</label>
            <label class="lable_one">专业技术</label>
            <label class="lable_one">工作职务</label>
        </div>
        <div id="works_box" class="fitem">
            <input  class="works_date"  type="text"/>
            <input  class="works_unit" type="text" />
            <input  class="works_major"   type="text" />
            <input  class="works_position"    type="text"/>
            &nbsp;
            <a href="javascript:void(0);"  class="remove">移除</a>
            <a href="javascript:void(0);"  class="create">添加</a>
        </div>
        <div  class="fitem">
            <label class="title">发表论文</label>
        </div>
        <div  class="fitem">
            <label class="lable_one">发表时间</label>
            <label class="lable_one">发表地点</label>
            <label class="lable_one">论文标题</label>
            <label class="lable_one">论文方向</label>
        </div>
        <div id="thesis_box" class="fitem">
            <input  class="thesis_date"   type="text" />
            <input  class="thesis_place"  type="text"/>
            <input  class="thesis_title"  type="text" />
            <input  class="thesis_class"  type="text" />
            &nbsp;
            <a href="javascript:void(0);"  class="remove">移除</a>
            <a href="javascript:void(0);"  class="create">添加</a>
        </div>
        <div  class="fitem">
            <label class="title">出版著作</label>
        </div>
        <div  class="fitem">
            <label class="lable_one">出版时间</label>
            <label class="lable_one">出版地点</label>
            <label class="lable_one">著作名字</label>
            <label class="lable_one">著作方向</label>
        </div>
        <div id="writings_box" class="fitem">
            <input  class="writings_date"   type="text" />
            <input  class="writings_place"  type="text"/>
            <input  class="writings_title"  type="text" />
            <input  class="writings_class"  type="text" />
            &nbsp;
            <a href="javascript:void(0);"  class="remove">移除</a>
            <a href="javascript:void(0);"  class="create">添加</a>
        </div>
        <div  class="fitem">
            <label class="title">科研结果</label>
        </div>
        <div  class="fitem">
            <label class="lable_one">科研时间</label>
            <label class="lable_one">科研地点</label>
            <label class="lable_one">科研名字</label>
            <label class="lable_one">科研方向</label>
        </div>
        <div id="achievements_box" class="fitem">
            <input  class="achievements_date"   type="text" />
            <input  class="achievements_place"  type="text"/>
            <input  class="achievements_title"  type="text" />
            <input  class="achievements_class"  type="text" />
            &nbsp;
            <a href="javascript:void(0);"  class="remove">移除</a>
            <a href="javascript:void(0);"  class="create">添加</a>
        </div>
        <div  class="fitem">
            <label class="title">获奖情况</label>
        </div>
        <div  class="fitem">
            <label class="lable_one">获奖时间</label>
            <label class="lable_one">获奖地点</label>
            <label class="lable_one">获奖名字</label>
            <label class="lable_one">获奖方向</label>
        </div>
        <div id="award_box" class="fitem">
            <input  class="award_date"   type="text" />
            <input  class="award_place"  type="text"/>
            <input  class="award_title"  type="text" />
            <input  class="award_class"  type="text" />
            &nbsp;
            <a href="javascript:void(0);"  class="remove">移除</a>
            <a href="javascript:void(0);"  class="create">添加</a>
        </div>
        <div  class="fitem">
            <label class="title">学术交流</label>
        </div>
        <div  class="fitem">
            <label class="lable_one">交流时间</label>
            <label class="lable_one">交流地点</label>
            <label class="lable_one">主题名字</label>
            <label class="lable_one">交流方向</label>
        </div>
        <div id="exchange_box" class="fitem">
            <input  class="exchange_date"   type="text" />
            <input  class="exchange_place"  type="text"/>
            <input  class="exchange_title"  type="text" />
            <input  class="exchange_class"  type="text" />
            &nbsp;
            <a href="javascript:void(0);"  class="remove">移除</a>
            <a href="javascript:void(0);"  class="create">添加</a>
        </div>
        <div  class="fitem">
            <label class="title">社会兼职</label>
        </div>
        <div  class="fitem">
            <label class="lable_one">兼职时间</label>
            <label class="lable_one">兼职单位</label>
            <label class="lable_one">兼职名字</label>
            <label class="lable_one">兼职方向</label>
        </div>
        <div id="parttime_box" class="fitem">
            <input  class="parttime_date"   type="text" />
            <input  class="parttime_place"  type="text"/>
            <input  class="parttime_title"  type="text" />
            <input  class="parttime_class"  type="text" />
            &nbsp;
            <a href="javascript:void(0);"  class="remove">移除</a>
            <a href="javascript:void(0);"  class="create">添加</a>
        </div>
    </form>
        <div>
            <a href="javascript:void(0)">保存信息</a>
        </div>
</div>
</body>

</html>