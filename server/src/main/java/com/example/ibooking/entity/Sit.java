package com.example.ibooking.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@TableName("sys_sit")
@Data
public class Sit {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    private Integer roomId;
    private boolean chargeport;
    @TableField(exist = false)
    private boolean available = true;
}
