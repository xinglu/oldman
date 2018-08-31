$(function () {
	$.ajax({
		url : "Employee/" + $("#employee_employeeNo_edit").val() + "/update",
		type : "get",
		data : {
			//employeeNo : $("#employee_employeeNo_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (employee, response, status) {
			$.messager.progress("close");
			if (employee) { 
				$("#employee_employeeNo_edit").val(employee.employeeNo);
				$("#employee_employeeNo_edit").validatebox({
					required : true,
					missingMessage : "请输入用户名",
					editable: false
				});
				$("#employee_password_edit").val(employee.password);
				$("#employee_password_edit").validatebox({
					required : true,
					missingMessage : "请输入登录密码",
				});
				$("#employee_departmentObj_departmentId_edit").combobox({
					url:"Department/listAll",
					valueField:"departmentId",
					textField:"departName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#employee_departmentObj_departmentId_edit").combobox("select", employee.departmentObjPri);
						//var data = $("#employee_departmentObj_departmentId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#employee_departmentObj_departmentId_edit").combobox("select", data[0].departmentId);
						//}
					}
				});
				$("#employee_name_edit").val(employee.name);
				$("#employee_name_edit").validatebox({
					required : true,
					missingMessage : "请输入姓名",
				});
				$("#employee_gender_edit").val(employee.gender);
				$("#employee_gender_edit").validatebox({
					required : true,
					missingMessage : "请输入性别",
				});
				$("#employee_birthDate_edit").datebox({
					value: employee.birthDate,
					required: true,
					showSeconds: true,
				});
				$("#employee_employeePhoto").val(employee.employeePhoto);
				$("#employee_employeePhotoImg").attr("src", employee.employeePhoto);
				$("#employee_telephone_edit").val(employee.telephone);
				$("#employee_telephone_edit").validatebox({
					required : true,
					missingMessage : "请输入联系电话",
				});
				$("#employee_address_edit").val(employee.address);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#employeeModifyButton").click(function(){ 
		if ($("#employeeEditForm").form("validate")) {
			$("#employeeEditForm").form({
			    url:"Employee/" +  $("#employee_employeeNo_edit").val() + "/update",
			    onSubmit: function(){
					if($("#employeeEditForm").form("validate"))  {
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
			$("#employeeEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
