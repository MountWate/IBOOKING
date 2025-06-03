package com.example.ibooking;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class IbookingApplication {

    public static void main(String[] args) {
        SpringApplication.run(IbookingApplication.class, args);
    }


}
