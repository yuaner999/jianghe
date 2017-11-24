package com.Services.interfaces;

import com.model.News;

import java.util.List;
import java.util.Map;

/**
 * Created by guoqiang on 2016/12/15.
 */
public interface NewsService {
    int getNum (String name);
    List<News> loadAllNews(int pagenum, int pagesize,String moduleType,String newsClass,String sqlStr,String newsDescribe);
    List<Map> checkThirdList(String moduleType);
    List<Map> loadFirstFloorMenu(String grandPaId);
    List<Map> loadSecondFloorMenu(String parentId);
    List<Map> loadNavigation(String newsId);
    List<Map> loadNewsByNewsID(String newsId);
}
