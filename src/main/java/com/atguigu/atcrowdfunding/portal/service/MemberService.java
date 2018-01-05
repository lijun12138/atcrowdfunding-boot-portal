package com.atguigu.atcrowdfunding.portal.service;

import java.util.List;
import java.util.Map;

import org.springframework.cloud.netflix.feign.FeignClient;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.atguigu.atcrowdfunding.common.bean.Cert;
import com.atguigu.atcrowdfunding.common.bean.Member;
import com.atguigu.atcrowdfunding.common.bean.MemberCert;
import com.atguigu.atcrowdfunding.common.bean.Ticket;

@FeignClient("atcrowdfunding-member-service")
public interface MemberService {

	@RequestMapping("login/{loginacct}")
	public Member login(@PathVariable("loginacct") String loginacct);

	@RequestMapping("member/queryTicket")
	public Ticket queryTicket(@RequestBody Map<String, Object> param);

	@RequestMapping("member/insertTicket")
	public void insertTicket(@RequestBody Ticket ticket);

	@RequestMapping("member/update")
	public void update(@RequestBody Member member);

	@RequestMapping("member/updateTicket")
	public void updateTicket(@RequestBody Ticket ticket);

	@RequestMapping("member/queryCert")
	public List<Cert> queryCert(@RequestBody String accttype);

	@RequestMapping("member/insertMemberCert")
	public void insertMemberCert(@RequestBody List<MemberCert> mcs);

	@RequestMapping("member/queryMemberCert")
	public List<MemberCert> queryMemberCert(@RequestBody Integer id);

	@RequestMapping("member/queryMemberByParam")
	public Member queryMemberByParam(@RequestBody Map<String, Object> map);

	@RequestMapping("member/check")
	public boolean check(@RequestBody String loginacct);

	@RequestMapping("member/reg")
	public boolean reg(@RequestBody Member member);
}
