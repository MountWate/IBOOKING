package com.example.ibooking.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.ibooking.common.Result;
import com.example.ibooking.entity.Room;
import com.example.ibooking.entity.Sit;
import com.example.ibooking.service.ReserveService;
import com.example.ibooking.service.RoomService;
import com.example.ibooking.service.SitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/sit")
public class SitController {
    @Autowired
    private RoomService roomService;
    @Autowired
    private SitService sitService;
    @Autowired
    private ReserveService reserveService;

    @GetMapping("/check_sit")
    public Result findPage(@RequestParam Integer pageNum,
                           @RequestParam Integer pageSize,
                           @RequestParam(defaultValue = "") String id
//                                        @RequestParam(defaultValue = "") String nickname
    ) {
        IPage<Sit> page = new Page<>(pageNum, pageSize);
        QueryWrapper<Sit> queryWrapper = new QueryWrapper<>();
        if (!id.equals("")) {
            queryWrapper.like("id", Integer.parseInt(id));
        }
//        queryWrapper.like("nickname", nickname);
//        queryWrapper.orderByDesc("reserved_time");
        queryWrapper.orderByAsc("id");


        // 获取当前用户信息
//        User currentUser = TokenUtils.getCurrentUser();
//        System.out.println("查询当前用户的预约信息============== " + currentUser.getNickname());
        return Result.success(sitService.page(page, queryWrapper));
    }

    @GetMapping("/reserve_sit")
    public Result findRoom(String id) {
        QueryWrapper<Sit> sitQueryWrapper = new QueryWrapper<>();
        sitQueryWrapper.eq("id", Integer.parseInt(id));
        Sit sit = sitService.getOne(sitQueryWrapper);
        if (sit == null){
            return Result.error("500","座位号不存在 ！");
        }
        QueryWrapper<Room> roomQueryWrapper = new QueryWrapper<>();
        roomQueryWrapper.eq("id",sit.getRoomId());
        return Result.success(roomService.getOne(roomQueryWrapper));
    }

    //获取所有未被预约的座位
    @GetMapping("/all_sits")
    public Result allSits() {
        return Result.success(sitService.list());
    }
}
