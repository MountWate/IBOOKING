package com.example.ibooking.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.Date;

@TableName("sys_room")
@Data
public class Room {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    private String name;
    private String type;
    private boolean available;
    @JsonFormat(pattern = "HH:mm", timezone = "GMT+8")
    private Date openTime;
    @JsonFormat(pattern = "HH:mm", timezone = "GMT+8")
    private Date closeTime;
}
