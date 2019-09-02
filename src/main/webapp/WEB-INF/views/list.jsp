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
    <link href="${path}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${path}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
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
                <button class="btn btn-primary">新增</button>
                <button class="btn btn-danger">删除</button>
            </div>
        </div>
            <%--表格--%>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover">
                    <tr>
                        <th>序号</th>
                        <th>员工姓名</th>
                        <th>性别</th>
                        <th>邮箱</th>
                        <th>所属部门</th>
                        <th>操作</th>
                    </tr>

                    <C:forEach items="${pageInfo.list}" var="emp">
                        <tr>
                            <th>${emp.empId}</th>
                            <th>${emp.empName}</th>
                            <th>${emp.gender}</th>
                            <th>${emp.email}</th>
                            <th>${emp.dept.deptName}</th>
                            <th>
                                <button class="btn btn-info btn-xs">
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                    编辑
                                </button>
                                <button class="btn btn-warning btn-xs">
                                    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                    删除
                                </button>
                            </th>
                        </tr>
                    </C:forEach>
                </table>
            </div>
        </div>
            <%--分布信息--%>
        <div class="row">
            <div class="col-md-6">
                当前${pageInfo.pageNum}/${pageInfo.pages} 页,共有${pageInfo.total}条
            </div>

            <div class="col-md-6">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li><a href="${path}/emps?pn=1">首页</a></li>

                        <C:if test="${pageInfo.hasPreviousPage}">
                            <li>
                                <a href="${path}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </C:if>

                        <C:forEach items="${pageInfo.navigatepageNums}" var="page">
                            <C:if test="${pageInfo.pageNum == page}">
                            <li class="active"><a href="#">${page}</a></li>
                        </C:if>
                            <C:if test="${pageInfo.pageNum != page}">
                                <li><a href="${path}/emps?pn=${page}">${page}</a></li>
                            </C:if>
                        </C:forEach>

                        <C:if test="${pageInfo.hasNextPage}">
                            <li>
                                <a href="${path}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </C:if>

                        <li><a href="${path}/emps?pn=${pageInfo.pages}">末页</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</body>
</html>
