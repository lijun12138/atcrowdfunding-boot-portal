package com.atguigu.atcrowdfunding.portal.web.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class PortalServetStartupListener implements ServletContextListener {

	public PortalServetStartupListener() {
		System.out.println("PortalServetStartupListener...");
	}

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		ServletContext application = sce.getServletContext();
		String path = application.getContextPath();
		application.setAttribute("APP_PATH", path);
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
	}

}
