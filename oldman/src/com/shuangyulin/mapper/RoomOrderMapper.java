package com.shuangyulin.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.shuangyulin.po.RoomOrder;

public interface RoomOrderMapper {
	/*添加订单信息*/
	public void addRoomOrder(RoomOrder roomOrder) throws Exception;

	/*按照查询条件分页查询订单记录*/
	public ArrayList<RoomOrder> queryRoomOrder(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有订单记录*/
	public ArrayList<RoomOrder> queryRoomOrderList(@Param("where") String where) throws Exception;

	/*按照查询条件的订单记录数*/
	public int queryRoomOrderCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条订单记录*/
	public RoomOrder getRoomOrder(int orderId) throws Exception;

	/*更新订单记录*/
	public void updateRoomOrder(RoomOrder roomOrder) throws Exception;

	/*删除订单记录*/
	public void deleteRoomOrder(int orderId) throws Exception;

}
