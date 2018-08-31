package com.shuangyulin.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.shuangyulin.po.Department;

public interface DepartmentMapper {
	/*添加部门信息*/
	public void addDepartment(Department department) throws Exception;

	/*按照查询条件分页查询部门记录*/
	public ArrayList<Department> queryDepartment(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有部门记录*/
	public ArrayList<Department> queryDepartmentList(@Param("where") String where) throws Exception;

	/*按照查询条件的部门记录数*/
	public int queryDepartmentCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条部门记录*/
	public Department getDepartment(int departmentId) throws Exception;

	/*更新部门记录*/
	public void updateDepartment(Department department) throws Exception;

	/*删除部门记录*/
	public void deleteDepartment(int departmentId) throws Exception;

}
