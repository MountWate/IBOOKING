package com.example.ibooking.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.ibooking.controller.dto.UserPasswordDTO;
import com.example.ibooking.entity.User;
import org.apache.ibatis.annotations.*;

//@Mapper
public interface UserMapper extends BaseMapper<User> {
//    @Select("select * from user")
//    List<User> findAll();
//
//    @Insert("insert into user(username, password, nickname, email, phone, address) " +
//            "values (#{username}, #{password}, #{nickname}, #{email}, #{phone}, #{address})")
//    int insert(User user);
//
//    int update(User user);
//
//    @Delete("delete from user where id = #{id}")
//    Integer deleteById(@Param("id") Integer id);
//
//    @Select("select * from user where username like concat('%', #{username}, '%') limit #{pageNum}, #{pageSize}")
//    List<User> selectPage(Integer pageNum, Integer pageSize, String username);
//
//    @Select("select count(*) from user where username like concat('%', #{username}, '%')")
//    Integer selectTotal(String username);
    @Update("update user set password = #{newPassword} where username = #{username} and password = #{password}")
    int updatePassword(UserPasswordDTO userPasswordDTO);
}
