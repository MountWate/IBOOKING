package com.example.ibooking.service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.ibooking.entity.Sit;
import com.example.ibooking.entity.User;
import com.example.ibooking.mapper.SitMapper;
import com.example.ibooking.mapper.UserMapper;
import org.springframework.stereotype.Service;

@Service
public class SitService extends ServiceImpl<SitMapper, Sit> {
}
