package com.shuangyulin.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Department {
    /*部门编号*/
    private Integer departmentId;
    public Integer getDepartmentId(){
        return departmentId;
    }
    public void setDepartmentId(Integer departmentId){
        this.departmentId = departmentId;
    }

    /*部门名称*/
    @NotEmpty(message="部门名称不能为空")
    private String departName;
    public String getDepartName() {
        return departName;
    }
    public void setDepartName(String departName) {
        this.departName = departName;
    }

    /*成立日期*/
    @NotEmpty(message="成立日期不能为空")
    private String bornDate;
    public String getBornDate() {
        return bornDate;
    }
    public void setBornDate(String bornDate) {
        this.bornDate = bornDate;
    }

    /*负责人*/
    @NotEmpty(message="负责人不能为空")
    private String mainPerson;
    public String getMainPerson() {
        return mainPerson;
    }
    public void setMainPerson(String mainPerson) {
        this.mainPerson = mainPerson;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonDepartment=new JSONObject(); 
		jsonDepartment.accumulate("departmentId", this.getDepartmentId());
		jsonDepartment.accumulate("departName", this.getDepartName());
		jsonDepartment.accumulate("bornDate", this.getBornDate().length()>19?this.getBornDate().substring(0,19):this.getBornDate());
		jsonDepartment.accumulate("mainPerson", this.getMainPerson());
		return jsonDepartment;
    }}