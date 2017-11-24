package com.controllers;

import com.Services.interfaces.NewsService;
import com.github.pagehelper.Page;
import com.model.DataForDatagrid;
import com.model.News;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

/**
 * Created by guoqiang on 2016/12/15.
 */
@Controller
@RequestMapping(value="/news")
public class NewsController {
    @Autowired
    private NewsService newsService;

    /**
     * 前台加载所有新闻数据，带分页
     * @return
     */
    @RequestMapping(value = "/loadAllNews")
    @ResponseBody
    public DataForDatagrid loadAllNews(String moduleType,String rows,String page,String newsClass,String sqlStr,String newsDescribe){
        DataForDatagrid data = new DataForDatagrid();
        int pagesize=(rows==null || rows.equals(""))? 5:Integer.parseInt(rows);
        int pagenum=(page==null || page.equals(""))? 1:Integer.parseInt(page);
        List<News> list = newsService.loadAllNews(pagenum,pagesize,moduleType,newsClass,sqlStr,newsDescribe);
        data.setDatas(list);
        data.setTotal((int)((Page)list).getTotal());
      //  System.out.println(data);
        return data;
    }

    /**
     * 检查是否含有3级列表
     * @return
     */
    @RequestMapping(value = "/checkThirdList")
    @ResponseBody
    public DataForDatagrid checkThirdList(String moduleType){
        DataForDatagrid data = new DataForDatagrid();
        List<Map> list = newsService.checkThirdList(moduleType);
        data.setDatas(list);
        return data;
    }
    /**
     * 加载一级菜单名字
     * @return
     */
    @RequestMapping(value = "/loadFirstFloorMenu")
    @ResponseBody
    public DataForDatagrid loadFirstFloorMenu(String grandPaId){
        DataForDatagrid data = new DataForDatagrid();
        List<Map> list = newsService.loadFirstFloorMenu(grandPaId);
        data.setDatas(list);
        return data;
    }
    /**
     * 加载二级菜单名字
     * @return
     */
    @RequestMapping(value = "/loadSecondFloorMenu")
    @ResponseBody
    public DataForDatagrid loadSecondFloorMenu(String parentId){
        DataForDatagrid data = new DataForDatagrid();
        List<Map> list = newsService.loadSecondFloorMenu(parentId);
        data.setDatas(list);
        return data;
    }
    /**
     * 加载详情页导航
     * @return
     */
    @RequestMapping("/loadNavigation")
    @ResponseBody
    public DataForDatagrid loadNavigation(String newsId){
        DataForDatagrid data = new DataForDatagrid();
        List<Map> list = newsService.loadNavigation(newsId);
        data.setDatas(list);
        return data;
    }
    /**
     * 加载新闻详情页by newsId
     * @return
     */
    @RequestMapping(value = "/loadNewsByNewsID")
    @ResponseBody
    public DataForDatagrid loadNewsByNewsID(String newsId){
        DataForDatagrid data = new DataForDatagrid();
        List<Map> list = newsService.loadNewsByNewsID(newsId);
        data.setDatas(list);
        return data;
    }
}
