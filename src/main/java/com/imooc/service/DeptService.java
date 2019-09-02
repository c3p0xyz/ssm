package com.imooc.service;

import com.imooc.dao.DeptMapper;
import com.imooc.domain.Dept;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DeptService {

    @Autowired
    private DeptMapper deptMapper;

    public List<Dept> getDepts() {
        return deptMapper.selectByExample(null);
    }
}
