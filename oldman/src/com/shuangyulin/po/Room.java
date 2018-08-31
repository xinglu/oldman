package com.shuangyulin.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Room {
    /*房间编号*/
    @NotEmpty(message="房间编号不能为空")
    private String roomNo;
    public String getRoomNo(){
        return roomNo;
    }
    public void setRoomNo(String roomNo){
        this.roomNo = roomNo;
    }

    /*房间类型*/
    private RoomType roomTypeObj;
    public RoomType getRoomTypeObj() {
        return roomTypeObj;
    }
    public void setRoomTypeObj(RoomType roomTypeObj) {
        this.roomTypeObj = roomTypeObj;
    }

    /*房间名称*/
    @NotEmpty(message="房间名称不能为空")
    private String roomName;
    public String getRoomName() {
        return roomName;
    }
    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    /*房间主图*/
    private String mainPhoto;
    public String getMainPhoto() {
        return mainPhoto;
    }
    public void setMainPhoto(String mainPhoto) {
        this.mainPhoto = mainPhoto;
    }

    /*房间价格*/
    @NotNull(message="必须输入房间价格")
    private Float price;
    public Float getPrice() {
        return price;
    }
    public void setPrice(Float price) {
        this.price = price;
    }

    /*房间详情*/
    private String roomDesc;
    public String getRoomDesc() {
        return roomDesc;
    }
    public void setRoomDesc(String roomDesc) {
        this.roomDesc = roomDesc;
    }

    /*房间状态*/
    @NotEmpty(message="房间状态不能为空")
    private String roomState;
    public String getRoomState() {
        return roomState;
    }
    public void setRoomState(String roomState) {
        this.roomState = roomState;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonRoom=new JSONObject(); 
		jsonRoom.accumulate("roomNo", this.getRoomNo());
		jsonRoom.accumulate("roomTypeObj", this.getRoomTypeObj().getTypeName());
		jsonRoom.accumulate("roomTypeObjPri", this.getRoomTypeObj().getTypeId());
		jsonRoom.accumulate("roomName", this.getRoomName());
		jsonRoom.accumulate("mainPhoto", this.getMainPhoto());
		jsonRoom.accumulate("price", this.getPrice());
		jsonRoom.accumulate("roomDesc", this.getRoomDesc());
		jsonRoom.accumulate("roomState", this.getRoomState());
		return jsonRoom;
    }}