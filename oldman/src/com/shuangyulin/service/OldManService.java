package com.shuangyulin.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.shuangyulin.po.UserInfo;
import com.shuangyulin.po.OldMan;

import com.shuangyulin.mapper.OldManMapper;
@Service
public class OldManService {

	@Resource OldManMapper oldManMapper;
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

    /*添加老人记录*/
    public void addOldMan(OldMan oldMan) throws Exception {
    	oldManMapper.addOldMan(oldMan);
    }

    /*按照查询条件分页查询老人记录*/
    public ArrayList<OldMan> queryOldMan(String name,UserInfo userObj,String addTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!name.equals("")) where = where + " and t_oldMan.name like '%" + name + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_oldMan.userObj='" + userObj.getUser_name() + "'";
    	if(!addTime.equals("")) where = where + " and t_oldMan.addTime like '%" + addTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return oldManMapper.queryOldMan(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<OldMan> queryOldMan(String name,UserInfo userObj,String addTime) throws Exception  { 
     	String where = "where 1=1";
    	if(!name.equals("")) where = where + " and t_oldMan.name like '%" + name + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_oldMan.userObj='" + userObj.getUser_name() + "'";
    	if(!addTime.equals("")) where = where + " and t_oldMan.addTime like '%" + addTime + "%'";
    	return oldManMapper.queryOldManList(where);
    }

    /*查询所有老人记录*/
    public ArrayList<OldMan> queryAllOldMan()  throws Exception {
        return oldManMapper.queryOldManList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String name,UserInfo userObj,String addTime) throws Exception {
     	String where = "where 1=1";
    	if(!name.equals("")) where = where + " and t_oldMan.name like '%" + name + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_oldMan.userObj='" + userObj.getUser_name() + "'";
    	if(!addTime.equals("")) where = where + " and t_oldMan.addTime like '%" + addTime + "%'";
        recordNumber = oldManMapper.queryOldManCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取老人记录*/
    public OldMan getOldMan(int oldManId) throws Exception  {
        OldMan oldMan = oldManMapper.getOldMan(oldManId);
        return oldMan;
    }

    /*更新老人记录*/
    public void updateOldMan(OldMan oldMan) throws Exception {
        oldManMapper.updateOldMan(oldMan);
    }

    /*删除一条老人记录*/
    public void deleteOldMan (int oldManId) throws Exception {
        oldManMapper.deleteOldMan(oldManId);
    }

    /*删除多条老人信息*/
    public int deleteOldMans (String oldManIds) throws Exception {
    	String _oldManIds[] = oldManIds.split(",");
    	for(String _oldManId: _oldManIds) {
    		oldManMapper.deleteOldMan(Integer.parseInt(_oldManId));
    	}
    	return _oldManIds.length;
    }
}
