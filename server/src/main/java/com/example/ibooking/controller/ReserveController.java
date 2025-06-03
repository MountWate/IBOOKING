package com.example.ibooking.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.ibooking.common.EmailSender;
import com.example.ibooking.common.Result;
import com.example.ibooking.entity.Reserve;
import com.example.ibooking.entity.User;
import com.example.ibooking.service.ReserveService;
import com.example.ibooking.service.UserService;
import com.example.ibooking.utils.TokenUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

@Component
@RestController
@RequestMapping("/reserve")
public class ReserveController {

    @Autowired
    private ReserveService reserveService;
    @Autowired
    private EmailSender emailSender;
    @Autowired
    private UserService userService;

    //查询预约信息，通过用户id查询，分页为-1时查询全部
    @GetMapping("/check_reserve")
    public Result findPage(@RequestParam Integer pageNum,
                           @RequestParam Integer pageSize,
                           @RequestParam(defaultValue = "") String username
//                                        @RequestParam(defaultValue = "") String nickname
    ) {
        IPage<Reserve> page = new Page<>(pageNum, pageSize);
        QueryWrapper<Reserve> queryWrapper = new QueryWrapper<>();
        if (!username.equals("admin")) {
            queryWrapper.like("username", username);
        }
//        queryWrapper.like("nickname", nickname);
//        queryWrapper.orderByDesc("reserved_time");
        queryWrapper.orderByAsc("start_time");


        // 获取当前用户信息
//        User currentUser = TokenUtils.getCurrentUser();
//        System.out.println("查询当前用户的预约信息============== " + currentUser.getNickname());
        return Result.success(reserveService.page(page, queryWrapper));
    }

    //更新预约，包括取消预约，签到
    //取消预约
    @PostMapping("/cancel_reserve")
    public Result updateReserve(@RequestBody Reserve reserve) {
//        System.out.println("reserve");
        QueryWrapper<Reserve> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("id",reserve.getId());
        Reserve new_reserve=reserveService.getOne(queryWrapper);
        new_reserve.setCancle(true);
        return Result.success(reserveService.update(new_reserve,queryWrapper));
//        return Result.success();
    }
    //签到
    @PostMapping("confirm_reserve")
    public Result confirmReserve(@RequestBody Reserve reserve) {
//        System.out.println("reserve");
        QueryWrapper<Reserve> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("id",reserve.getId());
        Reserve new_reserve=reserveService.getOne(queryWrapper);

        new_reserve.setCheckInTime(true);
        return Result.success(reserveService.update(new_reserve,queryWrapper));
//        return Result.success();
    }


    //创建预约
    @PostMapping("/create_reserve")
    public Result createReserve(@RequestBody Reserve reserve) {
        //判断是否冲突
        //增加当前reservedTime
        reserve.setReservedTime(new Date());
        return Result.success(reserveService.save(reserve));
//        return Result.success();
    }


    //定时更新reserve表
    @Scheduled(fixedDelay = 60000) // 每分钟执行一次任务
    public void checkAndSetBreakContract() {
        //测试邮件
        emailSender.sendEmail("23212010026@m.fudan.edu.cn", "签到提醒", "您预约的自习室座位将在十五分钟后开始签到，请及时签到！");

        // 获取当前时间
        Date now = new Date();

        //设置条件
        QueryWrapper<Reserve> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("break_contract",false);
        queryWrapper.eq("check_in_time",false);
        queryWrapper.eq("cancle",false);

        // 获取超时未签到的预约列表
        List<Reserve> overdueReserves = reserveService.list(queryWrapper);

        // 更新超时未签到的预约记录
        for (Reserve reserve : overdueReserves) {
            System.out.println("———————————遍历预约，查看是否有预约过期———————————");
            System.out.println(reserve);
            Date startTime=reserve.getStartTime();


            // 将 Date 转换为 LocalDateTime
            LocalDateTime localDateTime1 = LocalDateTime.ofInstant(now.toInstant(), ZoneId.systemDefault());
            LocalDateTime localDateTime2 = LocalDateTime.ofInstant(startTime.toInstant(), ZoneId.systemDefault());

            //获取用户信息
            QueryWrapper<User> userQueryWrapper = new QueryWrapper<>();
            userQueryWrapper.eq("username",reserve.getUsername());
            User user = userService.getOne(userQueryWrapper);


            /**
             * 发送邮件
             *
             * @param recipient 收件人邮箱地址
             * @param subject   邮件主题
             * @param body      邮件内容
             */
            String recipient = user.getEmail();
            String subject = "";
            String body = "";

            // 计算时间差（分钟）
            long minutesDifference = ChronoUnit.MINUTES.between(localDateTime2, localDateTime1);

            if (minutesDifference >= 15) {
                System.out.println("两个日期相差十五分钟以上，违约");
                QueryWrapper<Reserve> updateWrapper = new QueryWrapper<>();
                updateWrapper.eq("id",reserve.getId());
                reserve.setBreakContract(true);
                user.setDefaults(user.getDefaults() + 1);
                System.out.println(user);
                reserveService.update(reserve,updateWrapper);
                userService.saveUser(user);
            } else if (minutesDifference == 10){
                System.out.println("需要提醒 过期10min");
                subject="签到即将到期提醒";
                body="您预约的自习室座位签到时间已超过10min未签到，请及时签到！";
                emailSender.sendEmail(recipient, subject, body);
            }else if (minutesDifference == -15){
                System.out.println("需要提醒 未过期15min");
                subject="签到提醒";
                body="您预约的自习室座位将在十五分钟后开始签到，请及时签到！";
                emailSender.sendEmail(recipient, subject, body);
            }else {
                System.out.println("未过期和不需要提醒");
            }
        }
    }
}
