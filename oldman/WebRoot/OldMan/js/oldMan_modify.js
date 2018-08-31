$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('oldMan_manDesc_edit');
	var oldMan_manDesc_edit = UE.getEditor('oldMan_manDesc_edit'); //老人介绍编辑器
	oldMan_manDesc_edit.addListener("ready", function () {
		 // editor准备好之后才可以使用 
		 ajaxModifyQuery();
	}); 
  function ajaxModifyQuery() {	
	$.ajax({
		url : "OldMan/" + $("#oldMan_oldManId_edit").val() + "/update",
		type : "get",
		data : {
			//oldManId : $("#oldMan_oldManId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (oldMan, response, status) {
			$.messager.progress("close");
			if (oldMan) { 
				$("#oldMan_oldManId_edit").val(oldMan.oldManId);
				$("#oldMan_oldManId_edit").validatebox({
					required : true,
					missingMessage : "请输入老人编号",
					editable: false
				});
				$("#oldMan_name_edit").val(oldMan.name);
				$("#oldMan_name_edit").validatebox({
					required : true,
					missingMessage : "请输入姓名",
				});
				$("#oldMan_sex_edit").val(oldMan.sex);
				$("#oldMan_sex_edit").validatebox({
					required : true,
					missingMessage : "请输入性别",
				});
				$("#oldMan_age_edit").val(oldMan.age);
				$("#oldMan_age_edit").validatebox({
					required : true,
					validType : "integer",
					missingMessage : "请输入年龄",
					invalidMessage : "年龄输入不对",
				});
				$("#oldMan_manPhoto").val(oldMan.manPhoto);
				$("#oldMan_manPhotoImg").attr("src", oldMan.manPhoto);
				oldMan_manDesc_edit.setContent(oldMan.manDesc);
				$("#oldMan_userObj_user_name_edit").combobox({
					url:"UserInfo/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#oldMan_userObj_user_name_edit").combobox("select", oldMan.userObjPri);
						//var data = $("#oldMan_userObj_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#oldMan_userObj_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#oldMan_addTime_edit").datetimebox({
					value: oldMan.addTime,
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

	$("#oldManModifyButton").click(function(){ 
		if ($("#oldManEditForm").form("validate")) {
			$("#oldManEditForm").form({
			    url:"OldMan/" +  $("#oldMan_oldManId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#oldManEditForm").form("validate"))  {
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
			$("#oldManEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
