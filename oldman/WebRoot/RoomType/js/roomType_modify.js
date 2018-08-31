$(function () {
	$.ajax({
		url : "RoomType/" + $("#roomType_typeId_edit").val() + "/update",
		type : "get",
		data : {
			//typeId : $("#roomType_typeId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (roomType, response, status) {
			$.messager.progress("close");
			if (roomType) { 
				$("#roomType_typeId_edit").val(roomType.typeId);
				$("#roomType_typeId_edit").validatebox({
					required : true,
					missingMessage : "请输入房间类型id",
					editable: false
				});
				$("#roomType_typeName_edit").val(roomType.typeName);
				$("#roomType_typeName_edit").validatebox({
					required : true,
					missingMessage : "请输入房间类型名称",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#roomTypeModifyButton").click(function(){ 
		if ($("#roomTypeEditForm").form("validate")) {
			$("#roomTypeEditForm").form({
			    url:"RoomType/" +  $("#roomType_typeId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#roomTypeEditForm").form("validate"))  {
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
			$("#roomTypeEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
