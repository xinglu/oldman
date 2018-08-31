<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.Nurse" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Nurse> nurseList = (List<Nurse>)request.getAttribute("nurseList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String nurseType = (String)request.getAttribute("nurseType"); //信息类别查询关键字
    String title = (String)request.getAttribute("title"); //信息标题查询关键字
    String publishDate = (String)request.getAttribute("publishDate"); //发布时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>老人看护查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#nurseListPanel" aria-controls="nurseListPanel" role="tab" data-toggle="tab">老人看护列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Nurse/nurse_frontAdd.jsp" style="display:none;">添加老人看护</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="nurseListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>记录id</td><td>信息类别</td><td>信息标题</td><td>发布时间</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<nurseList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Nurse nurse = nurseList.get(i); //获取到老人看护对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=nurse.getNurseId() %></td>
 											<td><%=nurse.getNurseType() %></td>
 											<td><%=nurse.getTitle() %></td>
 											<td><%=nurse.getPublishDate() %></td>
 											<td>
 												<a href="<%=basePath  %>Nurse/<%=nurse.getNurseId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="nurseEdit('<%=nurse.getNurseId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="nurseDelete('<%=nurse.getNurseId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

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
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>老人看护查询</h1>
		</div>
		<form name="nurseQueryForm" id="nurseQueryForm" action="<%=basePath %>Nurse/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="nurseType">信息类别:</label>
				<input type="text" id="nurseType" name="nurseType" value="<%=nurseType %>" class="form-control" placeholder="请输入信息类别">
			</div>






			<div class="form-group">
				<label for="title">信息标题:</label>
				<input type="text" id="title" name="title" value="<%=title %>" class="form-control" placeholder="请输入信息标题">
			</div>






			<div class="form-group">
				<label for="publishDate">发布时间:</label>
				<input type="text" id="publishDate" name="publishDate" class="form-control"  placeholder="请选择发布时间" value="<%=publishDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="nurseEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;老人看护信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="nurseEditForm" id="nurseEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="nurse_nurseId_edit" class="col-md-3 text-right">记录id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="nurse_nurseId_edit" name="nurse.nurseId" class="form-control" placeholder="请输入记录id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="nurse_nurseType_edit" class="col-md-3 text-right">信息类别:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="nurse_nurseType_edit" name="nurse.nurseType" class="form-control" placeholder="请输入信息类别">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="nurse_title_edit" class="col-md-3 text-right">信息标题:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="nurse_title_edit" name="nurse.title" class="form-control" placeholder="请输入信息标题">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="nurse_content_edit" class="col-md-3 text-right">信息内容:</label>
		  	 <div class="col-md-9">
			 	<textarea name="nurse.content" id="nurse_content_edit" style="width:100%;height:500px;"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="nurse_publishDate_edit" class="col-md-3 text-right">发布时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date nurse_publishDate_edit col-md-12" data-link-field="nurse_publishDate_edit">
                    <input class="form-control" id="nurse_publishDate_edit" name="nurse.publishDate" size="16" type="text" value="" placeholder="请选择发布时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		</form> 
	    <style>#nurseEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxNurseModify();">提交</button>
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
var nurse_content_edit = UE.getEditor('nurse_content_edit'); //信息内容编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.nurseQueryForm.currentPage.value = currentPage;
    document.nurseQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.nurseQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.nurseQueryForm.currentPage.value = pageValue;
    documentnurseQueryForm.submit();
}

/*弹出修改老人看护界面并初始化数据*/
function nurseEdit(nurseId) {
	$.ajax({
		url :  basePath + "Nurse/" + nurseId + "/update",
		type : "get",
		dataType: "json",
		success : function (nurse, response, status) {
			if (nurse) {
				$("#nurse_nurseId_edit").val(nurse.nurseId);
				$("#nurse_nurseType_edit").val(nurse.nurseType);
				$("#nurse_title_edit").val(nurse.title);
				nurse_content_edit.setContent(nurse.content, false);
				$("#nurse_publishDate_edit").val(nurse.publishDate);
				$('#nurseEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除老人看护信息*/
function nurseDelete(nurseId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Nurse/deletes",
			data : {
				nurseIds : nurseId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#nurseQueryForm").submit();
					//location.href= basePath + "Nurse/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交老人看护信息表单给服务器端修改*/
function ajaxNurseModify() {
	$.ajax({
		url :  basePath + "Nurse/" + $("#nurse_nurseId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#nurseEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#nurseQueryForm").submit();
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

    /*发布时间组件*/
    $('.nurse_publishDate_edit').datetimepicker({
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

