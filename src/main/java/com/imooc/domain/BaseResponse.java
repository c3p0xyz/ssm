package com.imooc.domain;

import java.util.HashMap;

public class BaseResponse{

    private int code;

    private String reMessage;

    private HashMap<String, Object> map = new HashMap<>();

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getReMessage() {
        return reMessage;
    }

    public void setReMessage(String reMessage) {
        this.reMessage = reMessage;
    }

    public HashMap<String, Object> getMap() {
        return map;
    }

    public void setMap(HashMap<String, Object> map) {
        this.map = map;
    }

    public static BaseResponse success(){
        BaseResponse baseResponse = new BaseResponse();
        baseResponse.setCode(200);
        baseResponse.setReMessage("操作成功！");
        return baseResponse;
    }

    public static BaseResponse fail(){
        BaseResponse baseResponse = new BaseResponse();
        baseResponse.setCode(999);
        baseResponse.setReMessage("操作失败！");
        return baseResponse;
    }

    public BaseResponse add(String key, Object value){
        this.map.put(key,value);
        return this;
    }
}
