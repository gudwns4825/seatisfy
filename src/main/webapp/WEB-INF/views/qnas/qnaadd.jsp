<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%> 
 
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>      
<!DOCTYPE html>
<html>
<head>
<title>Qna 등록</title>
<%@include file="../include/header.jsp"%> 
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
</head>
<body>
<%@include file="../include/navbar.jsp"%>

 <form:form modelAttribute="eee" 
			   action="./add?${_csrf.parameterName}=${_csrf.token}"
	           class="form-horizontal"
	           method = "post"
	           onsubmit="return checkForm();">
	<fieldset>
              <div class="form-group">
                <label for="qtitle">제목</label>
                <form:textarea path="qtitle" name="qtitle" id="qtitle" class="form-control" />
                <form:errors path="qtitle"/>
              </div>
              
              <div class="form-group">
                <label for="qcontent">내용</label>
                <form:textarea path="qcontent" name="qcontent" id="summernote" class="form-control" rows="10"/>
              	<form:errors path="qcontent"/>
              </div>
        
 		<div class="row">
        <div class="col-12">
          <a href="/qnas" class="btn btn-secondary">취소</a>
          <input type="submit" value="등록" class="btn btn-success float-right">
        </div>
      </div>
	</fieldset>
	</form:form> 
	
<%-- <%@include file="../include/footer.jsp"%> --%>
<script>
function checkForm() {
	  // 폼 유효성 검사를 수행
	  if (bindingResult.hasErrors()) {
	    alert("폼을 제출할 수 없습니다.");
	    return false;
	  }

	  // 폼 유효성 검사를 통과하면 true 반환
	  return true;
	}
</script>
 <script>
      $('#summernote').summernote({
        placeholder: 'Hello stand alone ui',
        tabsize: 2,
        height: 400,
        toolbar: [
          ['style', ['style']],
          ['font', ['bold', 'underline', 'clear']],
          ['color', ['color']],
          ['para', ['ul', 'ol', 'paragraph']],
          ['table', ['table']],
          ['insert', ['link', 'picture', 'video']],
          ['view', ['fullscreen', 'codeview', 'help']]
        ]
      });
      

    </script>
    
</body>
</html>