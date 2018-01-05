<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
	<link rel="stylesheet" href="${APP_PATH }/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${APP_PATH }/css/font-awesome.min.css">
	<link rel="stylesheet" href="${APP_PATH }/css/theme.css">
	<style>
#footer {
    padding: 15px 0;
    background: #fff;
    border-top: 1px solid #ddd;
    text-align: center;
}
	</style>
  </head>
  <body>
 <div class="navbar-wrapper">
      <div class="container">
			<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
			  <div class="container">
				<div class="navbar-header">
				  <a class="navbar-brand" href="index.html" style="font-size:32px;">尚筹网-创意产品众筹平台</a>
				</div>
            <div id="navbar" class="navbar-collapse collapse" style="float:right;">
              <ul class="nav navbar-nav">
                <li class="dropdown">
                  <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="glyphicon glyphicon-user"></i> 张三<span class="caret"></span></a>
                  <ul class="dropdown-menu" role="menu">
                    <li><a href="member.html"><i class="glyphicon glyphicon-scale"></i> 会员中心</a></li>
                    <li><a href="#"><i class="glyphicon glyphicon-comment"></i> 消息</a></li>
                    <li class="divider"></li>
                    <li><a href="index.html"><i class="glyphicon glyphicon-off"></i> 退出系统</a></li>
                  </ul>
                </li>
              </ul>
            </div>
			  </div>
			</nav>

      </div>
    </div>

    <div class="container theme-showcase" role="main">
      <div class="page-header">
        <h1>实名认证 - 申请</h1>
      </div>

		<ul class="nav nav-tabs" role="tablist">
		  <li role="presentation" class="active"><a href="#"><span class="badge">1</span> 基本信息</a></li>
		  <li role="presentation"><a href="#"><span class="badge">2</span> 资质文件上传</a></li>
		  <li role="presentation"><a href="#"><span class="badge">3</span> 邮箱确认</a></li>
		  <li role="presentation"><a href="#"><span class="badge">4</span> 申请确认</a></li>
		</ul>
        
		<form role="form" style="margin-top:20px;">
          <div class="form-group">
            <label for="exampleInputEmail1">真实名称</label>
            <#if loginMember.realname!=null>
	            <input type="text" class="form-control" id="realname" placeholder="请输入真实名称" value="${loginMember.realname }">
	        <#else>
	            <input type="text" class="form-control" id="realname" placeholder="请输入真实名称" value="">
            </#if>
          </div>
          <div class="form-group">
            <label for="exampleInputPassword1">身份证号码</label>
            <#if loginMember.realname!=null>
            	<input type="text" class="form-control" id="cardnum" value="${loginMember.cardnum}" placeholder="请输入身份证号码">
            <#else>
            	<input type="text" class="form-control" id="cardnum" value="" placeholder="请输入身份证号码">
            </#if>
          </div>
          <div class="form-group">
            <label for="exampleInputPassword1">电话号码</label>
            <#if loginMember.realname!=null>
            	<input type="text" class="form-control" id="tel" value="${loginMember.tel}" placeholder="请输入电话号码">
            <#else>
            	<input type="text" class="form-control" id="tel" value="" placeholder="请输入电话号码">
            </#if>
            
          </div>
          <button type="button" onclick="backStep()" class="btn btn-default">上一步</button>
          <button type="button" onclick="nextStep()"  class="btn btn-success">下一步</button>
        </form>

		<hr>
    </div> <!-- /container -->
        <div class="container" style="margin-top:20px;">
            <div class="row clearfix">
                <div class="col-md-12 column">
                    <div id="footer">
                        <div class="footerNav">
                             <a rel="nofollow" href="http://www.atguigu.com">关于我们</a> | <a rel="nofollow" href="http://www.atguigu.com">服务条款</a> | <a rel="nofollow" href="http://www.atguigu.com">免责声明</a> | <a rel="nofollow" href="http://www.atguigu.com">网站地图</a> | <a rel="nofollow" href="http://www.atguigu.com">联系我们</a>
                        </div>
                        <div class="copyRight">
                            Copyright ?2017-2017 atguigu.com 版权所有
                        </div>
                    </div>
                    
                </div>
            </div>
        </div>
    <script src="${APP_PATH }/jquery/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH }/bootstrap/js/bootstrap.min.js"></script>
	<script src="${APP_PATH }/script/docs.min.js"></script>
	<script src="${APP_PATH}/jquery/layer/layer.js"></script>
	<script>
        $('#myTab a').click(function (e) {
          e.preventDefault()
          $(this).tab('show')
        });      
        
        function nextStep() {
            // 更新会员基本信息
            $.ajax({
                type : "POST",
                url  : "${APP_PATH}/member/updateBasicinfo",
                data : {
                    "realname" : $("#realname").val().trim(),
                    "cardnum"  : $("#cardnum").val().trim(),
                    "tel"      : $("#tel").val().trim()
                },
                beforeSend : function(){
                	var realname = $("#realname").val().trim();
                	var cardnum = $("#cardnum").val().trim();
                	var tel = $("#tel").val().trim();
                	if(realname==''){
                		layer.msg("真实名不能为空", {time:1500, icon:5, shift:6});	
                		return false;
                	}
                	var cardnumRet = /^\d{15}|\d{18}$/;
                	if(!cardnumRet.test(cardnum)){
                		layer.msg("身份证格式不正确", {time:1500, icon:5, shift:6});	
                		return false;
                	}
                	var telRet = /^((\d{3,4})|\d{3.4})?\d{7,8}$/;
                	if(!telRet.test(tel)){
                		layer.msg("电话号码格式不正确", {time:1500, icon:5, shift:6});
                		return false;
                	}
                },
                success : function(result) {
                    if ( result.success ) {
                        // 跳转到下一步
                        window.location.href = "${APP_PATH}/member/apply";
                    } else {
                        layer.msg("基本信息更新失败", {time:1500, icon:5, shift:6});
                    }
                }
            });            
        } 

        function backStep() {
            $.ajax({
                type : "POST",
                url  : "${APP_PATH}/member/back",
                data : {backStep:"accttype"},
                success : function(result) {
                    if ( result.success ) {
                        // 跳转到下一步
                        window.location.href = "${APP_PATH}/member/apply";
                    } else {
                        layer.msg("跳转失败", {time:1500, icon:5, shift:6});
                    }
                }
            });            
        } 

        
	</script>
  </body>
</html>