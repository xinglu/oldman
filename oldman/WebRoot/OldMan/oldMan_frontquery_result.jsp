<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.OldMan" %>
<%@ page import="com.shuangyulin.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<OldMan> oldManList = (List<OldMan>)request.getAttribute("oldManList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String name = (String)request.getAttribute("name"); //姓名查询关键字
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    String addTime = (String)request.getAttribute("addTime"); //登记时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>老人查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>OldMan/frontlist">老人信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>OldMan/oldMan_frontAdd.jsp" style="display:none;">添加老人</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<oldManList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		OldMan oldMan = oldManList.get(i); //获取到老人对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>OldMan/<%=oldMan.getOldManId() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=oldMan.getManPhoto()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		老人编号:<%=oldMan.getOldManId() %>
			     	</div>
			     	<div class="field">
	            		姓名:<%=oldMan.getName() %>
			     	</div>
			     	<div class="field">
	            		性别:<%=oldMan.getSex() %>
			     	</div>
			     	<div class="field">
	            		年龄:<%=oldMan.getAge() %>
			     	</div>
			     	<div class="field">
	            		登记用户:<%=oldMan.getUserObj().getName() %>
			     	</div>
			     	<div class="field">
	            		登记时间:<%=oldMan.getAddTime() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>OldMan/<%=oldMan.getOldManId() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="oldManEdit('<%=oldMan.getOldManId() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="oldManDelete('<%=oldMan.getOldManId() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

			<div class="row">
				<div class="col-md-12">
					<nav class="pull-left">
						<ul class="pagination">
							<li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
							<%
								int startPage = currentPage - 5;
								int endPage = currentPage + 5;
								if(startPage < 1) startPage=1;
								if(endPage > totalPage) endPage = totalPage;
								for(int i=startPage;i<=endPage;i++) {
							%>
							<li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
							<%  } %> 
							<li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						</ul>
					</nav>
					<div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
				</div>
			</div>
		</div>
	</div>

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>老人查询</h1>
		</div>
		<form name="oldManQueryForm" id="oldManQueryForm" action="<%=basePath %>OldMan/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="name">姓名:</label>
				<input type="text" id="name" name="name" value="<%=name %>" class="form-control" placeholder="请输入姓名">
			</div>
            <div class="form-group">
            	<label for="userObj_user_name">登记用户：</label>
                <select id="userObj_user_name" name="userObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj!=null && userObj.getUser_name()!=null && userObj.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="addTime">登记时间:</label>
				<input type="text" id="addTime" name="addTime" class="form-control"  placeholder="请选择登记时间" value="<%=addTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="oldManEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;老人信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="oldManEditForm" id="oldManEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="oldMan_oldManId_edit" class="col-md-3 text-right">老人编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="oldMan_oldManId_edit" name="oldMan.oldManId" class="form-control" placeholder="请输入老人编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="oldMan_name_edit" class="col-md-3 text-right">姓名:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="oldMan_name_edit" name="oldMan.name" class="form-control" placeholder="请输入姓名">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="oldMan_sex_edit" class="col-md-3 text-right">性别:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="oldMan_sex_edit" name="oldMan.sex" class="form-control" placeholder="请输入性别">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="oldMan_age_edit" class="col-md-3 text-right">年龄:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="oldMan_age_edit" name="oldMan.age" class="form-control" placeholder="请输入年龄">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="oldMan_manPhoto_edit" class="col-md-3 text-right">老人照片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="oldMan_manPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="oldMan_manPhoto" name="oldMan.manPhoto"/>
			    <input id="manPhotoFile" name="manPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="oldMan_manDesc_edit" class="col-md-3 text-right">老人介绍:</label>
		  	 <div class="col-md-9">
			 	<textarea name="oldMan.manDesc" id="oldMan_manDesc_edit" style="width:100%;height:500px;"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="oldMan_userObj_user_name_edit" class="col-md-3 text-right">登记用户:</label>
		  	 <div class="col-md-9">
			    <select id="oldMan_userObj_user_name_edit" name="oldMan.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="oldMan_addTime_edit" class="col-md-3 text-right">登记时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date oldMan_addTime_edit col-md-12" data-link-field="oldMan_addTime_edit">
                    <input class="form-control" id="oldMan_addTime_edit" name="oldMan.addTime" size="16" type="text" value="" placeholder="请选择登记时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		</form> 
	    <style>#oldManEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxOldManModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var oldMan_manDesc_edit = UE.getEditor('oldMan_manDesc_edit'); //老人介绍编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.oldManQueryForm.currentPage.value = currentPage;
    document.oldManQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.oldManQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.oldManQueryForm.currentPage.value = pageValue;
    documentoldManQueryForm.submit();
}

/*弹出修改老人界面并初始化数据*/
function oldManEdit(oldManId) {
	$.ajax({
		url :  basePath + "OldMan/" + oldManId + "/update",
		type : "get",
		dataType: "json",
		success : function (oldMan, response, status) {
			if (oldMan) {
				$("#oldMan_oldManId_edit").val(oldMan.oldManId);
				$("#oldMan_name_edit").val(oldMan.name);
				$("#oldMan_sex_edit").val(oldMan.sex);
				$("#oldMan_age_edit").val(oldMan.age);
				$("#oldMan_manPhoto").val(oldMan.manPhoto);
				$("#oldMan_manPhotoImg").attr("src", basePath +　oldMan.manPhoto);
				oldMan_manDesc_edit.setContent(oldMan.manDesc, false);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#oldMan_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#oldMan_userObj_user_name_edit").html(html);
		        		$("#oldMan_userObj_user_name_edit").val(oldMan.userObjPri);
					}
				});
				$("#oldMan_addTime_edit").val(oldMan.addTime);
				$('#oldManEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除老人信息*/
function oldManDelete(oldManId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "OldMan/deletes",
			data : {
				oldManIds : oldManId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#oldManQueryForm").submit();
					//location.href= basePath + "OldMan/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交老人信息表单给服务器端修改*/
function ajaxOldManModify() {
	$.ajax({
		url :  basePath + "OldMan/" + $("#oldMan_oldManId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#oldManEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#oldManQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
	/*小屏幕导航点击关闭菜单*/
    $('.navbar-collapse a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();

    /*登记时间组件*/
    $('.oldMan_addTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
})
</script>
</body>
</html>

