package com.imooc.test;

import com.imooc.dao.DeptMapper;
import com.imooc.dao.EmployeeMapper;
import com.imooc.domain.Employee;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:/spring/applicationContext.xml"})
public class MapperTest {

    @Autowired
    private DeptMapper deptMapper;

    @Autowired
    private EmployeeMapper employeeMapper;
    
    @Autowired
    private SqlSession sqlSession;

    @Test
    public void testCRUD(){
       // employeeMapper.insertSelective(new Employee(null,"liu","F","liu@qq.com",2));

        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i=0; i<1000; i++){
            String uid = UUID.randomUUID().toString().substring(0, 5);
            mapper.insertSelective(new Employee(null,uid,"M",uid+"qq.com",2));
        }
        System.out.println("批量添加完成");
    }

}
