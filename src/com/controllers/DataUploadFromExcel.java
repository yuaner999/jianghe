package com.controllers;


import com.model.*;
import com.utils.PwdUtil;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.hssf.usermodel.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Method;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;
import java.util.Map.Entry;

/**
 * 上传excel文件，批量导入数据库的controller
 * @author hong
 * Created by admin on 2016/7/14.
 */
@Controller
@RequestMapping("/dataupload")
public class DataUploadFromExcel {
//    @Autowired
//    private StudentService studentService;
//    @Autowired
//    private MemberService memberService;
    /**
     * 文件最大值
     */
//    private long maxSize = 10*1024*1024;
    /**
     * 表格的名字，区分是哪些数据
     */
    private String tableName="";
    /**
     * 数据总行数
     */
    private int totalrows=0;
    /**
     * 成功保存的数据行数
     */
    private int saveRows=0;
    /**
     * 批量保存数据库的批次
     */
    private final int batch=2000;

    /**
     * 上传学生信息表
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/studentinfo")
    @ResponseBody
    public ResultData exec(HttpServletRequest request, HttpServletResponse response) {
        long start=System.currentTimeMillis();
        ResultData resultData ;
        response.reset();
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");
        //从请求中加载文件
        resultData=getFileFromRequest(request);
        if(resultData.getStatus()!=0)return resultData;
        FileItem item= (FileItem) resultData.getData();
        try {
            //交给excel处理程序 将表格中的数据转换成map的集合，每个map就是一行记录
            List<Map<String ,String >> list=excelProcess(item.getInputStream());
            //把转换完成的数据交给数据存储处理函数
            List<String > error_list=saveStudentData(list);
            resultData.setData(error_list);
        } catch (IOException e) {
            e.printStackTrace();
            resultData.sets(-1, e.getMessage());
            return resultData;
        }catch (ParseException e){
            e.printStackTrace();
            resultData.sets(-1, e.getMessage());
            return resultData;
        }
        long times=System.currentTimeMillis()-start;
        resultData.setMsg("共计"+totalrows+"行数据，成功保存"+saveRows+"行，用时："+times+"ms");
        saveRows=0;
        return resultData;
    }

    /**
     * 验证上传文件的数据合不合格(主要是重复性检测)
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/validdata")
    @ResponseBody
    public ResultData validUploadFile(HttpServletRequest request,HttpServletResponse response){
        long start=System.currentTimeMillis();
        ResultData resultData ;
        response.reset();
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");
        resultData=getFileFromRequest(request);
        if(resultData.getStatus()!=0) return resultData;
        FileItem item= (FileItem) resultData.getData();
        //取出文件后把data清空，否则有可能会被返回给客户端，从而导致报错
        resultData.setData(null);
        //交给excel处理程序 将表格中的数据转换成map的集合，每个map就是一行记录
        List<Map<String ,String >> list= null;
        try {
            list = excelProcess(item.getInputStream());
            System.out.println("从表格中取出数据完成");
        } catch (IOException e) {
            e.printStackTrace();
            resultData.sets(-1,e.getMessage().substring(2001));
            return resultData;
        }
        //验证excel文件中数据的完整及唯一性
//        List<ResultData> resultlist=uqValid(list);
//        System.out.println("验证excel文件中数据的完整及唯一性完成");
//        if(resultlist.size()>0){
//            resultData.sets(1,"文件中有错误");
//            resultData.setData(resultlist);
//            return resultData;
//        }
        //验证数据是否和数据库中的数据有重复
//        if(tableName!=null && tableName.contains("students")){
//            resultData=primaryKeyValid(list);
//            if(resultData.getStatus()!=0) return resultData;
//        }
        long times=System.currentTimeMillis()-start;
        resultData.setMsg("文件检测完成，共计"+totalrows+"行数据，用时："+times+"ms");
        return resultData;
    }

    /**
     * 从request中加载文件
     * @param request
     * @return
     */
    public ResultData getFileFromRequest(HttpServletRequest request) {
        ResultData resultData=new ResultData();
        //检查是否上传了文件
        if (!ServletFileUpload.isMultipartContent(request)) {
            resultData.sets(1, "请选择文件");
            return resultData;
        }
        //获取文件
        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        List items = null;
        try {
            items = upload.parseRequest(request);
//            System.out.println(items.size());
        } catch (FileUploadException e) {
            e.printStackTrace();
            resultData.sets(-1, e.getMessage());
            return resultData;
        }
        Iterator itr = items.iterator();
        FileItem item=null;
        if(itr.hasNext()) {
            item = (FileItem) itr.next();
            String fileName = item.getName();
            if (!item.isFormField()) {
                tableName=fileName.substring(0,fileName.lastIndexOf("."));
                // 检查扩展名
                String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
                if (!"xls".equals(fileExt)) {
                    resultData.sets(1, "上传文件格式不正确！");
                    return resultData;
                }
                System.out.println("上传文件检查文件完成");
            }
        }
        resultData.setData(item);
        return resultData;
    }

    /**
     * 把数据保存到数据库
     * @param list
     * @return 错误的信息
     * @throws ParseException
     */
    private List<String> saveStudentData(List<Map<String ,String >> list) throws ParseException {
//        //学生列表
//        List<Student> students=new ArrayList<>();
//        //学生家庭成员列表
//        List<Member> members=new ArrayList<>();
//        List<String > errorList=new ArrayList<>();
//        Map<String ,String > className=null;
//        if(tableName.contains("students_info"))
//            className=generateClassMap();
//        int i=0;
//        for(Map<String ,String > map:list){
//            //如果是学生信息表的操作
//            if(tableName.contains("students_info") && className!=null){
//                //转换表格中的班级名字为id
//                map.put("usiClassId",className.get(map.get("usiClassId")));
//                //设置密码为身份证号的后6位
//                String idcard=map.get("studentIdCard");
//                if(idcard!=null && !idcard.equals("")) {
//                    idcard=idcard.toLowerCase();
//                    idcard=idcard.substring(idcard.length()-6,idcard.length());
//                }
//                try {
////                    System.out.println("|"+idcard);
//                    map.put("studentPwd", PwdUtil.getPassMD5(PwdUtil.getPassMD5(idcard).toLowerCase()));
//                } catch (NoSuchAlgorithmException e) {
//                    e.printStackTrace();
//                } catch (UnsupportedEncodingException e) {
//                    e.printStackTrace();
//                }
//            }
//            //把map转换成对象
//            if(tableName.contains("students_info")){
//                Student_Encoding s= (Student_Encoding) mapToObj(map,Student_Encoding.class);
////                System.out.println(s.toString());
//                students.add(s);
//            }else if(tableName.contains("members")){
//                Member_Encoding m=(Member_Encoding) mapToObj(map, Member_Encoding.class);
////                System.out.println(m.toString());
//                members.add(m);
//            }
//
//            i++;
//            if(i%batch==0){
//                try{
//                    int result=0;
//                    //根据文件名字的不同，调用不同的service
//                    if(tableName.contains("students_info")){
//                        result=studentService.saveStudents(students);
//                    }else if(tableName.contains("members")){
//                        result=memberService.saveMembers(members);
//                    }
//                    System.out.println(result);
//                    if(result<=0){
//                        errorList.add("第"+(i-batch<=0?1:i-batch+1)+"行至第"+i+"行保存至数据库失败，原因：未知");
//                    }else{
//                        saveRows+=result;
//                    }
//                }catch (Exception e){
//                    e.getStackTrace();
//                    String msg=e.getMessage();
//                    errorList.add("第"+(i-batch<=0?1:i-batch+1)+"行至第"+i+"行保存至数据库失败，原因："+e.getMessage().substring(0,msg.length()>2000?2000:msg.length()));
//                    System.out.println("第"+(i-batch<=0?1:i-batch+1)+"行至第"+i+"行保存至数据库失败，原因："+e.getMessage().substring(0,msg.length()>2000?2000:msg.length()));
//                }
//                students.clear();
//            }
//        }
//        try{
//            int result=0;
//            //根据文件名字的不同，调用不同的service
//            if(tableName.contains("students_info")){
//                result=studentService.saveStudents(students);
//            }else if(tableName.contains("members")){
//                result=memberService.saveMembers(members);
//            }
//            System.out.println(result);
//            if(result<=0){
//                errorList.add("第"+((i/batch)*batch+1)+"行至第"+i+"行保存至数据库失败，原因：未知");
//            }else{
//                saveRows+=result;
//            }
//        }catch (Exception e){
//            e.getStackTrace();
//            String msg=e.getMessage();
//            errorList.add("第"+((i/batch)*batch+1)+"行至第"+i+"行保存至数据库失败，原因："+msg.substring(0,msg.length()>2000?2000:msg.length()));
//            System.out.println("第"+((i/batch)*batch+1)+"行至第"+i+"行保存至数据库失败，原因："+e.getMessage().substring(0,msg.length()>2000?2000:msg.length()));
//        }
//        System.out.println(errorList.size());
//        return errorList;
        return null;
    }

    /**
     * 处理excel中的数据，返回Map的集合。每个map 就是一行数据
     * @param input
     * @return
     * @throws IOException
     */
    private List<Map<String ,String >> excelProcess(InputStream input) throws IOException{
        List<Map<String ,String >> list=new ArrayList<>();
        HSSFWorkbook hssfWorkbook = new HSSFWorkbook(input);
        HSSFSheet sheet=hssfWorkbook.getSheetAt(0);
        List<String > fieldName=new ArrayList<>();
        //总数据行数 ，表格的总行数，减去前三行标题
        totalrows=sheet.getLastRowNum()-3+1;
        for(int i=1;i<=sheet.getLastRowNum();i++){
            //跳过第三行 （中文标题）
            if(i==2)continue;
            HSSFRow row=sheet.getRow(i);
            Map<String ,String> map=new HashMap<>();
            for(int j=0;j<=row.getLastCellNum();j++){
                HSSFCell cell=row.getCell(j);
                if(cell==null)continue;
                String cellvalue=getCellStringValue(cell);
                //如果是第二行（字段名）则放到另一个list中
                if(i==1) {
                    fieldName.add(cellvalue);
                }else{
                    map.put(fieldName.get(j),cellvalue);
                }
            }
            if(i!=1) list.add(map);
        }
        return list;
    }

    /**
     * 根据单元格不同属性返回字符串数据
     * @param cell
     * @return
     */
    private String getCellStringValue(HSSFCell cell) {
        String cellValue = "";
        switch (cell.getCellType()) {
            case HSSFCell.CELL_TYPE_STRING://字符串类型
                cellValue = cell.getStringCellValue();
                if(cellValue.trim().equals("")||cellValue.trim().length()<=0)
                    cellValue="";
                break;
            case HSSFCell.CELL_TYPE_NUMERIC: //数值类型
                if(HSSFDateUtil.isCellDateFormatted(cell)){     //如果是日期
                    SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
                    cellValue=sdf.format(cell.getDateCellValue());
                }else{
                    cellValue = String.valueOf(cell.getNumericCellValue());
                }
                break;
            case HSSFCell.CELL_TYPE_FORMULA: //公式
                cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
                cellValue = String.valueOf(cell.getNumericCellValue());
                break;
            case HSSFCell.CELL_TYPE_BLANK:
                cellValue="";
                break;
            case HSSFCell.CELL_TYPE_BOOLEAN:
                break;
            case HSSFCell.CELL_TYPE_ERROR:
                break;
            default:
                break;
        }
        return cellValue;
    }

    /**
     * 把map 转换成对象 (调用set方法，方便加密)
     * @param map 需要转换的map
     * @param c 要转换成对象的class
     * @return
     */
    public Object mapToObj(Map map,Class c) throws ParseException {
        Object o=null;
        try {
            o=c.newInstance();
            Method[] methods=c.getMethods();
            for(Method m:methods){
                m.setAccessible(true);
                String methodName=m.getName();
                if(!methodName.contains("set")) continue;   //如果不是set方法则跳过
                Class paraType=m.getParameterTypes()[0];
                SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
                String value=(String)map.get(methodName.substring(3,4).toLowerCase()+methodName.substring(4));      //把方法名中的set去掉，然后第一个字母转小写，就是bean属性，以此为key从map 中取值
                if(value==null || value.equals(""))continue;    //根据bean属性在map中获取不到值则跳过
                if( paraType== java.sql.Date.class){       //如果该set方法的参数类型是date 或者 timestamp
                    m.invoke(o,new java.sql.Date(sdf.parse(value).getTime()));
                }else if(paraType==Date.class ){
                    m.invoke(o,new Date(sdf.parse(value).getTime()));
                }else if( paraType== Timestamp.class){
                    m.invoke(o,new Timestamp(sdf.parse(value).getTime()));
                }else if(paraType== int.class){                   //如果该set方法的参数类型是int
                    m.invoke(o,Integer.parseInt(value));
                }else if(paraType==String.class) {                //如果该set方法的参数类型是 string
                    m.invoke(o,value);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return o;
    }

}