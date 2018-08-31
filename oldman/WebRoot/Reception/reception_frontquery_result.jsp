<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.Reception" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Reception> receptionList = (List<Reception>)request.getAttribute("receptionList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String receptType = (String)request.getAttribute("receptType"); //接待类别查询关键字
    String title = (String)request.getAttribute("title"); //接待主题查询关键字
    String receptDate = (String)request.getAttribute("receptDate"); //接待日期查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>接待查询</title>
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
			    	<li role="presentation" class="active"><a href="#receptionListPanel" aria-controls="receptionListPanel" role="tab" data-toggle="tab">接待列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Reception/reception_frontAdd.jsp" style="display:none;">添加接待</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="receptionListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>接待记录id</td><td>接待类别</td><td>接待主题</td><td>接待日期</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<receptionList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Reception reception = receptionList.get(i); //获取到接待对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=reception.getReceptionId() %></td>
 											<td><%=reception.getReceptType() %></td>
 											<td><%=reception.getTitle() %></td>
 											<td><%=reception.getReceptDate() %></td>
 											<td>
 												<a href="<%=basePath  %>Reception/<%=reception.getReceptionId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="receptionEdit('<%=reception.getReceptionId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="receptionDelete('<%=reception.getReceptionId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>接待查询</h1>
		</div>
		<form name="receptionQueryForm" id="receptionQueryForm" action="<%=basePath %>Reception/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="receptType">接待类别:</label>
				<input type="text" id="receptType" name="receptType" value="<%=receptType %>" class="form-control" placeholder="请输入接待类别">
			</div>






			<div class="form-group">
				<label for="title">接待主题:</label>
				<input type="text" id="title" name="title" value="<%=title %>" class="form-control" placeholder="请输入接待主题">
			</div>






			<div class="form-group">
				<label for="receptDate">接待日期:</label>
				<input type="text" id="receptDate" name="receptDate" class="form-control"  placeholder="请选择接待日期" value="<%=receptDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="receptionEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;接待信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="receptionEditForm" id="receptionEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="reception_receptionId_edit" class="col-md-3 text-right">接待记录id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="reception_receptionId_edit" name="reception.receptionId" class="form-control" placeholder="请输入接待记录id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="reception_receptType_edit" class="col-md-3 text-right">接待类别:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="reception_receptType_edit" name="reception.receptType" class="form-control" placeholder="请输入接待类别">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="reception_title_edit" class="col-md-3 text-right">接待主题:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="reception_title_edit" name="reception.title" class="form-control" placeholder="请输入接待主题">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="reception_content_edit" class="col-md-3 text-right">接待内容:</label>
		  	 <div class="col-md-9">
			 	<textarea name="reception.content" id="reception_content_edit" style="width:100%;height:500px;"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="reception_receptDate_edit" class="col-md-3 text-right">接待日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date reception_receptDate_edit col-md-12" data-link-field="reception_receptDate_edit"  data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="reception_receptDate_edit" name="reception.receptDate" size="16" type="text" value="" placeholder="请选择接待日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		</form> 
	    <style>#receptionEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxReceptionModify();">提交</button>
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
var reception_content_edit = UE.getEditor('reception_content_edit'); //接待内容编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.receptionQueryForm.currentPage.value = currentPage;
    document.receptionQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.receptionQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.receptionQueryForm.currentPage.value = pageValue;
    documentreceptionQueryForm.submit();
}

/*弹出修改接待界面并初始化数据*/
function receptionEdit(receptionId) {
	$.ajax({
		url :  basePath + "Reception/" + receptionId + "/update",
		type : "get",
		dataType: "json",
		success : function (reception, response, status) {
			if (reception) {
				$("#reception_receptionId_edit").val(reception.receptionId);
				$("#reception_receptType_edit").val(reception.receptType);
				$("#reception_title_edit").val(reception.title);
				reception_content_edit.setContent(reception.content, false);
				$("#reception_receptDate_edit").val(reception.receptDate);
				$('#receptionEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除接待信息*/
function receptionDelete(receptionId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Reception/deletes",
			data : {
				receptionIds : receptionId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#receptionQueryForm").submit();
					//location.href= basePath + "Reception/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交接待信息表单给服务器端修改*/
function ajaxReceptionModify() {
	$.ajax({
		url :  basePath + "Reception/" + $("#reception_receptionId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#receptionEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#receptionQueryForm").submit();
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

    /*接待日期组件*/
    $('.reception_receptDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
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

