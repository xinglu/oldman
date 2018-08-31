package com.shuangyulin.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.shuangyulin.utils.ExportExcelUtil;
import com.shuangyulin.utils.UserException;
import com.shuangyulin.service.NurseService;
import com.shuangyulin.po.Nurse;

//Nurse管理控制层
@Controller
@RequestMapping("/Nurse")
public class NurseController extends BaseController {

    /*业务层对象*/
    @Resource NurseService nurseService;

	@InitBinder("nurse")
	public void initBinderNurse(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("nurse.");
	}
	/*跳转到添加Nurse视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Nurse());
		return "Nurse_add";
	}

	/*客户端ajax方式提交添加老人看护信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Nurse nurse, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        nurseService.addNurse(nurse);
        message = "老人看护添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询老人看护信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String nurseType,String title,String publishDate,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (nurseType == null) nurseType = "";
		if (title == null) title = "";
		if (publishDate == null) publishDate = "";
		if(rows != 0)nurseService.setRows(rows);
		List<Nurse> nurseList = nurseService.queryNurse(nurseType, title, publishDate, page);
	    /*计算总的页数和总的记录数*/
	    nurseService.queryTotalPageAndRecordNumber(nurseType, title, publishDate);
	    /*获取到总的页码数目*/
	    int totalPage = nurseService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = nurseService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Nurse nurse:nurseList) {
			JSONObject jsonNurse = nurse.getJsonObject();
			jsonArray.put(jsonNurse);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询老人看护信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Nurse> nurseList = nurseService.queryAllNurse();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Nurse nurse:nurseList) {
			JSONObject jsonNurse = new JSONObject();
			jsonNurse.accumulate("nurseId", nurse.getNurseId());
			jsonNurse.accumulate("title", nurse.getTitle());
			jsonArray.put(jsonNurse);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询老人看护信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String nurseType,String title,String publishDate,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (nurseType == null) nurseType = "";
		if (title == null) title = "";
		if (publishDate == null) publishDate = "";
		List<Nurse> nurseList = nurseService.queryNurse(nurseType, title, publishDate, currentPage);
	    /*计算总的页数和总的记录数*/
	    nurseService.queryTotalPageAndRecordNumber(nurseType, title, publishDate);
	    /*获取到总的页码数目*/
	    int totalPage = nurseService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = nurseService.getRecordNumber();
	    request.setAttribute("nurseList",  nurseList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("nurseType", nurseType);
	    request.setAttribute("title", title);
	    request.setAttribute("publishDate", publishDate);
		return "Nurse/nurse_frontquery_result"; 
	}

     /*前台查询Nurse信息*/
	@RequestMapping(value="/{nurseId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer nurseId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键nurseId获取Nurse对象*/
        Nurse nurse = nurseService.getNurse(nurseId);

        request.setAttribute("nurse",  nurse);
        return "Nurse/nurse_frontshow";
	}

	/*ajax方式显示老人看护修改jsp视图页*/
	@RequestMapping(value="/{nurseId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer nurseId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键nurseId获取Nurse对象*/
        Nurse nurse = nurseService.getNurse(nurseId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonNurse = nurse.getJsonObject();
		out.println(jsonNurse.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新老人看护信息*/
	@RequestMapping(value = "/{nurseId}/update", method = RequestMethod.POST)
	public void update(@Validated Nurse nurse, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			nurseService.updateNurse(nurse);
			message = "老人看护更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "老人看护更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除老人看护信息*/
	@RequestMapping(value="/{nurseId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer nurseId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  nurseService.deleteNurse(nurseId);
	            request.setAttribute("message", "老人看护删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "老人看护删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条老人看护记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String nurseIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = nurseService.deleteNurses(nurseIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出老人看护信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String nurseType,String title,String publishDate, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(nurseType == null) nurseType = "";
        if(title == null) title = "";
        if(publishDate == null) publishDate = "";
        List<Nurse> nurseList = nurseService.queryNurse(nurseType,title,publishDate);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Nurse信息记录"; 
        String[] headers = { "记录id","信息类别","信息标题","发布时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<nurseList.size();i++) {
        	Nurse nurse = nurseList.get(i); 
        	dataset.add(new String[]{nurse.getNurseId() + "",nurse.getNurseType(),nurse.getTitle(),nurse.getPublishDate()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"Nurse.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
