package com.example.ibooking.service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.ibooking.entity.Reserve;
import com.example.ibooking.mapper.ReserveMapper;
import org.springframework.stereotype.Service;

@Service
public class ReserveService  extends ServiceImpl<ReserveMapper, Reserve> {
}
