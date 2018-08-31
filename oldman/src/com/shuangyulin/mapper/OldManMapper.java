package com.shuangyulin.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.shuangyulin.po.OldMan;

public interface OldManMapper {
	/*添加老人信息*/
	public void addOldMan(OldMan oldMan) throws Exception;

	/*按照查询条件分页查询老人记录*/
	public ArrayList<OldMan> queryOldMan(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有老人记录*/
	public ArrayList<OldMan> queryOldManList(@Param("where") String where) throws Exception;

	/*按照查询条件的老人记录数*/
	public int queryOldManCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条老人记录*/
	public OldMan getOldMan(int oldManId) throws Exception;

	/*更新老人记录*/
	public void updateOldMan(OldMan oldMan) throws Exception;

	/*删除老人记录*/
	public void deleteOldMan(int oldManId) throws Exception;

}
