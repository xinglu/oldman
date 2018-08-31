$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('reception_content_edit');
	var reception_content_edit = UE.getEditor('reception_content_edit'); //接待内容编辑器
	reception_content_edit.addListener("ready", function () {
		 // editor准备好之后才可以使用 
		 ajaxModifyQuery();
	}); 
  function ajaxModifyQuery() {	
	$.ajax({
		url : "Reception/" + $("#reception_receptionId_edit").val() + "/update",
		type : "get",
		data : {
			//receptionId : $("#reception_receptionId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (reception, response, status) {
			$.messager.progress("close");
			if (reception) { 
				$("#reception_receptionId_edit").val(reception.receptionId);
				$("#reception_receptionId_edit").validatebox({
					required : true,
					missingMessage : "请输入接待记录id",
					editable: false
				});
				$("#reception_receptType_edit").val(reception.receptType);
				$("#reception_receptType_edit").validatebox({
					required : true,
					missingMessage : "请输入接待类别",
				});
				$("#reception_title_edit").val(reception.title);
				$("#reception_title_edit").validatebox({
					required : true,
					missingMessage : "请输入接待主题",
				});
				reception_content_edit.setContent(reception.content);
				$("#reception_receptDate_edit").datebox({
					value: reception.receptDate,
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

	$("#receptionModifyButton").click(function(){ 
		if ($("#receptionEditForm").form("validate")) {
			$("#receptionEditForm").form({
			    url:"Reception/" +  $("#reception_receptionId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#receptionEditForm").form("validate"))  {
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
			$("#receptionEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
