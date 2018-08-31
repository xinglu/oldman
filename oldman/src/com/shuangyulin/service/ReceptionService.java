package com.shuangyulin.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.shuangyulin.po.Reception;

import com.shuangyulin.mapper.ReceptionMapper;
@Service
public class ReceptionService {

	@Resource ReceptionMapper receptionMapper;
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

    /*添加接待记录*/
    public void addReception(Reception reception) throws Exception {
    	receptionMapper.addReception(reception);
    }

    /*按照查询条件分页查询接待记录*/
    public ArrayList<Reception> queryReception(String receptType,String title,String receptDate,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!receptType.equals("")) where = where + " and t_reception.receptType like '%" + receptType + "%'";
    	if(!title.equals("")) where = where + " and t_reception.title like '%" + title + "%'";
    	if(!receptDate.equals("")) where = where + " and t_reception.receptDate like '%" + receptDate + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return receptionMapper.queryReception(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Reception> queryReception(String receptType,String title,String receptDate) throws Exception  { 
     	String where = "where 1=1";
    	if(!receptType.equals("")) where = where + " and t_reception.receptType like '%" + receptType + "%'";
    	if(!title.equals("")) where = where + " and t_reception.title like '%" + title + "%'";
    	if(!receptDate.equals("")) where = where + " and t_reception.receptDate like '%" + receptDate + "%'";
    	return receptionMapper.queryReceptionList(where);
    }

    /*查询所有接待记录*/
    public ArrayList<Reception> queryAllReception()  throws Exception {
        return receptionMapper.queryReceptionList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String receptType,String title,String receptDate) throws Exception {
     	String where = "where 1=1";
    	if(!receptType.equals("")) where = where + " and t_reception.receptType like '%" + receptType + "%'";
    	if(!title.equals("")) where = where + " and t_reception.title like '%" + title + "%'";
    	if(!receptDate.equals("")) where = where + " and t_reception.receptDate like '%" + receptDate + "%'";
        recordNumber = receptionMapper.queryReceptionCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取接待记录*/
    public Reception getReception(int receptionId) throws Exception  {
        Reception reception = receptionMapper.getReception(receptionId);
        return reception;
    }

    /*更新接待记录*/
    public void updateReception(Reception reception) throws Exception {
        receptionMapper.updateReception(reception);
    }

    /*删除一条接待记录*/
    public void deleteReception (int receptionId) throws Exception {
        receptionMapper.deleteReception(receptionId);
    }

    /*删除多条接待信息*/
    public int deleteReceptions (String receptionIds) throws Exception {
    	String _receptionIds[] = receptionIds.split(",");
    	for(String _receptionId: _receptionIds) {
    		receptionMapper.deleteReception(Integer.parseInt(_receptionId));
    	}
    	return _receptionIds.length;
    }
}
