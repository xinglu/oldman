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
import com.shuangyulin.service.ReceptionService;
import com.shuangyulin.po.Reception;

//Reception管理控制层
@Controller
@RequestMapping("/Reception")
public class ReceptionController extends BaseController {

    /*业务层对象*/
    @Resource ReceptionService receptionService;

	@InitBinder("reception")
	public void initBinderReception(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("reception.");
	}
	/*跳转到添加Reception视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Reception());
		return "Reception_add";
	}

	/*客户端ajax方式提交添加接待信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Reception reception, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        receptionService.addReception(reception);
        message = "接待添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询接待信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String receptType,String title,String receptDate,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (receptType == null) receptType = "";
		if (title == null) title = "";
		if (receptDate == null) receptDate = "";
		if(rows != 0)receptionService.setRows(rows);
		List<Reception> receptionList = receptionService.queryReception(receptType, title, receptDate, page);
	    /*计算总的页数和总的记录数*/
	    receptionService.queryTotalPageAndRecordNumber(receptType, title, receptDate);
	    /*获取到总的页码数目*/
	    int totalPage = receptionService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = receptionService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Reception reception:receptionList) {
			JSONObject jsonReception = reception.getJsonObject();
			jsonArray.put(jsonReception);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询接待信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Reception> receptionList = receptionService.queryAllReception();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Reception reception:receptionList) {
			JSONObject jsonReception = new JSONObject();
			jsonReception.accumulate("receptionId", reception.getReceptionId());
			jsonReception.accumulate("title", reception.getTitle());
			jsonArray.put(jsonReception);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询接待信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String receptType,String title,String receptDate,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (receptType == null) receptType = "";
		if (title == null) title = "";
		if (receptDate == null) receptDate = "";
		List<Reception> receptionList = receptionService.queryReception(receptType, title, receptDate, currentPage);
	    /*计算总的页数和总的记录数*/
	    receptionService.queryTotalPageAndRecordNumber(receptType, title, receptDate);
	    /*获取到总的页码数目*/
	    int totalPage = receptionService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = receptionService.getRecordNumber();
	    request.setAttribute("receptionList",  receptionList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("receptType", receptType);
	    request.setAttribute("title", title);
	    request.setAttribute("receptDate", receptDate);
		return "Reception/reception_frontquery_result"; 
	}

     /*前台查询Reception信息*/
	@RequestMapping(value="/{receptionId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer receptionId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键receptionId获取Reception对象*/
        Reception reception = receptionService.getReception(receptionId);

        request.setAttribute("reception",  reception);
        return "Reception/reception_frontshow";
	}

	/*ajax方式显示接待修改jsp视图页*/
	@RequestMapping(value="/{receptionId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer receptionId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键receptionId获取Reception对象*/
        Reception reception = receptionService.getReception(receptionId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonReception = reception.getJsonObject();
		out.println(jsonReception.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新接待信息*/
	@RequestMapping(value = "/{receptionId}/update", method = RequestMethod.POST)
	public void update(@Validated Reception reception, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			receptionService.updateReception(reception);
			message = "接待更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "接待更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除接待信息*/
	@RequestMapping(value="/{receptionId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer receptionId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  receptionService.deleteReception(receptionId);
	            request.setAttribute("message", "接待删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "接待删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条接待记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String receptionIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = receptionService.deleteReceptions(receptionIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出接待信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String receptType,String title,String receptDate, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(receptType == null) receptType = "";
        if(title == null) title = "";
        if(receptDate == null) receptDate = "";
        List<Reception> receptionList = receptionService.queryReception(receptType,title,receptDate);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Reception信息记录"; 
        String[] headers = { "接待记录id","接待类别","接待主题","接待日期"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<receptionList.size();i++) {
        	Reception reception = receptionList.get(i); 
        	dataset.add(new String[]{reception.getReceptionId() + "",reception.getReceptType(),reception.getTitle(),reception.getReceptDate()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Reception.xls");//filename是下载的xls的名，建议最好用英文 
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
