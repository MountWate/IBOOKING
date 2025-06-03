package com.example.ibooking.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.Date;

@TableName("sys_reserve")
@Data
public class Reserve {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    private String username;
    private Integer roomId;
    private Integer sitId;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
    private Date startTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
    private Date endTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
    private Date reservedTime;
    private boolean breakContract = false;
    private boolean checkInTime = false;
    private boolean cancle = false;
}
