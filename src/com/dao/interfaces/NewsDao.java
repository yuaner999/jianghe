package com.dao.interfaces;

import com.model.News;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by guoqiang on 2016/12/15.
 */
@Repository
public interface NewsDao {
    int getNum(String name);
    List<News> loadAllNews(Map map);
    List<Map> checkThirdList(Map map);
    List<Map> loadFirstFloorMenu(Map map);
    List<Map> loadSecondFloorMenu(Map map);
    List<Map> loadNavigation(Map map);
    List<Map> loadNewsByNewsID(Map map);

    /***
     * 统计次数
     * @param statisticsId
     */
    void statistics(String statisticsId);
}
