package com.shuangyulin.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Nurse {
    /*记录id*/
    private Integer nurseId;
    public Integer getNurseId(){
        return nurseId;
    }
    public void setNurseId(Integer nurseId){
        this.nurseId = nurseId;
    }

    /*信息类别*/
    @NotEmpty(message="信息类别不能为空")
    private String nurseType;
    public String getNurseType() {
        return nurseType;
    }
    public void setNurseType(String nurseType) {
        this.nurseType = nurseType;
    }

    /*信息标题*/
    @NotEmpty(message="信息标题不能为空")
    private String title;
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    /*信息内容*/
    @NotEmpty(message="信息内容不能为空")
    private String content;
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    /*发布时间*/
    @NotEmpty(message="发布时间不能为空")
    private String publishDate;
    public String getPublishDate() {
        return publishDate;
    }
    public void setPublishDate(String publishDate) {
        this.publishDate = publishDate;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonNurse=new JSONObject(); 
		jsonNurse.accumulate("nurseId", this.getNurseId());
		jsonNurse.accumulate("nurseType", this.getNurseType());
		jsonNurse.accumulate("title", this.getTitle());
		jsonNurse.accumulate("content", this.getContent());
		jsonNurse.accumulate("publishDate", this.getPublishDate().length()>19?this.getPublishDate().substring(0,19):this.getPublishDate());
		return jsonNurse;
    }}