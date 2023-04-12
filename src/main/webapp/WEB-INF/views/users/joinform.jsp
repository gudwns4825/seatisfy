<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
</head>
<body>

	
	<form:form modelAttribute="user" 
			   action="./join?${_csrf.parameterName}=${_csrf.token}"
	           class="form-horizontal"
	           method="post">
	<fieldset>
		아이디 : <form:input path="username" class="form-control"/>
		<form:errors path="username"/>
		<br>
		비밀번호 : <form:input path="password" type="password" class="form-control"/>
		<form:errors path="password"/>
		<br>
		비밀번호 확인 : <form:input path="passwordConfirm" type="password" class="form-control"/>
		<form:errors path="passwordConfirm" cssClass="error" />
		<br>
		이름 : <form:input path="name" class="form-control"/>
		<form:errors path="name"/>
		<br>
		휴대폰 : <form:input path="phone" class="form-control"/>
		<form:errors path="phone"/>
		<br>
		<input type="submit" class="btn btn-primary" value="등록" />
	
	</fieldset>
	</form:form>



</body>
</html>