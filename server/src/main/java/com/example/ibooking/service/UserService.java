package com.example.ibooking.service;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.log.Log;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.ibooking.common.Constants;
import com.example.ibooking.controller.dto.UserDTO;
import com.example.ibooking.controller.dto.UserPasswordDTO;
import com.example.ibooking.entity.Menu;
import com.example.ibooking.entity.User;
import com.example.ibooking.exception.ServiceException;
import com.example.ibooking.mapper.RoleMapper;
import com.example.ibooking.mapper.RoleMenuMapper;
import com.example.ibooking.mapper.UserMapper;
import com.example.ibooking.utils.TokenUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Service
public class UserService extends ServiceImpl<UserMapper, User> {

    @Resource
    private RoleMapper roleMapper;

    @Resource
    private UserMapper userMapper;

    @Resource
    private RoleMenuMapper roleMenuMapper;

    @Resource
    private MenuService menuService;
    private static final Log LOG = Log.get();
    public boolean saveUser(User user) {
//        if (user.getId() == null) { // user没有id，则表示是新增
//            return save(user);
//        } else {
//            return updateById(user);
//        }
        return saveOrUpdate(user);
    }

    public UserDTO login(UserDTO userDTO) {
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("username", userDTO.getUsername());
        queryWrapper.eq("password", userDTO.getPassword());
        User one;
        try {
             one = getOne(queryWrapper); // 从数据库查询用户信息
        } catch (Exception e) {
            LOG.error(e);
            throw new ServiceException(Constants.CODE_500, "系统错误");
        }
        if (one != null) {
            BeanUtil.copyProperties(one, userDTO, true);
            String token = TokenUtils.genToken(one.getId().toString(), one.getPassword().toString());
            userDTO.setToken(token);

            String role = one.getRole();
            // 设置用户的菜单列表
            List<Menu> roleMenus = getRoleMenus(role);
            userDTO.setMenus(roleMenus);
            return userDTO;
        } else {
            throw new ServiceException(Constants.CODE_600, "用户名或密码错误");
        }
    }
//    @Autowired
//    private UserMapper userMapper;

//    public int save(User user) {
//        if (user.getId() == null) { // user没有id，则表示是新增
//            return userMapper.insert(user);
//        } else { // 否则为更新
//            return userMapper.update(user);
//        }
//    }

    /**
     * 获取当前角色的菜单列表
     * @param roleFlag
     * @return
     */
    private List<Menu> getRoleMenus(String roleFlag) {
        Integer roleId = roleMapper.selectByFlag(roleFlag);
        // 当前角色的所有菜单id集合
        List<Integer> menuIds = roleMenuMapper.selectByRoleId(roleId);

        // 查出系统所有的菜单(树形)
        List<Menu> menus = menuService.findMenus("");
        // new一个最后筛选完成之后的list
        List<Menu> roleMenus = new ArrayList<>();
        for (int i : menuIds) {
            System.out.println(i);
        }

        // 筛选当前用户角色的菜单
        for (Menu menu : menus) {
            if (menuIds.contains(menu.getId())) {
                roleMenus.add(menu);
            }
            List<Menu> children = menu.getChildren();
            // removeIf()  移除 children 里面不在 menuIds集合中的 元素
            children.removeIf(child -> !menuIds.contains(child.getId()));

            // syf 因为如果勾选父级，那么他的所有子级都会被勾选
//            for (Menu childMenu : children) {
//                if (menuIds.contains(childMenu.getId())) {
//                    roleMenus.add(childMenu);
//                }
//            }

        }
        return roleMenus;
    }

    public void updatePassword(UserPasswordDTO userPasswordDTO) {
        int update = userMapper.updatePassword(userPasswordDTO);
        if (update < 1) {
            throw new ServiceException(Constants.CODE_600, "密码错误");
        }
    }

    public UserDTO register(UserDTO userDTO) {
    //用户注册
        User user = new User();
        BeanUtil.copyProperties(userDTO, user, true);
        // 默认角色ROLE_USER
        user.setRole("ROLE_USER");
        save(user);
        return userDTO;
    }
}
