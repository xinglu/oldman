package com.shuangyulin.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Reception {
    /*接待记录id*/
    private Integer receptionId;
    public Integer getReceptionId(){
        return receptionId;
    }
    public void setReceptionId(Integer receptionId){
        this.receptionId = receptionId;
    }

    /*接待类别*/
    @NotEmpty(message="接待类别不能为空")
    private String receptType;
    public String getReceptType() {
        return receptType;
    }
    public void setReceptType(String receptType) {
        this.receptType = receptType;
    }

    /*接待主题*/
    @NotEmpty(message="接待主题不能为空")
    private String title;
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    /*接待内容*/
    private String content;
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    /*接待日期*/
    @NotEmpty(message="接待日期不能为空")
    private String receptDate;
    public String getReceptDate() {
        return receptDate;
    }
    public void setReceptDate(String receptDate) {
        this.receptDate = receptDate;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonReception=new JSONObject(); 
		jsonReception.accumulate("receptionId", this.getReceptionId());
		jsonReception.accumulate("receptType", this.getReceptType());
		jsonReception.accumulate("title", this.getTitle());
		jsonReception.accumulate("content", this.getContent());
		jsonReception.accumulate("receptDate", this.getReceptDate().length()>19?this.getReceptDate().substring(0,19):this.getReceptDate());
		return jsonReception;
    }}