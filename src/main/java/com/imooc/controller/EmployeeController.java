package com.imooc.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.imooc.domain.BaseResponse;
import com.imooc.domain.Employee;
import com.imooc.service.EmployeeService;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

    @RequestMapping(value = "emps", method = RequestMethod.GET)
    @ResponseBody
    @ApiOperation(value = "查询列表")
    public BaseResponse getEmps(@RequestParam(value = "pn",defaultValue = "1") Integer pn){
        PageHelper.startPage(pn,5);
        List<Employee> emps = employeeService.findAll();
        PageInfo pageInfo = new PageInfo(emps,5);
        //model.addAttribute("pageInfo",pageInfo);
        return BaseResponse.success().add("pageInfo",pageInfo);
    }

    //  通过jsr后台校验
    @RequestMapping(value = "emp",method = RequestMethod.POST)   // restful风格，post表示保存
    @ResponseBody
    public BaseResponse saveEmp(@Valid Employee employee, BindingResult result){
        Map<String,Object> map = new HashMap<>();
        if (result.hasErrors()){
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError error : errors) {
                map.put(error.getField(), error.getDefaultMessage());
            }
            return BaseResponse.fail().add("errField",map);
        }else {
            employeeService.saveEmp(employee);
            return BaseResponse.success();
        }
    }

    // 通过id查询员工信息
    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.GET)
    @ResponseBody
    @ApiOperation(value = "根据id查询员工信息")
    public BaseResponse getEmpById(@PathVariable(value = "empId") Integer empId){
        Employee employee = employeeService.findById(empId);
        if (employee != null){
            return BaseResponse.success().add("employee",employee);
        }
        return null;
    }

    /*
         ajax 不能直接发送PUT请求引发的血案：
         put请求，请求体中的数据，request.Parameter("empName")拿不到
         tomcat 一看是put请求，就不会封装请求体，只有post请求才封装请求体
         解决办法，在web.xml中配置HttpPutFormContentFilter过滤器，该过滤器能识别put petch并将之自动转换为post
    */

    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
    @ResponseBody
    @ApiOperation(value = "修改用户信息")
    public BaseResponse updateEmp(Employee employee){
       int ret = employeeService.update(employee);
       if (ret != 0){
           return BaseResponse.success();
       }else {
           return BaseResponse.fail();
       }
    }

    @RequestMapping(value = "checkUser", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "校验用户名")
    public BaseResponse checkUser(String empName){
        String regex = "(^[a-zA-Z0-9_-]{3,16}$)|(^[\\u2E80-\\u9FFF]{2,6}$)";
        if(!empName.matches(regex)){
            return BaseResponse.fail().add("val_msg","用户名必须是3-16位英文或2-6位汉字");
        }
        boolean flag = employeeService.checkUser(empName);
        if (flag){
            return BaseResponse.success();
        }
        return BaseResponse.fail().add("val_msg","用户名不可用");
    }

    // 单个批量删除用户信息
    @RequestMapping(value = "/emp/{empIds}", method = RequestMethod.DELETE)
    @ResponseBody
    public BaseResponse deleteById(@PathVariable(value = "empIds") String empIds){
        if (empIds.contains("-")){
            List<Integer> list = new ArrayList<>();
            String[] ids = empIds.split("-");
            for (String id : ids) {
                list.add(Integer.parseInt(id));
            }
            int ret = employeeService.deleteBatch(list);
            if (ret != 0){
                return BaseResponse.success();
            }
        }else {
            int empId = Integer.parseInt(empIds);
            int ret = employeeService.deleteById(empId);
            if (ret != 0){
                return BaseResponse.success();
            }
        }
        return BaseResponse.fail();
    }

}
