package com.Services.impls;

import com.Services.interfaces.NewsService;
import com.dao.interfaces.NewsDao;
import com.github.pagehelper.PageHelper;
import com.model.News;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by guoqiang on 2016/12/15.
 */
@Service
public class NewsServiceImpl implements NewsService {
    @Autowired
    private NewsDao newsDao;
    @Override
    public int getNum(String name) {
        return newsDao.getNum(name);
    }

    @Override
    public List<News> loadAllNews(int pagenum, int pagesize,String moduleType,String newsClass,String sqlStr,String newsDescribe) {
        PageHelper.startPage(pagenum,pagesize);
        Map map=new HashMap<>();
        map.put("page",pagenum);
        map.put("rows",pagesize);
        map.put("moduleType",moduleType);
        map.put("newsClass",newsClass);
        map.put("sqlStr",sqlStr);
        map.put("newsDescribe",newsDescribe);
        return newsDao.loadAllNews(map);
    }

    @Override
    public List<Map> checkThirdList(String moduleType) {
        Map map=new HashMap<>();
        map.put("moduleType",moduleType);
        return newsDao.checkThirdList(map);
    }

    @Override
    public List<Map> loadFirstFloorMenu(String grandPaId) {
        Map map=new HashMap<>();
        map.put("grandPaId",grandPaId);
        return  newsDao.loadFirstFloorMenu(map);
    }
    @Override
    public List<Map> loadSecondFloorMenu(String parentId) {
        Map map=new HashMap<>();
        map.put("grandPaId",parentId);
        return  newsDao.loadSecondFloorMenu(map);
    }

    @Override
    public List<Map> loadNavigation(String newsId) {
        Map map=new HashMap<>();
        map.put("newsId",newsId);
        return newsDao.loadNavigation(map);
    }
    @Override
    public List<Map> loadNewsByNewsID(String newsId) {
        Map map=new HashMap<>();
        map.put("newsId",newsId);
        return newsDao.loadNewsByNewsID(map);
    }
}
