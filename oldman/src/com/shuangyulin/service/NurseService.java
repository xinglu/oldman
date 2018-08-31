package com.shuangyulin.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.shuangyulin.po.Nurse;

import com.shuangyulin.mapper.NurseMapper;
@Service
public class NurseService {

	@Resource NurseMapper nurseMapper;
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

    /*添加老人看护记录*/
    public void addNurse(Nurse nurse) throws Exception {
    	nurseMapper.addNurse(nurse);
    }

    /*按照查询条件分页查询老人看护记录*/
    public ArrayList<Nurse> queryNurse(String nurseType,String title,String publishDate,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!nurseType.equals("")) where = where + " and t_nurse.nurseType like '%" + nurseType + "%'";
    	if(!title.equals("")) where = where + " and t_nurse.title like '%" + title + "%'";
    	if(!publishDate.equals("")) where = where + " and t_nurse.publishDate like '%" + publishDate + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return nurseMapper.queryNurse(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Nurse> queryNurse(String nurseType,String title,String publishDate) throws Exception  { 
     	String where = "where 1=1";
    	if(!nurseType.equals("")) where = where + " and t_nurse.nurseType like '%" + nurseType + "%'";
    	if(!title.equals("")) where = where + " and t_nurse.title like '%" + title + "%'";
    	if(!publishDate.equals("")) where = where + " and t_nurse.publishDate like '%" + publishDate + "%'";
    	return nurseMapper.queryNurseList(where);
    }

    /*查询所有老人看护记录*/
    public ArrayList<Nurse> queryAllNurse()  throws Exception {
        return nurseMapper.queryNurseList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String nurseType,String title,String publishDate) throws Exception {
     	String where = "where 1=1";
    	if(!nurseType.equals("")) where = where + " and t_nurse.nurseType like '%" + nurseType + "%'";
    	if(!title.equals("")) where = where + " and t_nurse.title like '%" + title + "%'";
    	if(!publishDate.equals("")) where = where + " and t_nurse.publishDate like '%" + publishDate + "%'";
        recordNumber = nurseMapper.queryNurseCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取老人看护记录*/
    public Nurse getNurse(int nurseId) throws Exception  {
        Nurse nurse = nurseMapper.getNurse(nurseId);
        return nurse;
    }

    /*更新老人看护记录*/
    public void updateNurse(Nurse nurse) throws Exception {
        nurseMapper.updateNurse(nurse);
    }

    /*删除一条老人看护记录*/
    public void deleteNurse (int nurseId) throws Exception {
        nurseMapper.deleteNurse(nurseId);
    }

    /*删除多条老人看护信息*/
    public int deleteNurses (String nurseIds) throws Exception {
    	String _nurseIds[] = nurseIds.split(",");
    	for(String _nurseId: _nurseIds) {
    		nurseMapper.deleteNurse(Integer.parseInt(_nurseId));
    	}
    	return _nurseIds.length;
    }
}
