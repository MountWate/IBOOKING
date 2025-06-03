package com.example.ibooking.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.ibooking.common.EmailSender;
import com.example.ibooking.common.Result;
import com.example.ibooking.entity.Reserve;
import com.example.ibooking.entity.Room;
import com.example.ibooking.entity.User;
import com.example.ibooking.service.ReserveService;
import com.example.ibooking.service.RoomService;
import com.example.ibooking.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/home")
public class InfoController {

    @Autowired
    private ReserveService reserveService;
    @Autowired
    private RoomService roomService;
    @Autowired
    private UserService userService;


    //查询系统信息
    @GetMapping("/info")
    public Result info() {
        //获取今天日期
        Date today = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String formattedDate = dateFormat.format(today);


        Map<String,Integer> map = new HashMap<String,Integer>();
        //获取用户数量
        int userNumber = userService.count();
        //获取教室数量
        int roomNumber = roomService.count();
        //查询今日预约
        QueryWrapper<Reserve> reserveQueryWrapper = new QueryWrapper<>();
        reserveQueryWrapper.like("start_time",formattedDate);
        //今日预约数量
        int reserveNumber = reserveService.count(reserveQueryWrapper);
        //教室分类数目
        QueryWrapper<Room> roomQueryWrapper = new QueryWrapper<>();
        roomQueryWrapper.eq("type",0);
        int smallRoom = roomService.count(roomQueryWrapper);
        roomQueryWrapper.clear();
        roomQueryWrapper.eq("type",1);
        int largeRoom = roomService.count(roomQueryWrapper);
        roomQueryWrapper.clear();
        roomQueryWrapper.eq("type",2);
        int readingRoom = roomService.count(roomQueryWrapper);
        roomQueryWrapper.clear();
        roomQueryWrapper.eq("type",3);
        int library = roomService.count(roomQueryWrapper);
        //预约分类统计
        reserveQueryWrapper.eq("break_contract",true);
        int breakNumber = reserveService.count(reserveQueryWrapper);
        reserveQueryWrapper.clear();
        reserveQueryWrapper.like("start_time",formattedDate);
        reserveQueryWrapper.eq("check_in_time",true);
        int checkInNumber = reserveService.count(reserveQueryWrapper);
        reserveQueryWrapper.clear();
        reserveQueryWrapper.like("start_time",formattedDate);
        reserveQueryWrapper.eq("cancle",true);
        int cancleNumber = reserveService.count(reserveQueryWrapper);

        int otherNumber = reserveNumber - breakNumber - checkInNumber - cancleNumber;

        map.put("userNumber",userNumber);
        map.put("roomNumber",roomNumber);
        map.put("reserveNumber",reserveNumber);
        map.put("smallRoom",smallRoom);
        map.put("largeRoom",largeRoom);
        map.put("readingRoom",readingRoom);
        map.put("library",library);
        map.put("breakNumber",breakNumber);
        map.put("checkInNumber",checkInNumber);
        map.put("cancleNumber",cancleNumber);
        map.put("otherNumber",otherNumber);

        return Result.success(map);
    }

    //查询今日预约信息
    @GetMapping("/today_reserve")
    public Result findPage(@RequestParam Integer pageNum,
                           @RequestParam Integer pageSize) {

        //获取今天日期
        Date today = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String formattedDate = dateFormat.format(today);

        IPage<Reserve> page = new Page<>(pageNum, pageSize);
        QueryWrapper<Reserve> reserveQueryWrapper = new QueryWrapper<>();
        reserveQueryWrapper.like("start_time",formattedDate);
        reserveQueryWrapper.orderByAsc("id");
        //获取今日预约
//        List<Reserve> reserveList = reserveService.list(reserveQueryWrapper);

        return Result.success(reserveService.page(page,reserveQueryWrapper));
    }

//    //查询今日预约信息
//    @GetMapping("/today_echart")
//    public Result chart() {
//        QueryWrapper<Room> roomQueryWrapper = new QueryWrapper<>();
//        roomQueryWrapper.eq("type",0);
//        int smallRoom = roomService.count(roomQueryWrapper);
//
//        roomQueryWrapper.clear();
//        roomQueryWrapper.eq("type",1);
//        int largeRoom = roomService.count(roomQueryWrapper);
//
//        roomQueryWrapper.clear();
//        roomQueryWrapper.eq("type",2);
//        int readingRoom = roomService.count(roomQueryWrapper);
//
//        roomQueryWrapper.clear();
//        roomQueryWrapper.eq("type",3);
//        int library = roomService.count(roomQueryWrapper);
//
//
//        //获取今日预约
//        List<Reserve> reserveList = reserveService.list(reserveQueryWrapper);
//
//        return Result.success(reserveList);
//    }

}
