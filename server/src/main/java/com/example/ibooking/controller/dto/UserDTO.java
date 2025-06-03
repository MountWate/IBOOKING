package com.example.ibooking.controller.dto;

import com.baomidou.mybatisplus.annotation.TableField;
import com.example.ibooking.entity.Menu;
import lombok.Data;

import java.util.List;

/**
 * 接收前端登录请求的参数（和之前的User类区分开）
 */
@Data
public class UserDTO {
    private String username;
    private String password;
    private String nickname;
    @TableField(value = "avatar_url")
    private String avatarUrl;
    private String token;
    private String role;
    private List<Menu> menus;
}
