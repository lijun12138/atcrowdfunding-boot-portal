package com.atguigu.atcrowdfunding.portal.contrller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.atguigu.atcrowdfunding.common.bean.Member;
import com.atguigu.atcrowdfunding.common.bean.ProjectTicket;
import com.atguigu.atcrowdfunding.portal.service.ActivitiService;
import com.atguigu.atcrowdfunding.portal.service.MemberService;
import com.atguigu.atcrowdfunding.portal.service.ProjectService;

@Controller
@RequestMapping("/project")
public class ProjectController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private ProjectService projectService;
	
	@Autowired
	private ActivitiService activitiService;

	@RequestMapping("/start")
	public String start() {
		return "projectapply/start";
	}

	@RequestMapping("/apply")
	public String apply(HttpSession session, Map<String, Object> map) {
		Member member = (Member) session.getAttribute("loginMember");

		// 点击"未实名认证"按钮,开始申请
		// 根据登录会员id,查询流程单
		Map<String, Object> param = new HashMap<>();
		param.put("id", member.getId());
		ProjectTicket projectTicket = projectService.queryProjectTicket(param);
		if (projectTicket == null) {
			// 如果流程单为null
			// 启动流程
			String piid = activitiService.startProjectProcess(member.getLoginacct());
			// 保存流程单
			projectTicket = new ProjectTicket();
			projectTicket.setPiid(piid);
			projectTicket.setMemberid(member.getId());
			projectTicket.setStatus("0");
			projectTicket.setPstep("step-1");

			projectService.insertProjectTicket(projectTicket);
			// 跳转到账户类型选择页面
			return "member/step-1";
		} else {
			return "member/" + projectTicket.getPstep();
		}
	}

}
