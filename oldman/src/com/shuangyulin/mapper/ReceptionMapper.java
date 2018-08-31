package com.shuangyulin.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.shuangyulin.po.Reception;

public interface ReceptionMapper {
	/*添加接待信息*/
	public void addReception(Reception reception) throws Exception;

	/*按照查询条件分页查询接待记录*/
	public ArrayList<Reception> queryReception(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有接待记录*/
	public ArrayList<Reception> queryReceptionList(@Param("where") String where) throws Exception;

	/*按照查询条件的接待记录数*/
	public int queryReceptionCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条接待记录*/
	public Reception getReception(int receptionId) throws Exception;

	/*更新接待记录*/
	public void updateReception(Reception reception) throws Exception;

	/*删除接待记录*/
	public void deleteReception(int receptionId) throws Exception;

}
