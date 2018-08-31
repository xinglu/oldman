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
import com.shuangyulin.service.RoomOrderService;
import com.shuangyulin.po.RoomOrder;
import com.shuangyulin.service.OldManService;
import com.shuangyulin.po.OldMan;
import com.shuangyulin.service.RoomService;
import com.shuangyulin.po.Room;

//RoomOrder管理控制层
@Controller
@RequestMapping("/RoomOrder")
public class RoomOrderController extends BaseController {

    /*业务层对象*/
    @Resource RoomOrderService roomOrderService;

    @Resource OldManService oldManService;
    @Resource RoomService roomService;
	@InitBinder("roomObj")
	public void initBinderroomObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("roomObj.");
	}
	@InitBinder("oldManObj")
	public void initBinderoldManObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("oldManObj.");
	}
	@InitBinder("roomOrder")
	public void initBinderRoomOrder(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("roomOrder.");
	}
	/*跳转到添加RoomOrder视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new RoomOrder());
		/*查询所有的OldMan信息*/
		List<OldMan> oldManList = oldManService.queryAllOldMan();
		request.setAttribute("oldManList", oldManList);
		/*查询所有的Room信息*/
		List<Room> roomList = roomService.queryAllRoom();
		request.setAttribute("roomList", roomList);
		return "RoomOrder_add";
	}

	/*客户端ajax方式提交添加订单信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated RoomOrder roomOrder, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        roomOrderService.addRoomOrder(roomOrder);
        message = "订单添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询订单信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("roomObj") Room roomObj,@ModelAttribute("oldManObj") OldMan oldManObj,String liveDate,String orderState,String orderTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (liveDate == null) liveDate = "";
		if (orderState == null) orderState = "";
		if (orderTime == null) orderTime = "";
		if(rows != 0)roomOrderService.setRows(rows);
		List<RoomOrder> roomOrderList = roomOrderService.queryRoomOrder(roomObj, oldManObj, liveDate, orderState, orderTime, page);
	    /*计算总的页数和总的记录数*/
	    roomOrderService.queryTotalPageAndRecordNumber(roomObj, oldManObj, liveDate, orderState, orderTime);
	    /*获取到总的页码数目*/
	    int totalPage = roomOrderService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = roomOrderService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(RoomOrder roomOrder:roomOrderList) {
			JSONObject jsonRoomOrder = roomOrder.getJsonObject();
			jsonArray.put(jsonRoomOrder);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询订单信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<RoomOrder> roomOrderList = roomOrderService.queryAllRoomOrder();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(RoomOrder roomOrder:roomOrderList) {
			JSONObject jsonRoomOrder = new JSONObject();
			jsonRoomOrder.accumulate("orderId", roomOrder.getOrderId());
			jsonArray.put(jsonRoomOrder);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询订单信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("roomObj") Room roomObj,@ModelAttribute("oldManObj") OldMan oldManObj,String liveDate,String orderState,String orderTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (liveDate == null) liveDate = "";
		if (orderState == null) orderState = "";
		if (orderTime == null) orderTime = "";
		List<RoomOrder> roomOrderList = roomOrderService.queryRoomOrder(roomObj, oldManObj, liveDate, orderState, orderTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    roomOrderService.queryTotalPageAndRecordNumber(roomObj, oldManObj, liveDate, orderState, orderTime);
	    /*获取到总的页码数目*/
	    int totalPage = roomOrderService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = roomOrderService.getRecordNumber();
	    request.setAttribute("roomOrderList",  roomOrderList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("roomObj", roomObj);
	    request.setAttribute("oldManObj", oldManObj);
	    request.setAttribute("liveDate", liveDate);
	    request.setAttribute("orderState", orderState);
	    request.setAttribute("orderTime", orderTime);
	    List<OldMan> oldManList = oldManService.queryAllOldMan();
	    request.setAttribute("oldManList", oldManList);
	    List<Room> roomList = roomService.queryAllRoom();
	    request.setAttribute("roomList", roomList);
		return "RoomOrder/roomOrder_frontquery_result"; 
	}

     /*前台查询RoomOrder信息*/
	@RequestMapping(value="/{orderId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer orderId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键orderId获取RoomOrder对象*/
        RoomOrder roomOrder = roomOrderService.getRoomOrder(orderId);

        List<OldMan> oldManList = oldManService.queryAllOldMan();
        request.setAttribute("oldManList", oldManList);
        List<Room> roomList = roomService.queryAllRoom();
        request.setAttribute("roomList", roomList);
        request.setAttribute("roomOrder",  roomOrder);
        return "RoomOrder/roomOrder_frontshow";
	}

	/*ajax方式显示订单修改jsp视图页*/
	@RequestMapping(value="/{orderId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer orderId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键orderId获取RoomOrder对象*/
        RoomOrder roomOrder = roomOrderService.getRoomOrder(orderId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonRoomOrder = roomOrder.getJsonObject();
		out.println(jsonRoomOrder.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新订单信息*/
	@RequestMapping(value = "/{orderId}/update", method = RequestMethod.POST)
	public void update(@Validated RoomOrder roomOrder, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			roomOrderService.updateRoomOrder(roomOrder);
			message = "订单更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "订单更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除订单信息*/
	@RequestMapping(value="/{orderId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer orderId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  roomOrderService.deleteRoomOrder(orderId);
	            request.setAttribute("message", "订单删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "订单删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条订单记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String orderIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = roomOrderService.deleteRoomOrders(orderIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出订单信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("roomObj") Room roomObj,@ModelAttribute("oldManObj") OldMan oldManObj,String liveDate,String orderState,String orderTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(liveDate == null) liveDate = "";
        if(orderState == null) orderState = "";
        if(orderTime == null) orderTime = "";
        List<RoomOrder> roomOrderList = roomOrderService.queryRoomOrder(roomObj,oldManObj,liveDate,orderState,orderTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "RoomOrder信息记录"; 
        String[] headers = { "订单编号","入住房间","入住老人","入住日期","入住时间","订单总金额","订单状态","订单时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<roomOrderList.size();i++) {
        	RoomOrder roomOrder = roomOrderList.get(i); 
        	dataset.add(new String[]{roomOrder.getOrderId() + "",roomOrder.getRoomObj().getRoomName(),roomOrder.getOldManObj().getName(),roomOrder.getLiveDate(),roomOrder.getMonthNum() + "",roomOrder.getOrderMoney() + "",roomOrder.getOrderState(),roomOrder.getOrderTime()});
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
			response.setHeader("Content-disposition","attachment; filename="+"RoomOrder.xls");//filename是下载的xls的名，建议最好用英文 
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
