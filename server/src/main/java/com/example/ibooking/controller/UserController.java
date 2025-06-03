package com.example.ibooking.controller;

import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.SecureUtil;
import cn.hutool.poi.excel.ExcelReader;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.ibooking.common.Constants;
import com.example.ibooking.common.Result;
import com.example.ibooking.controller.dto.UserDTO;
import com.example.ibooking.controller.dto.UserPasswordDTO;
import com.example.ibooking.entity.User;
import com.example.ibooking.service.UserService;
import com.example.ibooking.utils.TokenUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.List;

@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @PostMapping("/login")
    public Result login(@RequestBody UserDTO userDTO) {
        String username = userDTO.getUsername();
        String password = userDTO.getPassword();
        if (StrUtil.isBlank(username) || StrUtil.isBlank(password)) {
            return Result.error(Constants.CODE_400, "参数错误");
        }
        UserDTO dto = userService.login(userDTO);
        return Result.success(dto);
    }

    @PostMapping("/register")
    public Result register(@RequestBody UserDTO userDTO) {
        String username = userDTO.getUsername();
        String password = userDTO.getPassword();
        if (StrUtil.isBlank(username) || StrUtil.isBlank(password)) {
            return Result.error(Constants.CODE_400, "参数错误");
        }
        //查看是否重复,返回错误信息
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("username", username);
        User user = userService.getOne(queryWrapper);
        if (user != null) {
            return Result.error(Constants.CODE_400, "用户名已存在");
        }
        UserDTO dto = userService.register(userDTO);
        return Result.success(dto);
    }

    // 新增或修改
    @PostMapping
    public Result save(@RequestBody User user) {
        if (user.getId() == null && user.getPassword() == null) {  // 新增用户默认密码
            user.setPassword( SecureUtil.md5("123"));
        }
        return Result.success(userService.saveOrUpdate(user));
    }


    // 查询所有数据
    @GetMapping
    public Result findAll() {
        return Result.success(userService.list());
    }

    @GetMapping("/username/{username}")
    public Result findByUsername(@PathVariable String username) {
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("username", username);
        return Result.success(userService.getOne(queryWrapper));
    }

    // 删除
    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        return Result.success(userService.removeById(id));
    }

    // 批量删除
    @PostMapping("/del/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        return Result.success(userService.removeByIds(ids));
    }

    // 分页查询数据
    // @RequestParam 接收 ?pageNum=1&pageSize=10
    // limit 第一个参数 = (pageNum - 1 ) * pageSize

//    @GetMapping("/page")
//    public Map<String, Object> findPage(@RequestParam Integer pageNum,
//                                        @RequestParam Integer pageSize,
//                                        @RequestParam String username) {
//        pageNum = (pageNum - 1 ) * pageSize;
//        List<User> data = userMapper.selectPage(pageNum, pageSize, username);
//        Integer total = userMapper.selectTotal(username);
//        Map<String, Object> res = new HashMap<>();
//        res.put("data", data);
//        res.put("total", total);
//        return res;
//    }

    // 分页查询 mybatis-plus方式
    @GetMapping("/page")
    public Result findPage(@RequestParam Integer pageNum,
                                        @RequestParam Integer pageSize,
                                        @RequestParam(defaultValue = "") String username
//                                        @RequestParam(defaultValue = "") String nickname
    ) {
        IPage<User> page = new Page<>(pageNum, pageSize);
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        if (!username.equals("")) {
            queryWrapper.like("username", username);
        }
//        queryWrapper.like("nickname", nickname);
        queryWrapper.orderByDesc("id");

        // 获取当前用户信息
        User currentUser = TokenUtils.getCurrentUser();
        System.out.println("获取当前用户信息============== " + currentUser.getNickname());
        return Result.success(userService.page(page, queryWrapper));
    }

    @GetMapping("/export")
    public void export(HttpServletResponse response) throws Exception {
        List<User> list = userService.list();
        // 通过工具类创建writer 写出磁盘路径
        // ExcelWritter writer = ExcelUtil.getWriter(filesUploadPath + "/用户信息.xslx"
        // 在内存操作，写出到浏览器
        ExcelWriter writer = ExcelUtil.getWriter(true);
        writer.addHeaderAlias("username", "用户名");
        writer.addHeaderAlias("password", "密码");
        writer.addHeaderAlias("nickname", "昵称");
        writer.addHeaderAlias("email", "邮箱");
        writer.addHeaderAlias("phone", "电话");
        writer.addHeaderAlias("address", "地址");
        writer.addHeaderAlias("createTime", "创建时间");
        writer.addHeaderAlias("avatarUrl", "头像");

        writer.write(list, true);
        // 设置浏览器响应格式
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=utf-8");
        String filename = URLEncoder.encode("用户信息", "UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename=" + filename + ".xlsx");
        // 获取输出流
        ServletOutputStream out = response.getOutputStream();
        // 由输出流返回浏览器
        writer.flush(out, true);
        // 关闭
        out.close();
        writer.close();
    }

    @PostMapping("/import")
    public Result imp(MultipartFile file) throws Exception {
        InputStream inputStream = file.getInputStream();
        ExcelReader reader = ExcelUtil.getReader(inputStream);
        List<User> list = reader.readAll(User.class);
        userService.saveBatch(list);
        return Result.success(true);
    }

    /**
     * 修改密码
     * @param userPasswordDTO
     * @return
     */
    @PostMapping("/password")
    public Result password(@RequestBody UserPasswordDTO userPasswordDTO) {
        userPasswordDTO.setPassword(userPasswordDTO.getPassword());
        userPasswordDTO.setNewPassword(userPasswordDTO.getNewPassword());
        userService.updatePassword(userPasswordDTO);
        return Result.success();
    }

}
