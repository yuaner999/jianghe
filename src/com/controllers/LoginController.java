/*
*Created by liulei on 2016/4/22.
*/
package com.controllers;

import com.common.utils.SpringUtils;
import com.supermapping.jdbcfactories.JdbcFactory;
import com.utils.PwdUtil;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by liulei on 2016/4/22.
 */
@Controller
@RequestMapping(value = "/Login")
public class LoginController {

    /**
     * 系统用户登录
     * 登陆的说明：根据type判断是哪种用户登陆  1 系统用户  2学生处  3学院管理员    4 导员  5 学生（前端页面）
     * 系统、学生处账号登陆是查找sysuser
     * 学院账号登陆查询sysuser 以及和学院关联的表，并额外把学院的id添加到session中
     * 导员账号登陆查询导员信息表，并额外把导员id和学院id添加到session中 。菜单权限是查找固定的角色id
     * 学生登陆 查询sysuser表，以及和学生信息关联的表，其中角色为空的即是。
     * @param request
     * @param session
     * @param type
     * @return
     */
    @RequestMapping(value = "/SystemLogin")
    @ResponseBody
    public String SystemLogin(HttpServletRequest request, HttpSession session, String type){
 // TODO: 2016/9/24 后台查看降级信息时候，是根据学院名称加载当前学院降级信息，用到session中学院名称 字段为  collageName 未添加
        //返回结果
        String result = "登录失败，请联系服务人员";
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if(username.equals("")){
            return "用户名错误";//用户名错误
        }
        if(password.equals("")){
            return "密码错误";//密码错误
        }
        if(type==null || type.equals("")){
            return "请选择登陆角色";
        }
        JdbcFactory factory = SpringUtils.getBean(JdbcFactory.class);
//        //如果是导员登陆
//        if("4".equals(type)){
//            result=instructorLogin(username,password, factory,session);
//            return result;
//        }
//        if("5".equals(type)){
//            result=studentLogin(username,password, factory,session);
//            return result;
//        }
        //如果不是导员登陆
        Connection connection=null;
        PreparedStatement preparedStatement=null;
        ResultSet resultSet=null;
        try {
            connection = factory.createConnection();
            String sql = "SELECT * FROM sysuser where username=?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, username);
            resultSet = preparedStatement.executeQuery();
            if(resultSet.next()){
                String databasePassword = resultSet.getString("password");
                String roleId= resultSet.getString("sysrole_id");
                //验证登陆类型（角色）与用户是否一致 __通过该用户所关联的角色来验证
                if(!(type.equals(roleId))){
                    return "该用户与所选的登陆角色不符,请选择正确的角色";
                }
                password = PwdUtil.getPassMD5(password);
                if(password.equals(databasePassword)){
                    String userId = resultSet.getString("sysuser_id");
                    session.setAttribute("loginId",userId);
                    session.setAttribute("loginName",username);//将用户名写入Session
                    session.setAttribute("loginuserpassword",databasePassword);//将用户密码写入Session
                    session.setAttribute("logintype",type);                 //将登陆的角色类型保存到session
                    //如果是系统管理员、教工、江河学院管理员，查找菜单权限
                        //设置角色权限菜单
                        sql = "SELECT * FROM sys_sysuser_sysmenu_view where username=?";
                        preparedStatement = connection.prepareStatement(sql);
                        preparedStatement.setString(1, username);
                        resultSet = preparedStatement.executeQuery();
                        List<String> rolemenuIdList = new ArrayList<String>();
                        while (resultSet.next()){
                            rolemenuIdList.add(resultSet.getString("sysmenu_id"));
                        }
                        session.setAttribute("rolemenuId",rolemenuIdList);
//                        if("3".equals(type)){                   //如果登陆的角色是学院管理员，还要再查找学院ID并放到session里
//                            sql="SELECT * from r_sysuer_college where userid=?";
//                            preparedStatement = connection.prepareStatement(sql);
//                            preparedStatement.setString(1, userId);
//                            resultSet = preparedStatement.executeQuery();
//                            if(resultSet.next()){
//                                String collegeId=resultSet.getString("collegeName");
//                                if(collegeId!=null && !"".equals(collegeId)){
//                                    session.setAttribute("collegeid",collegeId);
//                                }else {
//                                    return "未找到用户相关联的学院信息，请查证后再试或者联系系统管理员";
//                                }
//                            }else {
//                                return "未找到用户相关联的学院信息，请查证后再试或者联系系统管理员";
//                            }
//                        }
                    result = "1";//用户名密码正确，登录成功
                }else {
                    result = "密码错误";//密码错误
                }
            }else{
                result = "用户名错误";//用户名错误
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    /**
     * 学生登陆处理逻辑
     * @param user
     * @param pwd
     * @param factory
     * @param session
     * @return
     */
    private String studentLogin(String user, String pwd, JdbcFactory factory , HttpSession session){
        Connection connection=null;
        PreparedStatement preparedStatement=null;
        ResultSet resultSet=null;
        try {
            connection = factory.createConnection();
            String sql = "SELECT * FROM student where studentID=?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, user);
            resultSet = preparedStatement.executeQuery();
            String userName="";
            if(resultSet.next()){
                String userId = resultSet.getString("studentID");
                String databasePassword = resultSet.getString("studentPwd");
                userName= resultSet.getString("studentName");
                pwd= PwdUtil.getPassMD5(pwd);
                if(databasePassword.equals(pwd)){
                    System.out.println(databasePassword);
                    System.out.println(pwd);
                    session.setAttribute("loginId",userId);
                    session.setAttribute("studentid",userId);
                    session.setAttribute("loginName",userName);//将用户名写入Session
                    session.setAttribute("loginuserpassword",databasePassword);//将用户密码写入Session
                    session.setAttribute("logintype","5");                 //将登陆的角色类型保存到session(导员)

                }else{
                    return "密码错误";
                }
            }else{
                return "学号错误";
            }
            return "1|"+userName;
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return "登录失败，请联系服务人员";
    }
    /**
     * 登陆类型是导员的时候的处理逻辑
     * @param user
     * @param pwd
     * @param factory
     * @param session
     * @return
     */
    private String instructorLogin(String user, String pwd, JdbcFactory factory , HttpSession session){
        Connection connection=null;
        PreparedStatement preparedStatement=null;
        ResultSet resultSet=null;
        try {
            connection = factory.createConnection();
            String sql = "SELECT * FROM instructor where instructorLogin=?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, user);
            resultSet = preparedStatement.executeQuery();
            if(resultSet.next()){
                String userId = resultSet.getString("instructorId");
                String databasePassword = resultSet.getString("instructorPwd");
                String collegeid=resultSet.getString("instructorCollegeName");
                pwd= PwdUtil.getPassMD5(pwd);
                if(databasePassword.equals(pwd)){
                    session.setAttribute("loginId",userId);
                    session.setAttribute("instructorid",userId);
                    session.setAttribute("loginName",user);//将用户名写入Session
                    session.setAttribute("loginuserpassword",databasePassword);//将用户密码写入Session
                    session.setAttribute("logintype","4");                 //将登陆的角色类型保存到session(导员)
                    session.setAttribute("collegeid",collegeid);                 //将登陆的角色类型保存到session(导员)
                    //设置角色权限菜单
                    sql = "SELECT * FROM sysrolemenu where sysrole_id='instructor'";
                    preparedStatement = connection.prepareStatement(sql);
                    resultSet = preparedStatement.executeQuery();
                    List<String> rolemenuIdList = new ArrayList<String>();
                    while (resultSet.next()){
                        rolemenuIdList.add(resultSet.getString("sysmenu_id"));
                    }
                    session.setAttribute("rolemenuId",rolemenuIdList);
                }else{
                    return "密码错误";
                }
            }else{
                return "用户名错误";
            }
            return "1";
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return "登录失败，请联系服务人员";
    }
    /**
     * 添加系统用户
     * @param request
     * @param session
     * @return
     * @throws UnsupportedEncodingException
     * @throws NoSuchAlgorithmException
     */
    @RequestMapping(value = "/AddSysUser")
    @ResponseBody
    public JSONObject AddSysUser(HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException, NoSuchAlgorithmException {
        String result = "{'result':false}";

        String userName = request.getParameter("username")==null?"":request.getParameter("username").toString();
        String loginName = session.getAttribute("loginName")==null?"":session.getAttribute("loginName").toString();
        String remark = request.getParameter("remark")==null?"":request.getParameter("remark").toString();
        String password = PwdUtil.getPassMD5(PwdUtil.getPassMD5("123456").toLowerCase());
        String sysroleid = request.getParameter("sysroleid")==null?"":request.getParameter("sysroleid").toString();

        if(userName.equals("")||loginName.equals("")||sysroleid.equals("")){
            result = "{'result':false}";
            JSONObject json = JSONObject.fromObject(result);
            return json;
        }

        JdbcFactory factory = SpringUtils.getBean(JdbcFactory.class);

        try {
            Connection connection = factory.createConnection();
            String sql = "insert into sysuser(sysuser_id,username,password,sysrole_id,is_sysadmin,create_date,create_man,remark) values(UUID(),?,?,?,'否',now(),?,?)";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, userName);
            preparedStatement.setString(2, password);
            preparedStatement.setString(3, sysroleid);
            preparedStatement.setString(4, loginName);
            preparedStatement.setString(5, remark);
            preparedStatement.execute();
            result = "{'result':true}";
            preparedStatement.close();
            connection.close();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        JSONObject json = JSONObject.fromObject(result);
        return json;
    }

    /**
     * 退出登录
     * @param session
     */
    @RequestMapping(value = "/ExitLogin")
    @ResponseBody
    public String ExitLogin(HttpSession session){
        String type= (String) session.getAttribute("logintype");
        session.removeAttribute("loginId");
        session.removeAttribute("loginName");
        session.removeAttribute("rolemenuId");
        session.removeAttribute("logintype");
        session.removeAttribute("collegeid");
        session.removeAttribute("instructorid");
        session.removeAttribute("logintype");
        session.removeAttribute("studentid");
        return type;
    }

    /**
     * 修改密码
     * @param request
     * @param session
     * @return
     * @throws UnsupportedEncodingException
     * @throws NoSuchAlgorithmException
     */
    @RequestMapping(value = "/EditPassword",method = RequestMethod.POST)
    @ResponseBody
    public String EditPassword(HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException, NoSuchAlgorithmException {
        if(session.getAttribute("loginuserpassword")==null){
            return "登录超时，请重新登录";
        }
        String sysuserId = (String) session.getAttribute("loginId");
        if(sysuserId.equals("1f97b97e-a665-4d46-9ea6-59b1cbfa3873")){
            return "当前帐号密码不可修改";
        }
        String nowPassword = (String) session.getAttribute("loginuserpassword");
        String oldPassword = request.getParameter("oldpassword")==null?"": request.getParameter("oldpassword");
        String newPassword = request.getParameter("newpassword")==null?"": request.getParameter("newpassword");
        System.out.println("now:"+nowPassword+"|old:"+oldPassword+"|new:"+newPassword);
        oldPassword = PwdUtil.getPassMD5(oldPassword);
        newPassword = PwdUtil.getPassMD5(newPassword);
        String result = "-1";
        if(oldPassword.equals("")||newPassword.equals("")){
            return "-1";
        }
        System.out.println("now"+nowPassword);
        System.out.println("old"+oldPassword);
        if(nowPassword.equals(oldPassword)){

            JdbcFactory factory = SpringUtils.getBean(JdbcFactory.class);

            try {
                Connection connection = factory.createConnection();
                String sql;
                //判断是否是导员要更改密码
                String type= (String) session.getAttribute("logintype");
                if(type!=null && type.equals("4")){
                    sql = "UPDATE instructor SET instructorPwd=? WHERE instructorId=?";
                }else if(type!=null && type.equals("5")){
                    sql="UPDATE student SET studentPwd=? WHERE studentID=?";
                }else{
                    sql = "UPDATE sysuser SET password=? WHERE sysuser_id=?";
                }
                PreparedStatement preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setString(1, newPassword);
                preparedStatement.setString(2, sysuserId);
                preparedStatement.execute();
                //返回登陆类型
                result = type;
                //清理session
                ExitLogin(session);
                preparedStatement.close();
                connection.close();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (InstantiationException e) {
                e.printStackTrace();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            //清理掉session
            ExitLogin(session);
        }else {
            return "当前密码错误";
        }
        return result;
    }

    @RequestMapping("/CheckLogin")
    @ResponseBody
    public String checkLogin(HttpSession session){
        String studentid=(String)session.getAttribute("studentid");
        return (String) session.getAttribute("loginName")+"|"+studentid;
    }

}
