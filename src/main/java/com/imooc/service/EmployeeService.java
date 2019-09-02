package com.imooc.service;

import com.imooc.dao.EmployeeMapper;
import com.imooc.domain.Employee;
import com.imooc.domain.EmployeeExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    private EmployeeMapper employeeMapper;

    public List<Employee> findAll() {
       return employeeMapper.selectByExampleWithDept(null);
    }

    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    public boolean checkUser(String empName) {
        EmployeeExample employeeExample = new EmployeeExample();
        employeeExample.createCriteria().andEmpNameEqualTo(empName);
        long result = employeeMapper.countByExample(employeeExample);
        return result == 0;
    }

    public Employee findById(Integer empId) {
        return employeeMapper.selectByPrimaryKey(empId);
    }

    public int update(Employee employee) {
        return employeeMapper.updateByPrimaryKeySelective(employee);
    }

    public int deleteById(Integer empId) {
        return employeeMapper.deleteByPrimaryKey(empId);
    }

    public int deleteBatch(List<Integer> list) {
        EmployeeExample employeeExample = new EmployeeExample();
        employeeExample.createCriteria().andEmpIdIn(list);
        return employeeMapper.deleteByExample(employeeExample);
    }
}
