package com.shuangyulin.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.shuangyulin.po.Nurse;

public interface NurseMapper {
	/*添加老人看护信息*/
	public void addNurse(Nurse nurse) throws Exception;

	/*按照查询条件分页查询老人看护记录*/
	public ArrayList<Nurse> queryNurse(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有老人看护记录*/
	public ArrayList<Nurse> queryNurseList(@Param("where") String where) throws Exception;

	/*按照查询条件的老人看护记录数*/
	public int queryNurseCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条老人看护记录*/
	public Nurse getNurse(int nurseId) throws Exception;

	/*更新老人看护记录*/
	public void updateNurse(Nurse nurse) throws Exception;

	/*删除老人看护记录*/
	public void deleteNurse(int nurseId) throws Exception;

}
