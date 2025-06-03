package com.example.ibooking.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.ibooking.common.Result;
import com.example.ibooking.entity.Reserve;
import com.example.ibooking.entity.Room;
import com.example.ibooking.entity.Sit;
import com.example.ibooking.service.ReserveService;
import com.example.ibooking.service.RoomService;
import com.example.ibooking.service.SitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/room")
public class RoomController {
    @Autowired
    private RoomService roomService;
    @Autowired
    private SitService sitService;
    @Autowired
    private ReserveService reserveService;

    //查询教室信息
    @GetMapping("/check_room")
    public Result findPage(@RequestParam Integer pageNum,
                           @RequestParam Integer pageSize,
                           @RequestParam(defaultValue = "") String name
//                                        @RequestParam(defaultValue = "") String nickname
    ) {
        IPage<Room> page = new Page<>(pageNum, pageSize);
        QueryWrapper<Room> queryWrapper = new QueryWrapper<>();
        if (!name.equals("")) {
            queryWrapper.like("name", name);
        }
//        queryWrapper.like("nickname", nickname);
//        queryWrapper.orderByDesc("reserved_time");
        queryWrapper.orderByAsc("id");


        // 获取当前用户信息
//        User currentUser = TokenUtils.getCurrentUser();
//        System.out.println("查询当前用户的预约信息============== " + currentUser.getNickname());
        return Result.success(roomService.page(page, queryWrapper));
    }

    //查询教室中座位信息
    @GetMapping("/check_sits")
    public Result findSitPage(
            @RequestParam Integer id,
            @RequestParam String day,
            @RequestParam String start,
            @RequestParam String end
//                                        @RequestParam(defaultValue = "") String nickname
    ) throws ParseException {
        String startStr = day + ' ' + start;
        String endStr = day + ' ' + end;

        String pattern = "yyyy-MM-dd HH:mm";
        SimpleDateFormat dateFormat = new SimpleDateFormat(pattern);

        Date startDate = dateFormat.parse(startStr);
        Date endDate = dateFormat.parse(endStr);

        QueryWrapper<Sit> queryWrapper = new QueryWrapper<>();
        queryWrapper.like("room_id", id);
        queryWrapper.orderByAsc("id");
        List<Sit> sitList = sitService.list(queryWrapper);
        for (Sit sit : sitList) {
            // 处理元素
            QueryWrapper<Reserve> queryReserve = new QueryWrapper<>();
            queryReserve.eq("sit_id", sit.getId());
            List<Reserve> reserveList = reserveService.list(queryReserve);
            for (Reserve reserve : reserveList) {
                Date startTime = reserve.getStartTime();
                Date endTime = reserve.getEndTime();
                // 获取当前时间
//                Date now = new Date();
//                System.out.println("-------------------");
//                System.out.println(startTime);
//                System.out.println(endTime);
//                System.out.println(now);
                if (reserve.isCancle() || reserve.isBreakContract()) {
                    continue;
                }
                if ((!startDate.before(startTime) && startDate.before(endTime))||(endDate.after(startTime) && !endDate.after(endTime))) {
//                    System.out.println("now 在 startTime 和 endTime 之间");
                    sit.setAvailable(false);
                    break;
                } else {
//                    System.out.println("now 不在 startTime 和 endTime 之间");
                    sit.setAvailable(true);
                }
            }
        }
        return Result.success(sitList);
    }


    //查询具体座位是否可用
    @GetMapping("/check_sit")
    public Result findSit(@RequestParam Integer id) {
//        QueryWrapper<Sit> queryWrapper = new QueryWrapper<>();
//        queryWrapper.like("room_id", id);
//        queryWrapper.orderByAsc("id");
//        List<Sit> sitList = sitService.list(queryWrapper);
//        for (Sit sit : sitList) {
        // 处理元素
        QueryWrapper<Reserve> queryReserve = new QueryWrapper<>();
        queryReserve.eq("sit_id", id);
        List<Reserve> reserveList = reserveService.list(queryReserve);
        for (Reserve reserve : reserveList) {
            Date startTime = reserve.getStartTime();
            Date endTime = reserve.getEndTime();
            // 获取当前时间
            Date now = new Date();
//                System.out.println("-------------------");
//                System.out.println(startTime);
//                System.out.println(endTime);
//                System.out.println(now);
            if (reserve.isCancle() || reserve.isBreakContract()) {
                continue;
            }
            if (now.after(startTime) && now.before(endTime)) {
//                    System.out.println("now 在 startTime 和 endTime 之间");
//                sit.setAvailable(false);
                return Result.success(false);
//                break;
            }
        }
//        }
        return Result.success(true);
    }


    //更新教室
    @PostMapping("/update_room")
    public Result updateReserve(@RequestBody Room room) {
//        System.out.println("reserve");
        QueryWrapper<Room> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("id", room.getId());
        return Result.success(roomService.update(room, queryWrapper));
//        return Result.success();
    }

    //创建教室
    @PostMapping("/create_room")
    public Result createReserve(@RequestBody Room room) {
        roomService.save(room);
//        System.out.println("--------------------------------");
//        System.out.println(room.getId());
        Sit sit = new Sit();
        sit.setRoomId(room.getId());
        sit.setChargeport(false);

        //新建教室时创建二十个座位
        for (int i = 0; i < 20; i++) {
            sitService.save(sit);
        }
        return Result.success();
//        return Result.success();
    }

    //删除教室
    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        return Result.success(roomService.removeById(id));
    }

    //批量删除教室
    @PostMapping("/del/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        return Result.success(roomService.removeByIds(ids));
    }
}

