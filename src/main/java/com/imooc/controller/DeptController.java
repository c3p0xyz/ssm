package com.imooc.controller;

import com.imooc.domain.BaseResponse;
import com.imooc.domain.Dept;
import com.imooc.service.DeptService;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DeptController {

    @Autowired
    private DeptService deptService;

    @RequestMapping(value = "depts", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "查询部门信息")
    public BaseResponse getDepts(){
       List<Dept> depts = deptService.getDepts();
       return BaseResponse.success().add("depts",depts);
    }
}
