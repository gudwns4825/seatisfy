<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세보기</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
</head>
<body>

	 <div class="card">
		<h5 class="card-header">제목 : ${notice.ntitle}</h5>
		<div class="card-body">
			<h5 class="card-title">내용 : ${notice.ncontent}</h5>
			
 
			<div class="d-flex justify-content-end badge bg-light text-dark">작성일자 : ${notice.regDate}</div>
		</div>
	</div>
	
	<form action="/notice/list">
		<input type="submit" value="목록으로" />
	</form>
	<a href="/notice/update?nno=${notice.nno}">수정</a>
	<form method="POST" action="/notice/remove?nno=${notice.nno }">
		<input type="submit" value="삭제" />
	</form>




<!-- 댓글 시작 -->

<hr>

<div class="card">
		<div class="card-body">댓글 리스트</div>
		
		
		<b>${cnt }개의 답변이 있습니다.</b>
		<c:forEach items="${replyList}" var="reply">
		<div class="card">
				<div class="card-header">
					작성자 : <b>${reply.rwriter}</b>
					</div>
					<div class="card-body">
    <blockquote class="blockquote mb-0">
					<p id="updateReply">${reply.rcontent }</p>
					<div class="d-flex justify-content-end">
      <footer class="blockquote-footer">${reply.regDate}</footer>
      <button id="modBtn" type="button" class="btn btn-warning" data-dismiss="modal" onclick="editReply(${reply.rno}, '${reply.rcontent}')">수정</button>
						<form method="POST" action="/reply/remove">
						<input type="hidden" name="nno" value="${notice.nno }">
						<input type="hidden" name="rno" value="${reply.rno }">
						<button class="btn btn-danger" data-dismiss="modal">삭제</button>
						</form> 
      </div>
    </blockquote>
  </div>
</div>
			
			
			<br>
</c:forEach>
</div>
						
					<hr>



<div>

<!-- 댓글 등록 -->
	<form method="post" action="/reply/write">
	<div class="card text-center">
  <div class="card-header">
		<p>
			<label>댓글 작성자</label> <input type="text" name="rwriter">
		</p>
		</div>
		<div class="card-body">
    <h5 class="card-title">답변 등록</h5>
    <p class="card-text">
			<textarea rows="5" cols="50" name="rcontent"></textarea>
		</p>
		<p>
			<input type="hidden" name="nno" value="${notice.nno }">
			<button type="submit">댓글 작성</button>
		</p>
		</div>
		</div>
	</form>
	
</div> 


<!-- 댓글 끝  -->

<script>




</script>










<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>