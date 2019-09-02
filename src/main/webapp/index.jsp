<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/2/6
  Time: 23:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("path",request.getContextPath());
    %>
    <script src="${path}/static/js/jquery-1.12.4.min.js"></script>
    <link rel="stylesheet" href="${path}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <script src="${path}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

<!-- 员工修改模态框 -->
    <div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">员工修改</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <input type="text" name="empName" class="form-control" id="empName_update" placeholder="empName">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <input type="text" name="email" class="form-control" id="email_update" placeholder="email">
                                <span class="help-block"></span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender1_update" value="M" checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender2_updatee" value="F"> 女
                                </label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">deptName</label>
                            <div class="col-sm-3">
                                <select class="form-control" name="dId">
                                </select>
                            </div>
                        </div>
                    </form>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="emp_update">更新</button>
                </div>
            </div>
        </div>
    </div>


<!-- 员工新增模态框 -->
    <div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">员工添加</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <input type="text" name="empName" class="form-control" id="empName_add" placeholder="empName">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <input type="text" name="email" class="form-control" id="email_add" placeholder="email">
                                <span class="help-block"></span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender1_add" value="M" checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender2_add" value="F"> 女
                                </label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">deptName</label>
                            <div class="col-sm-3">
                                <select class="form-control" name="dId">
                                </select>
                            </div>
                        </div>
                    </form>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="emp_save">保存</button>
                </div>
            </div>
        </div>
    </div>


    <div class="container">
        <%--标题--%>
        <div class="row">
            <div class="col-md-12">
                <h2>SSM-CRUD</h2>
            </div>
        </div>
        <%--按钮--%>
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button class="btn btn-success" id="emp_add">新增</button>
                <button class="btn btn-danger" id="deleteAll_btn">删除</button>
            </div>
        </div>
        <%--表格数据--%>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover" id="table">
                    <thead>
                        <tr>
                            <td>
                                <input type="checkbox" id="check_all"/>
                            </td>
                            <td>序号</td>
                            <td>员工姓名</td>
                            <td>性别</td>
                            <td>邮箱</td>
                            <td>部门名称</td>
                            <td>操作</td>
                        </tr>
                    </thead>
                    <tbody>

                    </tbody>

                </table>
            </div>
        </div>
        <%--分页信息--%>
        <div class="row">
                <%--分布文字信息--%>
                <div class="col-md-6" id="page_info">

                </div>
                <%--分布条--%>
                <div class="col-md-6" id="page_nav">

                </div>
        </div>
    </div>
    <script type="text/javascript">

        var totalRecord , currentPage;
        $(function () {
            to_page(1);
        })

        function to_page(pn) {
            $.ajax({
                url: "${path}/emps",
                data: "pn="+pn,
                type: "get",
                success: function (result) {
                    build_emps_table(result);
                    build_page_info(result);
                    build_page_nav(result);
                }
            })
        }

        // 解析表格数据
        function build_emps_table(result) {
            $("#table tbody").empty();
            var emps = result.map.pageInfo.list;
            $.each(emps,function (index, item) {
                var checkBoxTd = $("<td></td>").append($("<input type='checkbox' class='check_item'>"));
                var empIdTd = $("<td></td>").append(item.empId);
                var empNameTd = $("<td></td>").append(item.empName);
                var genderTd = $("<td></td>").append(item.gender== "M"?"男":"女");
                var emailTd = $("<td></td>").append(item.email);
                var deptNameTd = $("<td></td>").append(item.dept.deptName);
                var editBtn = $("<button></button>").addClass("btn btn-info btn-sm edit_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append(" 编辑");
                // 为编辑按钮添加自定义属性
                editBtn.attr("emp_id", item.empId)
                var delBtn = $("<button></button>").addClass("btn btn-warning btn-sm delete_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append(" 删除");
                // 为删除按钮添加自定义属性
                delBtn.attr("emp_id", item.empId)
                var btn = $("<td></td>").append(editBtn).append(" ").append(delBtn);
                $("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(genderTd)
                    .append(emailTd).append(deptNameTd).append(btn).appendTo("#table tbody");
            })
        }

        // 解析分页信息
        function build_page_info(result) {
            $("#page_info").empty();
            $("#page_info").append("第"+result.map.pageInfo.pageNum+"页，共"+result.map.pageInfo.pages+"页，" +
                "总计"+result.map.pageInfo.total+"条");

            totalRecord = result.map.pageInfo.total;
            currentPage = result.map.pageInfo.pageNum;
        }

        function build_page_nav(result) {
            $("#page_nav").empty();
            var ul = $("<ul></ul>").addClass("pagination");

            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页"));
            var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
            if(result.map.pageInfo.hasPreviousPage == false){
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            }else {
                firstPageLi.click(function () {
                    to_page(1);
                })
                prePageLi.click(function () {
                    to_page(result.map.pageInfo.pageNum - 1);
                })
            }
            ul.append(firstPageLi).append(prePageLi);
            var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
            var lastPageLi = $("<li></li>").append($("<a></a>").append("末页"));
            if(result.map.pageInfo.hasNextPage == false){
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }else {
                nextPageLi.click(function () {
                    to_page(result.map.pageInfo.pageNum + 1);
                });
                lastPageLi.click(function () {
                    to_page(result.map.pageInfo.pages);
                });
            }

            $.each(result.map.pageInfo.navigatepageNums, function (index, item) {
                var numPageLi = $("<li></li>").append($("<a></a>").append(item));
                if(result.map.pageInfo.pageNum == item){
                    numPageLi.addClass("active");
                }
                numPageLi.click(function () {
                    to_page(item);
                })
                ul.append(numPageLi);
            });

            ul.append(nextPageLi).append(lastPageLi);

            var nav = $("<nav></nav>").append(ul);
            nav.appendTo("#page_nav");
        }

        // 点击新增按钮，弹出模态框
        $("#emp_add").click(function () {
            // 完整清空表单
            $("#empAddModal form")[0].reset();
            clsEle("#empName_add");
            clsEle("#email_add");
            getDepts("#empAddModal select");

            $("#empAddModal").modal({
                backdrop: "static"
            })
        })

        // 清除元素
        function clsEle(ele) {
            $(ele).parent().removeClass("has-error has-success");
            $(ele).next().text("");
        }



        //  获取部门信息，将部门名称显示到模态框
        function getDepts(ele) {
            $(ele).empty();
            $.ajax({
                url: "${path}/depts",
                type: "post",
                success: function (result) {
                   var depts = result.map.depts;
                   $.each(depts, function (index, item) {
                       var optionEle = $("<option></option>").append(item.deptName).attr("value", item.deptId);
                       optionEle.appendTo(ele);
                   })
                }
            })
        }

        // 校验用户名是否可用
        $("#empName_add").change(function () {
            var empName = $(this).val();
            $.ajax({
                url: "${path}/checkUser",
                type: "post",
                data: "empName="+empName,
                success: function (result) {
                    if(result.code == 200){
                        show_validate_msg("#empName_add","success","用户名可用");
                        $("#emp_save").attr("ajax-va","success");
                    }else {
                        show_validate_msg("#empName_add","error",result.map.val_msg);
                        $("#emp_save").attr("ajax-va","error");
                    }
                }
            })
        })

        // 点击保存，新增员工信息
        $("#emp_save").click(function () {
            /*if(!validate_add_form()){
                return false;
            }*/

            //  先判断用户名是否可用
            if($(this).attr("ajax-va") == "error"){
                return false;
            }

            $.ajax({
                url: "${path}/emp",
                type: "post",
                data: $("#empAddModal form").serialize(),
                success: function (result) {
                    if(result.code == 200){
                        $("#empAddModal").modal("hide");
                        to_page(totalRecord);
                    }else{
                        if(undefined != result.map.errField.email){
                            show_validate_msg("#email_add","error",result.map.errField.email);
                        }
                        if(undefined != result.map.errField.empName){
                            show_validate_msg("#empName_add","error",result.map.errField.empName);
                        }
                    }

                }

            })
        })

        function validate_add_form() {
            var mail = $("#email_add").val();
            var regMail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if (!regMail.test(mail)) {
                //alert("邮箱格式不合法");
                show_validate_msg("#email_add","error","邮箱格式不合法");
                return false;
            }else {
                show_validate_msg("#email_add","success","");
            }
            return true;
        }

        // 显示检验信息
        function show_validate_msg(ele, status, msg) {
            // 清除检验状态
            $(ele).parent().removeClass("has-success has-error");
            $(ele).next("span").text("");
            if("success" == status){
                $(ele).parent().addClass("has-success");
                $(ele).next("span").text(msg);
            }else if("error" == status){
                $(ele).parent().addClass("has-error");
                $(ele).next("span").text(msg);
            }
        }

        // 点击编辑按钮，弹出修改模态框
        $(document).on("click",".edit_btn", function () {
            getEmp($(this).attr("emp_id"));
            getDepts("#empUpdateModal select");
            $("#emp_update").attr("emp_id",$(this).attr("emp_id"));
            $("#empUpdateModal").modal({
                backdrop: "static"
            })
        })

        function getEmp(empId) {
            $.ajax({
                url: "${path}/emp/"+empId,
                type: "get",
                success: function (result) {
                    var empData = result.map.employee;
                    $("#empName_update").val(empData.empName);
                    $("#email_update").val(empData.email);
                    $("#empUpdateModal input[name=gender]").val([empData.gender]);
                    $("#empUpdateModal select").val(empData.dId);
                }
            })
        }
        
        // 点击更新按钮，完成修改
        $("#emp_update").click(function () {

            var mail = $("#email_update").val();
            var regMail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if (!regMail.test(mail)) {
                //alert("邮箱格式不合法");
                show_validate_msg("#email_update","error","邮箱格式不合法");
                return false;
            }else {
                show_validate_msg("#email_update","success","");
            }

            $.ajax({
                url: "${path}/emp/"+$(this).attr("emp_id"),
                type: "put",
                data: $("#empUpdateModal form").serialize(),
                success: function (result) {
                    $("#empUpdateModal").modal("hide");
                    to_page(currentPage);
                }
            })
        })
        
        //  点击删除按钮，单个删除
        $(document).on("click",".delete_btn", function () {
            var empName = $(this).parents("tr").find("td:eq(2)").text();
            if (confirm("确认删除【"+empName+"】吗？")){
                $.ajax({
                    url: "${path}/emp/"+$(this).attr("emp_id"),
                    type: "delete",
                    success: function (result) {
                        to_page(currentPage);
                    }
                })
            }
        })

        // 全选和全不选
        /*
        *   attr 获取checked 是undefind
        *   原生dom属性用 prop属性
        *   自定义属性用 attr
        * */
        $("#check_all").click(function () {
            $(".check_item").prop("checked", $(this).prop("checked"));
        })

        $(document).on("click",".check_item", function () {
            var flag = $(".check_item:checked").length==$(".check_item").length
            $("#check_all").prop("checked",flag);

        })

        // 批量删除
        $("#deleteAll_btn").click(function () {
            var empNames = "";
            var empIds = "";
            $.each($(".check_item:checked"), function () {
                empNames += $(this).parents("tr").find("td:eq(2)").text() + ", "
                empIds += $(this).parents("tr").find("td:eq(1)").text()+"-"
            })
            empNames = empNames.substring(0,empNames.length-2);
            empIds = empIds.substring(0,empIds.length-1);
            if (confirm("是否删除"+empNames+" 吗？")){
                $.ajax({
                    url: "${path}/emp/"+empIds,
                    type: "delete",
                    success: function (result) {
                        alert(result.reMessage);
                        to_page(currentPage);
                    }
                })
            }
        })
    </script>


</body>
</html>
