package com.atguigu.atcrowdfunding.portal.service;

import java.util.Map;

import org.springframework.cloud.netflix.feign.FeignClient;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.atguigu.atcrowdfunding.common.bean.ProjectTicket;

@FeignClient("atcrowdfunding-member-service")
public interface ProjectService {

	@RequestMapping("project/queryProjectTicket")
	ProjectTicket queryProjectTicket(@RequestBody Map<String, Object> param);

	@RequestMapping("project/insertProjectTicket")
	void insertProjectTicket(@RequestBody ProjectTicket projectTicket);


}
