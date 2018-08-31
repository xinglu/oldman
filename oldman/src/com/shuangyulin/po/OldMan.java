package com.shuangyulin.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class OldMan {
    /*老人编号*/
    private Integer oldManId;
    public Integer getOldManId(){
        return oldManId;
    }
    public void setOldManId(Integer oldManId){
        this.oldManId = oldManId;
    }

    /*姓名*/
    @NotEmpty(message="姓名不能为空")
    private String name;
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    /*性别*/
    @NotEmpty(message="性别不能为空")
    private String sex;
    public String getSex() {
        return sex;
    }
    public void setSex(String sex) {
        this.sex = sex;
    }

    /*年龄*/
    @NotNull(message="必须输入年龄")
    private Integer age;
    public Integer getAge() {
        return age;
    }
    public void setAge(Integer age) {
        this.age = age;
    }

    /*老人照片*/
    private String manPhoto;
    public String getManPhoto() {
        return manPhoto;
    }
    public void setManPhoto(String manPhoto) {
        this.manPhoto = manPhoto;
    }

    /*老人介绍*/
    private String manDesc;
    public String getManDesc() {
        return manDesc;
    }
    public void setManDesc(String manDesc) {
        this.manDesc = manDesc;
    }

    /*登记用户*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*登记时间*/
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonOldMan=new JSONObject(); 
		jsonOldMan.accumulate("oldManId", this.getOldManId());
		jsonOldMan.accumulate("name", this.getName());
		jsonOldMan.accumulate("sex", this.getSex());
		jsonOldMan.accumulate("age", this.getAge());
		jsonOldMan.accumulate("manPhoto", this.getManPhoto());
		jsonOldMan.accumulate("manDesc", this.getManDesc());
		jsonOldMan.accumulate("userObj", this.getUserObj().getName());
		jsonOldMan.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonOldMan.accumulate("addTime", this.getAddTime().length()>19?this.getAddTime().substring(0,19):this.getAddTime());
		return jsonOldMan;
    }}