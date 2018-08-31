$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('nurse_content_edit');
	var nurse_content_edit = UE.getEditor('nurse_content_edit'); //信息内容编辑器
	nurse_content_edit.addListener("ready", function () {
		 // editor准备好之后才可以使用 
		 ajaxModifyQuery();
	}); 
  function ajaxModifyQuery() {	
	$.ajax({
		url : "Nurse/" + $("#nurse_nurseId_edit").val() + "/update",
		type : "get",
		data : {
			//nurseId : $("#nurse_nurseId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (nurse, response, status) {
			$.messager.progress("close");
			if (nurse) { 
				$("#nurse_nurseId_edit").val(nurse.nurseId);
				$("#nurse_nurseId_edit").validatebox({
					required : true,
					missingMessage : "请输入记录id",
					editable: false
				});
				$("#nurse_nurseType_edit").val(nurse.nurseType);
				$("#nurse_nurseType_edit").validatebox({
					required : true,
					missingMessage : "请输入信息类别",
				});
				$("#nurse_title_edit").val(nurse.title);
				$("#nurse_title_edit").validatebox({
					required : true,
					missingMessage : "请输入信息标题",
				});
				nurse_content_edit.setContent(nurse.content);
				$("#nurse_publishDate_edit").datetimebox({
					value: nurse.publishDate,
					required: true,
					showSeconds: true,
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

  }

	$("#nurseModifyButton").click(function(){ 
		if ($("#nurseEditForm").form("validate")) {
			$("#nurseEditForm").form({
			    url:"Nurse/" +  $("#nurse_nurseId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#nurseEditForm").form("validate"))  {
	                	$.messager.progress({
							text : "正在提交数据中...",
						});
	                	return true;
	                } else {
	                    return false;
	                }
			    },
			    success:function(data){
			    	$.messager.progress("close");
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#nurseEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
