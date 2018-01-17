<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
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

      <form class="form-signin" id="doReg" action="doReg.do" role="form" method="post">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i> 用户注册</h2>
		  <div class="form-group has-success has-feedback">
			<input type="text" class="form-control"id="floginacct" value="${RequestParameters.loginacct }" onchange="doChange()" placeholder="请输入登录账号" autofocus>
			<span class="glyphicon glyphicon-user form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<input type="text" class="form-control" id="fusername" value="${RequestParameters.username }" placeholder="请输入用户名称" style="margin-top:10px;">
			<span class="glyphicon glyphicon-user form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<input type="password" class="form-control" value="${RequestParameters.userpswd }" id="fuserpswd" placeholder="请输入登录密码" style="margin-top:10px;">
			<span class="glyphicon glyphicon-lock form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<input type="text"  class="form-control" id="femail" value="${RequestParameters.email }" placeholder="请输入邮箱地址" style="margin-top:10px;">
			<span class="glyphicon glyphicon glyphicon-envelope form-control-feedback"></span>
		  </div>
		  
		  <div class="form-group has-success has-feedback">
			<select class="form-control" id="fusertype" >
                <option value="0">个人</option>
                <option value="1">企业</option>
            </select>
		  </div>
		   <div class="form-group has-success has-feedback">
			<input type="text" class="form-control" id="fcode"  placeholder="请输入验证码" style="margin-top:10px;">
			<span class="glyphicon glyphicon-envelope form-control-feedback"></span>
		  </div>
		   <label><img type="image"  src="${APP_PATH }/auth/code" id="codeImage"  style="cursor:pointer;"/></label> 
<!-- 		  <img id="codeImg" alt="" src="http://localhost/Myatcrowdfunding-main/code.jpg" style="float: right; width:150px ;margin-right: 0px;height: 40px"> <br /> <br /> -->
			
        <div class="checkbox">
          <label>
            忘记密码
          </label>
          <label style="float:right">
            <a href="${APP_PATH }/login">我有账号</a>
          </label>
        </div>
        <a class="btn btn-lg btn-success btn-block" onclick="doReg()" > 注册</a>
      </form>
    </div>
    <script src="${APP_PATH }/jquery/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH }/bootstrap/js/bootstrap.min.js"></script>
    <script src="${APP_PATH }/jquery/layer/layer.js"></script>
    <script type="text/javascript">
    
	    
	    $("#codeImage").click(function(){
	  		this.src="${APP_PATH }/auth/code?"+Math.random();
		});
	    
    	function doChange(){
    		var floginacct = $("#floginacct");
    		$.ajax({
    			type : "post",
    			url : "${APP_PATH }/doCheck",
    			data : {
    				loginacct : floginacct.val()
    			},
    			success : function(result){
    				if(!result.success){
//     					alert(result.message);
    					layer.msg(result.message, {time:1000, icon:5, shift:6}); //弹出时间，图标，特效
    					floginacct.focus();
    					return false;
    				}
    			}
    		})
    	}
    
    	function doReg(){
			
    		var acctRet =/^[a-z0-9_-]{3,16}$/;
    		var floginacct = $("#floginacct");
    		var isTrue = acctRet.test(floginacct.val().trim());
    		if(!isTrue){
    			layer.msg("用户账号为小写字母、下划线或数字组合的3~16位用户账号", {time:2000, icon:5, shift:6}); //弹出时间，图标，特效
    			floginacct.focus();
    			return false;
    		}
    		var fusername = $("#fusername");
    		if(fusername.val().trim()==""){
    			layer.msg("用户名称不能为空！", {time:2000, icon:5, shift:6}); //弹出时间，图标，特效
    			fusername.focus();
    			return false;
    		}
    		
    		var pswdRet = /^[a-z0-9_-]{6,18}$/;
    		var fuserpswd = $("#fuserpswd");
    		var isTrue = pswdRet.test(fuserpswd.val());
    		
    		if(!isTrue){
//     			alert("用户密码为小写字母、下划线或数字组合的6~18位密码");
    			layer.msg("用户密码为小写字母、下划线或数字组合的6~18位密码", {time:2000, icon:5, shift:6}); //弹出时间，图标，特效
    			fuserpswd.focus();
    			return false;
    		}
    		
    		var emailRet = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
    		var femail = $("#femail");
    		var isTrue = emailRet.test(femail.val());
    		
    		if(!isTrue){
//     			alert("邮箱格式不正确，你个煞笔不要乱输，心里没点b数");
    			layer.msg("邮箱格式不正确，你个煞笔不要乱输，心里没点b数", {time:2000, icon:5, shift:6}); //弹出时间，图标，特效
    			femail.focus();
    			return false;
    		}
    		var fcode = $("#fcode");
        	if(fcode.val().trim()==''){
        		layer.msg("验证码不能为空,请重新输入！", {time:2000, icon:5, shift:6}); //弹出时间，图标，特效
        		fcode.focus();
        		return false;
        	}
			var index =-1;
    		var fusertype = $("#fusertype");
    		var loadingIndex=-1;
    		$.ajax({
    			type : "post",
    			url : "${APP_PATH }/doReg",
    			data : {
    				loginacct : floginacct.val(),
    				username : fusername.val(),
    				userpswd : fuserpswd.val(),
    				email : femail.val(),
    				code : fcode.val(),
    				usertype : fusertype.val()
    			},
    			beforeSend : function(){
    				loadingIndex = layer.msg('注册中...', {icon: 16});
    				},
    			success : function(result){
   					layer.close(loadingIndex);
    				if(result.success){
    					window.location.href="${APP_PATH }/login"
//     					layer.msg("正在 跳转到登录页面,使用你注册的账号登录", {time:5000, icon:6, shift:5}); //弹出时间，图标，特效
    				}else{
//     					alert(result.message);
    					layer.msg(result.message, {time:2000, icon:5, shift:6}); //弹出时间，图标，特效
//     					$("#codeImg")[0].src="http://localhost/Myatcrowdfunding-main/code.jpg?"+Math.random();
    					$("#codeImg").src="${APP_PATH }/auth/code?"+Math.random();
    					return false;
    				}
    			}
    		});
    	}
    	
    	
    </script>
  </body>
</html>