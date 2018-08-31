package com.shuangyulin.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class RoomOrder {
    /*订单编号*/
    private Integer orderId;
    public Integer getOrderId(){
        return orderId;
    }
    public void setOrderId(Integer orderId){
        this.orderId = orderId;
    }

    /*入住房间*/
    private Room roomObj;
    public Room getRoomObj() {
        return roomObj;
    }
    public void setRoomObj(Room roomObj) {
        this.roomObj = roomObj;
    }

    /*入住老人*/
    private OldMan oldManObj;
    public OldMan getOldManObj() {
        return oldManObj;
    }
    public void setOldManObj(OldMan oldManObj) {
        this.oldManObj = oldManObj;
    }

    /*入住日期*/
    @NotEmpty(message="入住日期不能为空")
    private String liveDate;
    public String getLiveDate() {
        return liveDate;
    }
    public void setLiveDate(String liveDate) {
        this.liveDate = liveDate;
    }

    /*入住时间*/
    @NotNull(message="必须输入入住时间")
    private Integer monthNum;
    public Integer getMonthNum() {
        return monthNum;
    }
    public void setMonthNum(Integer monthNum) {
        this.monthNum = monthNum;
    }

    /*订单总金额*/
    @NotNull(message="必须输入订单总金额")
    private Float orderMoney;
    public Float getOrderMoney() {
        return orderMoney;
    }
    public void setOrderMoney(Float orderMoney) {
        this.orderMoney = orderMoney;
    }

    /*订单状态*/
    @NotEmpty(message="订单状态不能为空")
    private String orderState;
    public String getOrderState() {
        return orderState;
    }
    public void setOrderState(String orderState) {
        this.orderState = orderState;
    }

    /*订单费用明细*/
    private String orderDesc;
    public String getOrderDesc() {
        return orderDesc;
    }
    public void setOrderDesc(String orderDesc) {
        this.orderDesc = orderDesc;
    }

    /*订单时间*/
    private String orderTime;
    public String getOrderTime() {
        return orderTime;
    }
    public void setOrderTime(String orderTime) {
        this.orderTime = orderTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonRoomOrder=new JSONObject(); 
		jsonRoomOrder.accumulate("orderId", this.getOrderId());
		jsonRoomOrder.accumulate("roomObj", this.getRoomObj().getRoomName());
		jsonRoomOrder.accumulate("roomObjPri", this.getRoomObj().getRoomNo());
		jsonRoomOrder.accumulate("oldManObj", this.getOldManObj().getName());
		jsonRoomOrder.accumulate("oldManObjPri", this.getOldManObj().getOldManId());
		jsonRoomOrder.accumulate("liveDate", this.getLiveDate().length()>19?this.getLiveDate().substring(0,19):this.getLiveDate());
		jsonRoomOrder.accumulate("monthNum", this.getMonthNum());
		jsonRoomOrder.accumulate("orderMoney", this.getOrderMoney());
		jsonRoomOrder.accumulate("orderState", this.getOrderState());
		jsonRoomOrder.accumulate("orderDesc", this.getOrderDesc());
		jsonRoomOrder.accumulate("orderTime", this.getOrderTime().length()>19?this.getOrderTime().substring(0,19):this.getOrderTime());
		return jsonRoomOrder;
    }}