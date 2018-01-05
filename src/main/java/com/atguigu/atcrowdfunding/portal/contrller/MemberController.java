package com.atguigu.atcrowdfunding.portal.contrller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.atguigu.atcrowdfunding.common.BaseController;
import com.atguigu.atcrowdfunding.common.bean.Cert;
import com.atguigu.atcrowdfunding.common.bean.Member;
import com.atguigu.atcrowdfunding.common.bean.MemberCert;
import com.atguigu.atcrowdfunding.common.bean.Ticket;
import com.atguigu.atcrowdfunding.common.util.Const;
import com.atguigu.atcrowdfunding.common.util.Data;
import com.atguigu.atcrowdfunding.portal.service.ActivitiService;
import com.atguigu.atcrowdfunding.portal.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController extends BaseController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private ActivitiService activitiService;

	@ResponseBody
	@RequestMapping("/completeApply")
	public Object completeApply(HttpSession session,String authcode) {
		start();
		
		try {
			//先更新接收邮件的邮箱
			Member loginMember = (Member) session.getAttribute(Const.LOGIN_MEMBER);
			
			Integer id = loginMember.getId();
			Map<String,Object> param = new HashMap<>();
			param.put("id", id);
			Ticket ticket = memberService.queryTicket(param);
			if(authcode.equals(ticket.getAuthcode())) {
				loginMember.setAuthstatus("1");
				memberService.update(loginMember);
				session.setAttribute(Const.LOGIN_MEMBER, loginMember);
				
				ticket.setPstep("apply");
				ticket.setStatus("1");
				memberService.updateTicket(ticket);
				
				Map<String ,Object > variable = new HashMap<>();
				variable.put("falg", true);
				variable.put("piid", ticket.getPiid());
				activitiService.complete(variable);
				
				success();
			}else {
				fail();
				message("验证码不正确");
			}
		} catch (Exception e) {
			e.printStackTrace();
			fail();
			message("发生异常了");
		}
		
		return end();
	}
	@ResponseBody
	@RequestMapping("/restSend")
	public Object restSend(HttpSession session) {
		start();
		try {
			Member loginMember = (Member) session.getAttribute(Const.LOGIN_MEMBER);
			
			Map<String ,Object > variable = new HashMap<>();
			StringBuilder authcode = new StringBuilder();
			for ( int i =0; i< 4; i++ ) {
				authcode.append(new Random().nextInt(10));
			}
			
			//更新数据库中流程单的验证码
			Integer id = loginMember.getId();
			Map<String,Object> param = new HashMap<>();
			param.put("id", id);
			Ticket ticket = memberService.queryTicket(param);
			ticket.setAuthcode(authcode.toString());
			memberService.updateTicket(ticket);
			
			//走重新发送的流程
			variable.put("email", loginMember.getEmail());
			variable.put("authcode", authcode.toString());
			variable.put("piid", ticket.getPiid());
			variable.put("flag", false);
			activitiService.complete(variable);
			success();
		} catch (Exception e) {
			e.printStackTrace();
			fail();
			message("发生异常了");
		}
		
		return end();
	}
	@ResponseBody
	@RequestMapping("/sendAuthcode")
	public Object sendAuthcode(HttpSession session,String email) {
		start();
		
		
		try {
			//先更新接收邮件的邮箱
			Member loginMember = (Member) session.getAttribute(Const.LOGIN_MEMBER);
			loginMember.setEmail(email);
			
			memberService.update(loginMember);
			
			session.setAttribute(Const.LOGIN_MEMBER, loginMember);
			
			//准备流程变量
			Map<String ,Object > variable = new HashMap<>();
			StringBuilder authcode = new StringBuilder();
			for ( int i =0; i< 4; i++ ) {
				authcode.append(new Random().nextInt(10));
			}
			
			Integer id = loginMember.getId();
			Map<String,Object> param = new HashMap<>();
			param.put("id", id);
			Ticket ticket = memberService.queryTicket(param);
			ticket.setPstep("checkauthcode");
			ticket.setAuthcode(authcode.toString());
			memberService.updateTicket(ticket);

			variable.put("email", email);
			variable.put("authcode", authcode.toString());
			variable.put("piid", ticket.getPiid());
			activitiService.complete(variable);
			
			success();
		} catch (Exception e) {
			e.printStackTrace();
			fail();
			message("发生异常了");
		}
		
		
		
		return end();
	}

	@ResponseBody
	@RequestMapping("/uploadCerts")
	public Object uploadCerts(HttpSession session, Data data) {
		start();

		try {
			Member loginMember = (Member) session.getAttribute(Const.LOGIN_MEMBER);

			// 在添加文件之前删除对应的已有的资质图片
			List<MemberCert> list = memberService.queryMemberCert(loginMember.getId());
			for (MemberCert memberCert : list) {
				File file = new File(
						"E:/distributedServer/resources/atcrowdfunding/pic/cert/" + memberCert.getIconpath());
				file.delete();
			}

			// 保存文件
			// 增加数据
			List<MemberCert> mcs = data.getMcs();
			for (MemberCert memberCert : mcs) {
				MultipartFile multipartFile = memberCert.getCertfile();
				String originalFilename = multipartFile.getOriginalFilename();

				String mime = originalFilename.substring(originalFilename.indexOf("."));
				String iconpath = UUID.randomUUID().toString() + mime;

				memberCert.setIconpath(iconpath);
				memberCert.setMemberid(loginMember.getId());

				String realpath = "E:/distributedServer/resources/atcrowdfunding/pic/cert/" + iconpath;
				multipartFile.transferTo(new File(realpath));
				memberCert.setCertfile(null);
			}
			memberService.insertMemberCert(mcs);

			// 更新流程审批单的流程步骤
			Integer id = loginMember.getId();

			Map<String,Object> param = new HashMap<>();
			param.put("id", id);
			Ticket ticket = memberService.queryTicket(param);
			ticket.setPstep("checkemail");

			memberService.updateTicket(ticket);

			Map<String, Object> variable = new HashMap<>();
			variable.put("flag", true);
			variable.put("loginacct", loginMember.getLoginacct());
			variable.put("piid", ticket.getPiid());
			activitiService.complete(variable);
			// 让流程继续执行（taskService.complete(taskId)）

			success();
		} catch (Exception e) {
			e.printStackTrace();
			fail();
			message("发生异常了");
		}

		return end();
	}

	@ResponseBody
	@RequestMapping("/back")
	public Object backBasicinfo(HttpSession session, String backStep) {
		start();

		try {
			Member loginMember = (Member) session.getAttribute(Const.LOGIN_MEMBER);
			Integer id = loginMember.getId();
			
			Map<String,Object> param = new HashMap<>();
			param.put("id", id);
			Ticket ticket = memberService.queryTicket(param);
			ticket.setPstep(backStep);
			// 更新流程单步骤"pstep"="certupload"
			memberService.updateTicket(ticket);

			// 完成当前任务节点
			// 设置流程变量${ flag == false}
			Map<String, Object> variable = new HashMap<>();
			variable.put("flag", false);
			variable.put("loginacct", loginMember.getLoginacct());
			variable.put("piid", ticket.getPiid());
			activitiService.complete(variable);
			success();
		} catch (Exception e) {
			message("发生异常了");
			fail();
			e.printStackTrace();
		}

		return end();
	}

	@ResponseBody
	@RequestMapping("/updateBasicinfo")
	public Object updateBasicinfo(HttpSession session, Member member) {

		start();

		try {
			Member loginMember = (Member) session.getAttribute(Const.LOGIN_MEMBER);
			Integer id = loginMember.getId();
			Map<String,Object> param = new HashMap<>();
			param.put("id", id);
			Ticket ticket = memberService.queryTicket(param);
			ticket.setPstep("certupload");
			loginMember.setRealname(member.getRealname());
			loginMember.setCardnum(member.getCardnum());
			loginMember.setTel(member.getTel());

			session.setAttribute("loginMember", loginMember);
			// 更新会员信息
			memberService.update(loginMember);
			// 更新流程单步骤"pstep"="certupload"
			memberService.updateTicket(ticket);

			// 完成当前任务节点
			// 设置流程变量${ flag == true}
			Map<String, Object> variable = new HashMap<>();
			variable.put("flag", true);
			variable.put("loginacct", loginMember.getLoginacct());
			variable.put("piid", ticket.getPiid());
			activitiService.complete(variable);
			success();
		} catch (Exception e) {
			e.printStackTrace();
			message("发生异常了");
			fail();
		}

		return end();
	}

	@ResponseBody
	@RequestMapping("/updateAccttype")
	public Object updateAccttype(HttpSession session, String accttype) {
		start();

		try {

			Member member = (Member) session.getAttribute(Const.LOGIN_MEMBER);

			member.setAccttype(accttype);

			session.setAttribute("loginMember", member);
			Map<String,Object> param = new HashMap<>();
			param.put("id", member.getId());
			Ticket ticket = memberService.queryTicket(param);

			ticket.setPstep("basicinfo");
			// 更新用户类型
			memberService.update(member);

			// 更新流程单
			memberService.updateTicket(ticket);

			// 更新流程
			Map<String, Object> variable = new HashMap<>();
			variable.put("piid", ticket.getPiid());
			variable.put("loginacct", member.getLoginacct());

			activitiService.complete(variable);
			success();

		} catch (Exception e) {
			e.printStackTrace();
			fail();
			message("发生异常了");
		}

		return end();
	}

	@RequestMapping("/apply")
	public String apply(HttpSession session, Map<String, Object> map) {
		Member member = (Member) session.getAttribute(Const.LOGIN_MEMBER);

		// 点击"未实名认证"按钮,开始申请
		// 根据登录会员id,查询流程单
		Map<String,Object> param = new HashMap<>();
		param.put("id", member.getId());
		Ticket ticket = memberService.queryTicket(param);
		if (ticket == null) {
			// 如果流程单为null
			// 启动流程
			String piid = activitiService.startProcess(member.getLoginacct());
			// 保存流程单
			ticket = new Ticket();
			ticket.setPiid(piid);
			ticket.setMemberid(member.getId());
			ticket.setStatus("0");
			ticket.setPstep("accttype");

			memberService.insertTicket(ticket);
			// 跳转到账户类型选择页面
			return "member/accttype";
		} else {
			// 如果流程单不为null
			// § 根据流程单"pstep"判断,跳转到相关页面.
			if ("certupload".equals(ticket.getPstep())) {
				List<Cert> certs = memberService.queryCert(member.getAccttype());
				map.put("certs", certs);
			}
			return "member/" + ticket.getPstep();
		}
	}

}
