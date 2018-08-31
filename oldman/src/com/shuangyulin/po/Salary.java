package com.shuangyulin.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Salary {
    /*工资id*/
    private Integer salaryId;
    public Integer getSalaryId(){
        return salaryId;
    }
    public void setSalaryId(Integer salaryId){
        this.salaryId = salaryId;
    }

    /*员工*/
    private Employee employeeObj;
    public Employee getEmployeeObj() {
        return employeeObj;
    }
    public void setEmployeeObj(Employee employeeObj) {
        this.employeeObj = employeeObj;
    }

    /*工资年份*/
    @NotNull(message="必须输入工资年份")
    private Integer year;
    public Integer getYear() {
        return year;
    }
    public void setYear(Integer year) {
        this.year = year;
    }

    /*工资月份*/
    @NotNull(message="必须输入工资月份")
    private Integer month;
    public Integer getMonth() {
        return month;
    }
    public void setMonth(Integer month) {
        this.month = month;
    }

    /*工资金额*/
    @NotNull(message="必须输入工资金额")
    private Float salaryMoney;
    public Float getSalaryMoney() {
        return salaryMoney;
    }
    public void setSalaryMoney(Float salaryMoney) {
        this.salaryMoney = salaryMoney;
    }

    /*发放日期*/
    @NotEmpty(message="发放日期不能为空")
    private String giveDate;
    public String getGiveDate() {
        return giveDate;
    }
    public void setGiveDate(String giveDate) {
        this.giveDate = giveDate;
    }

    /*工资备注*/
    private String salaryMemo;
    public String getSalaryMemo() {
        return salaryMemo;
    }
    public void setSalaryMemo(String salaryMemo) {
        this.salaryMemo = salaryMemo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonSalary=new JSONObject(); 
		jsonSalary.accumulate("salaryId", this.getSalaryId());
		jsonSalary.accumulate("employeeObj", this.getEmployeeObj().getName());
		jsonSalary.accumulate("employeeObjPri", this.getEmployeeObj().getEmployeeNo());
		jsonSalary.accumulate("year", this.getYear());
		jsonSalary.accumulate("month", this.getMonth());
		jsonSalary.accumulate("salaryMoney", this.getSalaryMoney());
		jsonSalary.accumulate("giveDate", this.getGiveDate().length()>19?this.getGiveDate().substring(0,19):this.getGiveDate());
		jsonSalary.accumulate("salaryMemo", this.getSalaryMemo());
		return jsonSalary;
    }}