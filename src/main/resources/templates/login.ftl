<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="keys" content="">
    <meta name="author" content="">
	<link rel="stylesheet" href="${APP_PATH }/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${APP_PATH }/css/font-awesome.min.css">
	<link rel="stylesheet" href="${APP_PATH }/css/login.css">
	<style>

	</style>
  </head>
  <body>
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <div><a class="navbar-brand" href="index.htm" style="font-size:32px;">尚筹网-创意产品众筹平台</a></div>
        </div>
      </div>
    </nav>

    <div class="container">

      <form id="doLogin" class="form-signin"  method="post">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i> 用户登录</h2>
		  <div class="form-group has-success has-feedback">
			<input type="text" class="form-control" id="floginacct" value="${param.loginacct }" placeholder="请输入登录账号" autofocus>
			<span class="glyphicon glyphicon-user form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<input type="password" class="form-control" id="fuserpswd" value="${param.userpswd }" placeholder="请输入登录密码" style="margin-top:10px;">
			<span class="glyphicon glyphicon-lock form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<input type="text" class="form-control" id="fcode"  placeholder="请输入验证码" style="margin-top:10px;">
			<span class="glyphicon glyphicon-envelope form-control-feedback"></span>
		  </div>
		  <label><img type="image"  src="${APP_PATH }/auth/code" id="codeImage"  style="cursor:pointer;"/></label> 
<!-- 		  <img id="codeImg" onclick="changeCode()"  src="http://localhost/Myatcrowdfunding-main/code.jpg" style="float: right; width:150px ;margin-right: 0px;height: 40px"> <br /> <br /> -->
			
							
        <div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me"> 记住我
          </label>
          <br>
          <label>
            忘记密码
          </label>
          <label style="float:right">
            <a href="${APP_PATH }/member/reg">我要注册</a>
          </label>
        </div>
        <a class="btn btn-lg btn-success btn-block" onclick="dologin()" > 登录</a>
      </form>
    </div>
    <script src="${APP_PATH }/jquery/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH }/bootstrap/js/bootstrap.min.js"></script>
    <script src="${APP_PATH }/jquery/layer/layer.js"></script>
    <script>
    
    
  	$("#codeImage").click(function(){
  		this.src="${APP_PATH }/auth/code?"+Math.random();
	}); 
  	
  	$("#codeImg").click(function(){
		this.src="code.jpg?"+Math.random();
	}); 
  	
    function dologin() {
    	
    	var floginacct = $("#floginacct");
    	if(floginacct.val().trim()==''){
//     		alert ("用户名不能为空");
    		layer.msg("用户名不能为空,请重新输入！", {time:2000, icon:5, shift:6}); //弹出时间，图标，特效
    		floginacct.focus();
    		return false;
    	}
    	var fuserpswd = $("#fuserpswd");
    	if(fuserpswd.val().trim()==''){
//     		alert ("密码不能为空");
    		layer.msg("密码不能为空,请重新输入！", {time:2000, icon:5, shift:6}); //弹出时间，图标，特效
    		fuserpswd.focus();
    		return false;
    	}
    	var fcode = $("#fcode");
    	if(fcode.val().trim()==''){
//     		alert ("密码不能为空");
    		layer.msg("验证码不能为空,请重新输入！", {time:2000, icon:5, shift:6}); //弹出时间，图标，特效
    		fcode.focus();
    		return false;
    	}
	    $.ajax({
	       	type : "post",
	       	url : "${APP_PATH}/doLogin",
	       	data : {
	       		loginacct : floginacct.val(),
	       		userpswd : fuserpswd.val(),
	       		code : fcode.val(),
	       	},
	       	beforeSend:function(){
	       		loadingIndex = layer.msg('登录中...', {icon: 16});
	       		return true;
	       	},
	       	success:function(result){
	       		layer.close(loadingIndex);
	       		if(result.success){
	       			window.location.href="${APP_PATH}/member";
	       		}else{
	//      			alert(result.message);
	       			layer.msg(result.message, {time:2000, icon:5, shift:6}); //弹出时间，图标，特效
// 	       			$("#codeImg")[0].src="code.jpg?"+Math.random();
	       			$("#codeImg").src="${APP_PATH }/auth/code?"+Math.random();
	       			return false;
	       		}
	       	}
	       });
    }
    </script>
  </body>
</html>