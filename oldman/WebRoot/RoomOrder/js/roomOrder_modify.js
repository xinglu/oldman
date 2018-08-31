$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('roomOrder_orderDesc_edit');
	var roomOrder_orderDesc_edit = UE.getEditor('roomOrder_orderDesc_edit'); //订单费用明细编辑器
	roomOrder_orderDesc_edit.addListener("ready", function () {
		 // editor准备好之后才可以使用 
		 ajaxModifyQuery();
	}); 
  function ajaxModifyQuery() {	
	$.ajax({
		url : "RoomOrder/" + $("#roomOrder_orderId_edit").val() + "/update",
		type : "get",
		data : {
			//orderId : $("#roomOrder_orderId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (roomOrder, response, status) {
			$.messager.progress("close");
			if (roomOrder) { 
				$("#roomOrder_orderId_edit").val(roomOrder.orderId);
				$("#roomOrder_orderId_edit").validatebox({
					required : true,
					missingMessage : "请输入订单编号",
					editable: false
				});
				$("#roomOrder_roomObj_roomNo_edit").combobox({
					url:"Room/listAll",
					valueField:"roomNo",
					textField:"roomName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#roomOrder_roomObj_roomNo_edit").combobox("select", roomOrder.roomObjPri);
						//var data = $("#roomOrder_roomObj_roomNo_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#roomOrder_roomObj_roomNo_edit").combobox("select", data[0].roomNo);
						//}
					}
				});
				$("#roomOrder_oldManObj_oldManId_edit").combobox({
					url:"OldMan/listAll",
					valueField:"oldManId",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#roomOrder_oldManObj_oldManId_edit").combobox("select", roomOrder.oldManObjPri);
						//var data = $("#roomOrder_oldManObj_oldManId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#roomOrder_oldManObj_oldManId_edit").combobox("select", data[0].oldManId);
						//}
					}
				});
				$("#roomOrder_liveDate_edit").datebox({
					value: roomOrder.liveDate,
					required: true,
					showSeconds: true,
				});
				$("#roomOrder_monthNum_edit").val(roomOrder.monthNum);
				$("#roomOrder_monthNum_edit").validatebox({
					required : true,
					validType : "integer",
					missingMessage : "请输入入住时间",
					invalidMessage : "入住时间输入不对",
				});
				$("#roomOrder_orderMoney_edit").val(roomOrder.orderMoney);
				$("#roomOrder_orderMoney_edit").validatebox({
					required : true,
					validType : "number",
					missingMessage : "请输入订单总金额",
					invalidMessage : "订单总金额输入不对",
				});
				$("#roomOrder_orderState_edit").val(roomOrder.orderState);
				$("#roomOrder_orderState_edit").validatebox({
					required : true,
					missingMessage : "请输入订单状态",
				});
				roomOrder_orderDesc_edit.setContent(roomOrder.orderDesc);
				$("#roomOrder_orderTime_edit").datetimebox({
					value: roomOrder.orderTime,
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

	$("#roomOrderModifyButton").click(function(){ 
		if ($("#roomOrderEditForm").form("validate")) {
			$("#roomOrderEditForm").form({
			    url:"RoomOrder/" +  $("#roomOrder_orderId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#roomOrderEditForm").form("validate"))  {
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
			$("#roomOrderEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
