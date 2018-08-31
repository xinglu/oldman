package com.shuangyulin.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.shuangyulin.po.Room;
import com.shuangyulin.po.OldMan;
import com.shuangyulin.po.RoomOrder;

import com.shuangyulin.mapper.RoomOrderMapper;
@Service
public class RoomOrderService {

	@Resource RoomOrderMapper roomOrderMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加订单记录*/
    public void addRoomOrder(RoomOrder roomOrder) throws Exception {
    	roomOrderMapper.addRoomOrder(roomOrder);
    }

    /*按照查询条件分页查询订单记录*/
    public ArrayList<RoomOrder> queryRoomOrder(Room roomObj,OldMan oldManObj,String liveDate,String orderState,String orderTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != roomObj &&  roomObj.getRoomNo() != null  && !roomObj.getRoomNo().equals(""))  where += " and t_roomOrder.roomObj='" + roomObj.getRoomNo() + "'";
    	if(null != oldManObj && oldManObj.getOldManId()!= null && oldManObj.getOldManId()!= 0)  where += " and t_roomOrder.oldManObj=" + oldManObj.getOldManId();
    	if(!liveDate.equals("")) where = where + " and t_roomOrder.liveDate like '%" + liveDate + "%'";
    	if(!orderState.equals("")) where = where + " and t_roomOrder.orderState like '%" + orderState + "%'";
    	if(!orderTime.equals("")) where = where + " and t_roomOrder.orderTime like '%" + orderTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return roomOrderMapper.queryRoomOrder(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<RoomOrder> queryRoomOrder(Room roomObj,OldMan oldManObj,String liveDate,String orderState,String orderTime) throws Exception  { 
     	String where = "where 1=1";
    	if(null != roomObj &&  roomObj.getRoomNo() != null && !roomObj.getRoomNo().equals(""))  where += " and t_roomOrder.roomObj='" + roomObj.getRoomNo() + "'";
    	if(null != oldManObj && oldManObj.getOldManId()!= null && oldManObj.getOldManId()!= 0)  where += " and t_roomOrder.oldManObj=" + oldManObj.getOldManId();
    	if(!liveDate.equals("")) where = where + " and t_roomOrder.liveDate like '%" + liveDate + "%'";
    	if(!orderState.equals("")) where = where + " and t_roomOrder.orderState like '%" + orderState + "%'";
    	if(!orderTime.equals("")) where = where + " and t_roomOrder.orderTime like '%" + orderTime + "%'";
    	return roomOrderMapper.queryRoomOrderList(where);
    }

    /*查询所有订单记录*/
    public ArrayList<RoomOrder> queryAllRoomOrder()  throws Exception {
        return roomOrderMapper.queryRoomOrderList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Room roomObj,OldMan oldManObj,String liveDate,String orderState,String orderTime) throws Exception {
     	String where = "where 1=1";
    	if(null != roomObj &&  roomObj.getRoomNo() != null && !roomObj.getRoomNo().equals(""))  where += " and t_roomOrder.roomObj='" + roomObj.getRoomNo() + "'";
    	if(null != oldManObj && oldManObj.getOldManId()!= null && oldManObj.getOldManId()!= 0)  where += " and t_roomOrder.oldManObj=" + oldManObj.getOldManId();
    	if(!liveDate.equals("")) where = where + " and t_roomOrder.liveDate like '%" + liveDate + "%'";
    	if(!orderState.equals("")) where = where + " and t_roomOrder.orderState like '%" + orderState + "%'";
    	if(!orderTime.equals("")) where = where + " and t_roomOrder.orderTime like '%" + orderTime + "%'";
        recordNumber = roomOrderMapper.queryRoomOrderCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取订单记录*/
    public RoomOrder getRoomOrder(int orderId) throws Exception  {
        RoomOrder roomOrder = roomOrderMapper.getRoomOrder(orderId);
        return roomOrder;
    }

    /*更新订单记录*/
    public void updateRoomOrder(RoomOrder roomOrder) throws Exception {
        roomOrderMapper.updateRoomOrder(roomOrder);
    }

    /*删除一条订单记录*/
    public void deleteRoomOrder (int orderId) throws Exception {
        roomOrderMapper.deleteRoomOrder(orderId);
    }

    /*删除多条订单信息*/
    public int deleteRoomOrders (String orderIds) throws Exception {
    	String _orderIds[] = orderIds.split(",");
    	for(String _orderId: _orderIds) {
    		roomOrderMapper.deleteRoomOrder(Integer.parseInt(_orderId));
    	}
    	return _orderIds.length;
    }
}
