package com.atguigu.atcrowdfunding.portal.service;

import java.util.Map;

import org.springframework.cloud.netflix.feign.FeignClient;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@FeignClient("atcrowdfunding-activiti-service")
public interface ActivitiService {

	@RequestMapping("act/startProcess")
	String startProcess(@RequestBody String loginacct);

	@RequestMapping("act/complete")
	void complete(@RequestBody Map<String, Object> variable);

	@RequestMapping("act/startProjectProcess")
	String startProjectProcess(@RequestBody String loginacct);

}
