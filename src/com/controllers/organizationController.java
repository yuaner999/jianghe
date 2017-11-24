/*
*Created by shaowen on 2016/4/25.
*/
package com.controllers;

import com.common.utils.SpringUtils;
import com.model.ComboTree;
import com.supermapping.jdbcfactories.JdbcFactory;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by shaowen on 2016/4/25.
 */
@Controller
@RequestMapping(value = "/organization")
public class organizationController {

    List<ComboTree> comboTreeList = new ArrayList<>();

    /**
     * 获取系统菜单管理的所有菜单
     * @return
     */
    @RequestMapping(value = "/getSysMenuList")
    @ResponseBody
    public JSONObject getSysMenuList(){

        String result = "{}";
        String json = "";
        String count = "0";

        JdbcFactory factory = SpringUtils.getBean(JdbcFactory.class);

        try {
            Connection connection = factory.createConnection();
            String sql = "select count(*) as count FROM organization";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();
            if(resultSet.next()){
                count = resultSet.getString("count").toString();
                sql = "SELECT *,organizationParentId as parentId FROM organization order by organizationSort";
                preparedStatement = connection.prepareStatement(sql);
                resultSet = preparedStatement.executeQuery();
                while (resultSet.next()){
                    json += "{'organizationName':'"+resultSet.getString("organizationName")+"'," +
                            "'organizationSort':'"+resultSet.getString("organizationSort")+"'," +
                            "'organizationId':'"+resultSet.getString("organizationId")+"',";
                    if(resultSet.getString("parentId")!=null){
                        if(!resultSet.getString("parentId").toString().equals("")){
                            json += "'parentId':'"+resultSet.getString("parentId").toString()+"',";
                        }
                    }
                    json += "'organizationParentId':'"+resultSet.getString("organizationParentId").toString()+"'},";
                }
            }else{
                json = "{}";
            }
            json = json.substring(0,json.length()-1);
            result = "{'total':"+count+",'rows':["+json+"]}";
            resultSet.close();
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
        JSONObject jsonObject = JSONObject.fromObject(result);
        return jsonObject;
    }

    /**
     * 加载所有父菜单
     * @return
     */
    @RequestMapping(value = "/getParentMenu")
    @ResponseBody
    public List<ComboTree> getParentMenu(){

        JdbcFactory factory = SpringUtils.getBean(JdbcFactory.class);

        try {
            Connection connection = factory.createConnection();
            String sql = "SELECT * FROM organization order by organizationParentId desc,organizationSort";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();
            comboTreeList.clear();
            while (resultSet.next()){
                ComboTree comboTree = new ComboTree();
                comboTree.setId(resultSet.getString("organizationId").toString());
                comboTree.setText(resultSet.getString("organizationName").toString());
                String parentmenuid = "";
                if(resultSet.getString("organizationId")==null){
                    parentmenuid = "";
                }else {
                    parentmenuid = resultSet.getString("organizationParentId").toString();
                }
                comboTree.setParentId(parentmenuid);
                comboTreeList.add(comboTree);
            }
            resultSet.close();
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
        return DataToComboTree("");
    }

    /**
     * 将数据转化成对应的树形式
     * @param parentId
     * @return
     */
    public List<ComboTree> DataToComboTree(String parentId){

        List<ComboTree> list = new ArrayList<>();
        List<ComboTree> result = new ArrayList<>();
        for (ComboTree com : comboTreeList) {
            if(com.getParentId().equals(parentId)){
                list.add(com);
            }
        }

        for (ComboTree combo : list) {
            result.add(new ComboTree(
                    combo.getId(),combo.getText(),combo.getParentId(),DataToComboTree(combo.getId())
            ));
        }
        return result;
    }

    /**
     * 保存角色菜单的更改
     * @param request
     * @param menuIdList
     * @return
     */
    @RequestMapping(value = "/saveRoleMenu",method = RequestMethod.POST)
    @ResponseBody
    public String saveRoleMenu(HttpServletRequest request,@RequestParam(value = "menuIdList[]") String[] menuIdList){

        String result = "-1";

        if(request.getParameter("sysroleId")==null){
            return "-1";
        }
        String sysroleId = request.getParameter("sysroleId").toString();
        if(sysroleId.equals("")){
            return "请选择一个角色";
        }

        JdbcFactory factory = SpringUtils.getBean(JdbcFactory.class);

        try {
            Connection connection = factory.createConnection();
            String sql = "DELETE FROM sysrolemenu WHERE sysrole_id=?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1,sysroleId);
            preparedStatement.execute();
            if(!menuIdList[0].equals("none")){
                sql = "INSERT INTO sysrolemenu(sysrolemenu_id,sysrole_id,sysmenu_id) VALUES(uuid(),?,?)";
                preparedStatement = connection.prepareStatement(sql);
                for (String sysmenuId:menuIdList) {
                    preparedStatement.setString(1,sysroleId);
                    preparedStatement.setString(2,sysmenuId);
                    preparedStatement.addBatch();
                }
                preparedStatement.executeBatch();
            }
            preparedStatement.close();
            connection.close();
            result = "1";
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    /**
     * 批量删除菜单
     * @param request
     * @param menuIdList
     * @return
     */
    @RequestMapping(value = "/deleteMenu",method = RequestMethod.POST)
    @ResponseBody
    public String deleteMenu(HttpServletRequest request,@RequestParam(value = "menuIdList[]") String[] menuIdList){

        String result = "-1";
        JdbcFactory factory = SpringUtils.getBean(JdbcFactory.class);

        try {
            Connection connection = factory.createConnection();
            String sql = "DELETE FROM organization WHERE organizationId=?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            for (String organizationId:menuIdList) {
                preparedStatement.setString(1,organizationId);
                preparedStatement.addBatch();
            }
            preparedStatement.executeBatch();
            result = "1";
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return result;
    }
}
