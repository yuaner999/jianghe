package com.utils;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by admin on 2016/8/1.
 */
public class Utils {
    /**
     * 判断字符串是不是空值
     * @param str
     * @return
     */
    public static boolean isEmptyString(String str){
        return str==null || str.equals("") || str.equals("null");
    }
    /**
     * 把map 转换成对象 (调用set方法，方便加密)
     * @param map 需要转换的map
     * @param c 要转换成对象的class
     * @return
     */
    public static Object mapToObj(Map map, Class c) throws Exception {
        Object o=null;
        o=c.newInstance();
        Method[] methods=c.getMethods();
        for(Method m:methods){
            m.setAccessible(true);
            String methodName=m.getName();
            if(!methodName.contains("set")) continue;   //如果不是set方法则跳过
            Class paraType=m.getParameterTypes()[0];
            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
            String value=(String)map.get(methodName.substring(3,4).toLowerCase()+methodName.substring(4));      //把方法名中的set字符去掉，然后第一个字母转小写，就是bean属性，以此为key从map 中取值
            if(value==null || value.equals(""))continue;    //根据bean属性在map中获取不到值则跳过
            if( paraType== java.sql.Date.class){       //如果该set方法的参数类型是date 或者 timestamp
                m.invoke(o,new java.sql.Date(sdf.parse(value).getTime()));
            }else if(paraType==Date.class ){
                m.invoke(o,new Date(sdf.parse(value).getTime()));
            }else if( paraType== Timestamp.class){
                m.invoke(o,new Timestamp(sdf.parse(value).getTime()));
            }else if(paraType== int.class){                   //如果该set方法的参数类型是int
                m.invoke(o,Integer.parseInt(value));
            }else if(paraType== BigDecimal.class){
                m.invoke(o,new BigDecimal(value));
            }else if(paraType==String.class) {                //如果该set方法的参数类型是 string
                m.invoke(o,value);
            }
        }
        return o;
    }
    
    /**
     * 对象转Map
     * @param obj
     * @return
     * @throws InvocationTargetException
     * @throws IllegalAccessException
     */
    public static Map<String ,Object> ObjToMap(Object obj) throws InvocationTargetException, IllegalAccessException {
        Map<String ,Object> map=new HashMap<>();
        Method[] methods=obj.getClass().getMethods();
        for(Method m:methods){
            m.setAccessible(true);
            String name=m.getName();
            if(!name.startsWith("get")) continue;
            name=name.substring(3).toLowerCase();
            Object o=m.invoke(obj);
            map.put(name,o);
        }
        return map;
    }
}
