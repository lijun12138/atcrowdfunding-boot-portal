package com.atguigu.atcrowdfunding.portal;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.netflix.feign.EnableFeignClients;

@EnableFeignClients
@EnableDiscoveryClient
@SpringBootApplication
@ServletComponentScan
public class AtcrowdfundingBootPortalApplication {

	public static void main(String[] args) {
		SpringApplication.run(AtcrowdfundingBootPortalApplication.class, args);
	}
	
}
