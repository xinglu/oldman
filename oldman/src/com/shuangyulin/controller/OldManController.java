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
import com.shuangyulin.service.OldManService;
import com.shuangyulin.po.OldMan;
import com.shuangyulin.service.UserInfoService;
import com.shuangyulin.po.UserInfo;

//OldMan管理控制层
@Controller
@RequestMapping("/OldMan")
public class OldManController extends BaseController {

    /*业务层对象*/
    @Resource OldManService oldManService;

    @Resource UserInfoService userInfoService;
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("oldMan")
	public void initBinderOldMan(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("oldMan.");
	}
	/*跳转到添加OldMan视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new OldMan());
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "OldMan_add";
	}

	/*客户端ajax方式提交添加老人信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated OldMan oldMan, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			oldMan.setManPhoto(this.handlePhotoUpload(request, "manPhotoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        oldManService.addOldMan(oldMan);
        message = "老人添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询老人信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String name,@ModelAttribute("userObj") UserInfo userObj,String addTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (name == null) name = "";
		if (addTime == null) addTime = "";
		if(rows != 0)oldManService.setRows(rows);
		List<OldMan> oldManList = oldManService.queryOldMan(name, userObj, addTime, page);
	    /*计算总的页数和总的记录数*/
	    oldManService.queryTotalPageAndRecordNumber(name, userObj, addTime);
	    /*获取到总的页码数目*/
	    int totalPage = oldManService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = oldManService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(OldMan oldMan:oldManList) {
			JSONObject jsonOldMan = oldMan.getJsonObject();
			jsonArray.put(jsonOldMan);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询老人信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<OldMan> oldManList = oldManService.queryAllOldMan();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(OldMan oldMan:oldManList) {
			JSONObject jsonOldMan = new JSONObject();
			jsonOldMan.accumulate("oldManId", oldMan.getOldManId());
			jsonOldMan.accumulate("name", oldMan.getName());
			jsonArray.put(jsonOldMan);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询老人信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String name,@ModelAttribute("userObj") UserInfo userObj,String addTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (name == null) name = "";
		if (addTime == null) addTime = "";
		List<OldMan> oldManList = oldManService.queryOldMan(name, userObj, addTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    oldManService.queryTotalPageAndRecordNumber(name, userObj, addTime);
	    /*获取到总的页码数目*/
	    int totalPage = oldManService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = oldManService.getRecordNumber();
	    request.setAttribute("oldManList",  oldManList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("name", name);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("addTime", addTime);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "OldMan/oldMan_frontquery_result"; 
	}

     /*前台查询OldMan信息*/
	@RequestMapping(value="/{oldManId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer oldManId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键oldManId获取OldMan对象*/
        OldMan oldMan = oldManService.getOldMan(oldManId);

        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("oldMan",  oldMan);
        return "OldMan/oldMan_frontshow";
	}

	/*ajax方式显示老人修改jsp视图页*/
	@RequestMapping(value="/{oldManId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer oldManId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键oldManId获取OldMan对象*/
        OldMan oldMan = oldManService.getOldMan(oldManId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonOldMan = oldMan.getJsonObject();
		out.println(jsonOldMan.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新老人信息*/
	@RequestMapping(value = "/{oldManId}/update", method = RequestMethod.POST)
	public void update(@Validated OldMan oldMan, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String manPhotoFileName = this.handlePhotoUpload(request, "manPhotoFile");
		if(!manPhotoFileName.equals("upload/NoImage.jpg"))oldMan.setManPhoto(manPhotoFileName); 


		try {
			oldManService.updateOldMan(oldMan);
			message = "老人更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "老人更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除老人信息*/
	@RequestMapping(value="/{oldManId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer oldManId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  oldManService.deleteOldMan(oldManId);
	            request.setAttribute("message", "老人删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "老人删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条老人记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String oldManIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = oldManService.deleteOldMans(oldManIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出老人信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String name,@ModelAttribute("userObj") UserInfo userObj,String addTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(name == null) name = "";
        if(addTime == null) addTime = "";
        List<OldMan> oldManList = oldManService.queryOldMan(name,userObj,addTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "OldMan信息记录"; 
        String[] headers = { "老人编号","姓名","性别","年龄","老人照片","登记用户","登记时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<oldManList.size();i++) {
        	OldMan oldMan = oldManList.get(i); 
        	dataset.add(new String[]{oldMan.getOldManId() + "",oldMan.getName(),oldMan.getSex(),oldMan.getAge() + "",oldMan.getManPhoto(),oldMan.getUserObj().getName(),oldMan.getAddTime()});
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
			response.setHeader("Content-disposition","attachment; filename="+"OldMan.xls");//filename是下载的xls的名，建议最好用英文 
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
