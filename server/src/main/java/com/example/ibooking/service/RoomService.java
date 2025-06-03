package com.example.ibooking.service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.ibooking.entity.Reserve;
import com.example.ibooking.entity.Room;
import com.example.ibooking.mapper.ReserveMapper;
import com.example.ibooking.mapper.RoomMapper;
import org.springframework.stereotype.Service;

@Service
public class RoomService extends ServiceImpl<RoomMapper, Room> {
}
